import 'package:client/core/providers/current_user/current_user_notifier.dart';
import 'package:client/features/home/models/audio_model.dart';
import 'package:flutter/rendering.dart';
import 'package:just_audio/just_audio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_audio_notifier.g.dart';

@riverpod
class CurrentAudioNotifier extends _$CurrentAudioNotifier {
  AudioPlayer? _audioPlayer;
  bool _isPlaying = false;

  @override
  AudioModel? build() {
    return null;
  }

  AudioPlayer? getAudioPlayer() => _audioPlayer;
  bool getIsPlaying() => _isPlaying;

  void updateAudio(AudioModel audio) async {
    _audioPlayer = AudioPlayer();
    final token = ref.watch(currentUserProvider)?.token ?? '';

    try {
      final audioSource = AudioSource.uri(
        Uri.parse(await audio.audioURL(token)),
      );

      await _audioPlayer!.setAudioSource(audioSource);

      _audioPlayer!.playerStateStream.listen((state) {
        if (state.processingState == ProcessingState.completed) {
          _audioPlayer!.seek(Duration.zero);
          _audioPlayer!.pause();
          _isPlaying = false;
          this.state = this.state?.copyWith();
        }
      });

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
