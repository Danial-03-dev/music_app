import 'package:client/core/providers/current_user/current_user_notifier.dart';
import 'package:client/features/home/models/audio_model.dart';
import 'package:just_audio/just_audio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_audio_notifier.g.dart';

@riverpod
class CurrentAudioNotifier extends _$CurrentAudioNotifier {
  AudioPlayer? audioPlayer;
  bool isPlaying = false;

  @override
  AudioModel? build() {
    return null;
  }

  void updateAudio(AudioModel audio) async {
    audioPlayer = AudioPlayer();
    final token = ref.watch(currentUserProvider)?.token ?? '';

    try {
      final audioSource = AudioSource.uri(
        Uri.parse(await audio.audioURL(token)),
      );

      await audioPlayer!.setAudioSource(audioSource);

      audioPlayer!.playerStateStream.listen((state) {
        if (state.processingState == ProcessingState.completed) {
          audioPlayer!.seek(Duration.zero);
          audioPlayer!.pause();
          isPlaying = false;
          this.state = this.state?.copyWith();
        }
      });

      audioPlayer!.play();
      isPlaying = true;

      state = audio;
    } catch (e) {
      print(e.toString());
    }
  }

  void playPause() {
    if (isPlaying) {
      audioPlayer?.pause();
    } else {
      audioPlayer?.play();
    }

    isPlaying = !isPlaying;
    state = state?.copyWith();
  }

  void seek(double val) {
    final audioDuration = audioPlayer?.duration?.inMilliseconds ?? 0;

    audioPlayer?.seek(Duration(milliseconds: (val * audioDuration).toInt()));
  }
}
