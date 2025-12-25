import 'dart:async';

import 'package:client/core/providers/current_user/current_user_notifier.dart';
import 'package:client/features/home/models/audio_model.dart';
import 'package:client/features/home/repositories/home_local_repository.dart';
import 'package:flutter/rendering.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_audio_notifier.g.dart';

@riverpod
class CurrentAudioNotifier extends _$CurrentAudioNotifier {
  AudioPlayer? _audioPlayer;
  StreamSubscription<PlayerState>? _playerSub;
  bool _isPlaying = false;

  @override
  AudioModel? build() {
    ref.onDispose(() async {
      await _playerSub?.cancel();
      await _audioPlayer?.dispose();
    });

    return null;
  }

  AudioPlayer? getAudioPlayer() => _audioPlayer;
  bool getIsPlaying() => _isPlaying;

  Future<void> updateAudio(AudioModel audio) async {
    await _playerSub?.cancel();
    await _audioPlayer?.dispose();
    _audioPlayer = AudioPlayer();
    final token = ref.read(currentUserProvider)?.token ?? '';

    try {
      final audioSource = AudioSource.uri(
        Uri.parse(await audio.audioURL(token)),
        tag: MediaItem(
          id: audio.id,
          title: audio.name,
          artist: audio.artist,
          artUri: Uri.parse(audio.imageURL),
          artHeaders: {'Authorization': 'Bearer $token'},
        ),
      );

      await _audioPlayer!.setAudioSource(audioSource);

      _playerSub = _audioPlayer!.playerStateStream.listen((state) {
        if (state.processingState == ProcessingState.completed) {
          _audioPlayer!.seek(Duration.zero);
          _audioPlayer!.pause();
          _isPlaying = false;
          this.state = this.state?.copyWith();
        }
      });

      final homeLocalRepository = await ref.read(
        homeLocalRepositoryProvider.future,
      );
      homeLocalRepository.uploadLocalAudio(audio);

      _audioPlayer!.play();
      _isPlaying = true;

      state = audio;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void playPause() {
    if (_isPlaying) {
      _audioPlayer?.pause();
    } else {
      _audioPlayer?.play();
    }

    _isPlaying = !_isPlaying;
    state = state?.copyWith();
  }

  void seek(double val) {
    final audioDuration = _audioPlayer?.duration?.inMilliseconds ?? 0;

    _audioPlayer?.seek(Duration(milliseconds: (val * audioDuration).toInt()));
  }
}
