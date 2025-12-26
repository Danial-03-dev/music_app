import 'package:client/core/providers/current_audio/current_audio_notifier.dart';
import 'package:client/features/home/view/widgets/buttons/custom_icon_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AudioSlabActions extends ConsumerWidget {
  const AudioSlabActions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final audioNotifier = ref.read(currentAudioProvider.notifier);

    return Row(
      children: [
        CustomIconButton(
          onPressed: audioNotifier.playPause,
          icon: audioNotifier.getIsPlaying()
              ? Icons.pause
              : Icons.play_arrow_rounded,
          iconSize: 36,
        ),
        CustomIconButton(
          onPressed: audioNotifier.stopPlayer,
          icon: CupertinoIcons.xmark_circle_fill,
          iconSize: 30,
        ),
      ],
    );
  }
}
