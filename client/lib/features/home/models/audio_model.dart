import 'dart:convert';

import 'package:client/core/constants/server_constants.dart';
import 'package:client/features/home/repositories/home_repository.dart';

class AudioModel {
  final String id;
  final String name;
  final String artist;
  final String hexColor;
  final String audioId;
  final String imageId;
  final String mimeType;
  final int size;

  const AudioModel({
    required this.id,
    required this.name,
    required this.artist,
    required this.hexColor,
    required this.audioId,
    required this.imageId,
    required this.mimeType,
    required this.size,
  });

  String get imageURL => '${ServerConstants.serverURL}/audio/image/$imageId';

  Future<String> audioURL(String token) async {
    return await getAudioSignedUrl(token, audioId);
  }

  AudioModel copyWith({
    String? id,
    String? name,
    String? artist,
    String? hexColor,
    String? audioId,
    String? imageId,
    String? mimeType,
    int? size,
  }) {
    return AudioModel(
      id: id ?? this.id,
      name: name ?? this.name,
      artist: artist ?? this.artist,
      hexColor: hexColor ?? this.hexColor,
      audioId: audioId ?? this.audioId,
      imageId: imageId ?? this.imageId,
      mimeType: mimeType ?? this.mimeType,
      size: size ?? this.size,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'name': name,
      'artist': artist,
      'color': hexColor,
      'audioId': audioId,
      'imageId': imageId,
      'mimeType': mimeType,
      'size': size,
    };
  }

  factory AudioModel.fromMap(Map<String, dynamic> map) {
    return AudioModel(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      artist: map['artist'] ?? '',
      hexColor: map['color'] ?? '',
      audioId: map['audioId'] ?? '',
      imageId: map['imageId'] ?? '',
      mimeType: map['mimeType'] ?? '',
      size: map['size'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory AudioModel.fromJson(String source) =>
      AudioModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AudioModel(id: $id, name: $name, artist: $artist, hexColor: $hexColor, audioId: $audioId, imageId: $imageId, mimeType: $mimeType, size: $size)';
  }
}
