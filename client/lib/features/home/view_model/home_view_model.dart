import 'dart:ui';

import 'package:client/core/providers/current_user/current_user_notifier.dart';
import 'package:client/core/utils/utils.dart';
import 'package:client/features/home/models/audio_model.dart';
import 'package:client/features/home/repositories/home_local_repository.dart';
import 'package:client/features/home/repositories/home_remote_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:fpdart/fpdart.dart' as fpdart;

part 'home_view_model.g.dart';

@riverpod
Future<List<AudioModel>> getAudioList(Ref ref) async {
  final token = ref.watch(currentUserProvider)?.token ?? '';
  final response = await ref
      .watch(homeRepositoryProvider)
      .getAudioList(token: token);

  return switch (response) {
    fpdart.Left(value: final l) => throw l.message,
    fpdart.Right(value: final r) => r,
  };
}

@riverpod
Future<List<AudioModel>> getLocalAudioList(Ref ref) async {
  final homeLocalRepository = await ref.watch(
    homeLocalRepositoryProvider.future,
  );
  return homeLocalRepository.loadLocalAudios();
}

@riverpod
class HomeViewModel extends _$HomeViewModel {
  late HomeRemoteRepository _homeRepository;

  @override
  AsyncValue? build() {
    _homeRepository = ref.watch(homeRepositoryProvider);
    return null;
  }

  Future<void> uploadAudio({
    required PickedImage image,
    required PickedMedia audio,
    required String audioName,
    required String artist,
    required Color color,
  }) async {
    state = const AsyncValue.loading();

    final token = ref.read(currentUserProvider)?.token ?? '';

    final response = await _homeRepository.uploadAudio(
      image: image,
      audio: audio,
      audioName: audioName,
      artist: artist,
      hexCode: colorToHex(color),
      token: token,
    );

    AsyncValue<String> onSuccess(String r) {
      ref.invalidate(getAudioListProvider);
      return AsyncValue.data(r);
    }

    state = switch (response) {
      fpdart.Left(value: final l) => AsyncValue.error(
        l.message,
        StackTrace.current,
      ),
      fpdart.Right(value: final r) => onSuccess(r),
    };
  }
}
