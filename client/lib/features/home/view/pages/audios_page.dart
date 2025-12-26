import 'package:client/core/providers/current_audio/current_audio_notifier.dart';
import 'package:client/core/theme/app_pallete.dart';
import 'package:client/core/utils/utils.dart';
import 'package:client/features/home/view/widgets/lists/latest_audio_list.dart';
import 'package:client/features/home/view/widgets/lists/recent_audio_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AudiosPage extends ConsumerWidget {
  const AudiosPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentAudio = ref.watch(currentAudioProvider);

    final gradientColor = currentAudio?.hexColor ?? '#999999';

    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [hexToColor(gradientColor), Pallete.transparentColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.0, 0.4],
        ),
      ),
      child: const Column(
        spacing: 16,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.all(8), child: RecentAudioList()),
          LatestAudioList(),
        ],
      ),
    );
  }
}
