import 'package:client/core/providers/current_audio/current_audio_notifier.dart';
import 'package:client/core/widgets/buttons/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlayerActions extends ConsumerWidget {
  const PlayerActions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final audioNotifier = ref.read(currentAudioProvider.notifier);
    ref.watch(currentAudioProvider);
    const double smallIconSize = 24;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const CustomIconButton(
          icon: Icons.shuffle_rounded,
          iconSize: smallIconSize,
        ),
        const CustomIconButton(icon: Icons.skip_previous_rounded),
        CustomIconButton(
          onPressed: audioNotifier.playPause,
          icon: audioNotifier.getIsPlaying()
              ? Icons.pause_circle_filled_rounded
              : Icons.play_circle_fill_rounded,
          iconSize: 80,
        ),
        const CustomIconButton(icon: Icons.skip_next_rounded),
        const CustomIconButton(
          icon: Icons.loop_rounded,
          iconSize: smallIconSize,
        ),
      ],
    );
  }
}
