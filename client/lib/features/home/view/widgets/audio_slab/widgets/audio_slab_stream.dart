import 'package:client/core/providers/current_audio/current_audio_notifier.dart';
import 'package:client/features/home/view/widgets/audio_slab/widgets/audio_slab_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AudioSlabStream extends ConsumerWidget {
  final Color? color;
  const AudioSlabStream({super.key, this.color});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final audioNotifier = ref.read(currentAudioProvider.notifier);

    return StreamBuilder(
      stream: audioNotifier.getAudioPlayer()?.positionStream,
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox();
        }

        final position = asyncSnapshot.data;
        final duration = audioNotifier.getAudioPlayer()!.duration;

        double sliderValue = 0;
        if (position != null && duration != null) {
          sliderValue = position.inMicroseconds / duration.inMicroseconds;
        }

        return AudioSlabProgressBar(
          width: sliderValue * (MediaQuery.of(context).size.width - 32),
          color: color,
        );
      },
    );
  }
}
