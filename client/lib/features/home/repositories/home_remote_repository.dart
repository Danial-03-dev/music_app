import 'dart:convert';

import 'package:client/core/constants/server_constants.dart';
import 'package:client/core/failure/failure.dart';
import 'package:client/core/utils/utils.dart';
import 'package:client/features/home/models/audio_model.dart';
import 'package:fpdart/fpdart.dart' as fpdart;
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_remote_repository.g.dart';

@riverpod
HomeRemoteRepository homeRepository(Ref ref) {
  return HomeRemoteRepository();
}

class HomeRemoteRepository {
  final _audioURI = '${ServerConstants.serverURL}/audio';

  Future<fpdart.Either<Failure, String>> uploadAudio({
    required PickedImage image,
    required PickedMedia audio,
    required String audioName,
    required String artist,
    required String hexCode,
    required String token,
  }) async {
    final audioMime = lookupMimeType(
      audio.name ?? '',
      headerBytes: audio.bytes!,
    );
    final imageMime = lookupMimeType(
      image.name ?? '',
      headerBytes: image.bytes!,
    );

    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$_audioURI/upload'),
      );

      request
        ..files.addAll([
          http.MultipartFile.fromBytes(
            'image',
            image.bytes!,
            filename: image.name,
            contentType: MediaType(
              imageMime!.split('/')[0],
              imageMime.split('/')[1],
            ),
          ),
          http.MultipartFile.fromBytes(
            'audio',
            audio.bytes!,
            filename: audio.name,
            contentType: MediaType(
              audioMime!.split('/')[0],
              audioMime.split('/')[1],
            ),
          ),
        ])
        ..fields.addAll({'name': audioName, 'artist': artist, 'color': hexCode})
        ..headers.addAll({'Authorization': 'Bearer $token'});

      final response = await request.send();
      final responseString = await response.stream.bytesToString();

      if (response.statusCode != 201) {
        return fpdart.Left(Failure(message: responseString));
      }

      return fpdart.Right(responseString);
    } catch (e) {
      return fpdart.Left(Failure(message: e.toString()));
    }
  }

  Future<fpdart.Either<Failure, List<AudioModel>>> getAudioList({
    required String token,
  }) async {
    try {
      final response = await http.get(
        Uri.parse('$_audioURI/list'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      var responseBodyMap = jsonDecode(response.body);

      if (response.statusCode != 200) {
        responseBodyMap = responseBodyMap as Map<String, dynamic>;
        return fpdart.Left(Failure(message: responseBodyMap['message']));
      }

      responseBodyMap = responseBodyMap as List;

      final List<AudioModel> audios = [];
      for (final map in responseBodyMap) {
        audios.add(AudioModel.fromMap(map));
      }

      return fpdart.Right(audios);
    } catch (e) {
      return fpdart.Left(Failure(message: e.toString()));
    }
  }
}

Future<String> getAudioSignedUrl(String token, String audioId) async {
  final serverUrl = ServerConstants.serverURL;

  final response = await http.get(
    Uri.parse('$serverUrl/audio/signed-url/$audioId'),
    headers: {'Authorization': 'Bearer $token'},
  );

  final audioLink = '$serverUrl/${response.body}';
  return audioLink;
}
