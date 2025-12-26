import 'package:client/core/providers/current_audio/current_audio_notifier.dart';
import 'package:client/core/theme/app_pallete.dart';
import 'package:client/core/utils/utils.dart';
import 'package:client/features/home/view/pages/audio_player_page.dart';
import 'package:client/features/home/view/widgets/audio_slab/widgets/audio_slab_actions.dart';
import 'package:client/features/home/view/widgets/audio_slab/widgets/audio_slab_info.dart';
import 'package:client/features/home/view/widgets/audio_slab/widgets/audio_slab_progress_bar.dart';
import 'package:client/features/home/view/widgets/audio_slab/widgets/audio_slab_stream.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AudioSlab extends ConsumerWidget {
  const AudioSlab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentAudio = ref.watch(currentAudioProvider);

    if (currentAudio == null) {
      return const SizedBox();
    }

    final color = hexToColor(currentAudio.hexColor);

    return Semantics(
      label: 'Open audio in player',
      button: true,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(AudioPlayerPage.route());
        },
        child: Stack(
          children: [
            AnimatedContainer(
              height: 66,
              width: MediaQuery.of(context).size.width - 16,
              duration: const Duration(milliseconds: 500),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4),
              ),
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AudioSlabInfo(audio: currentAudio),
                  AudioSlabActions(),
                ],
              ),
            ),
            AudioSlabStream(),
            AudioSlabProgressBar(
              width: MediaQuery.of(context).size.width - 32,
              color: Pallete.inactiveSeekColor,
            ),
          ],
        ),
      ),
    );
  }
}
