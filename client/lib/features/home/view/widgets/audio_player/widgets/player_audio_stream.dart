import 'package:client/core/providers/current_audio/current_audio_notifier.dart';
import 'package:client/core/theme/app_pallete.dart';
import 'package:client/features/home/view/widgets/audio_player/widgets/player_audio_stream_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlayerAudioStream extends ConsumerWidget {
  const PlayerAudioStream({super.key});

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

        return Column(
          children: [
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: Pallete.whiteColor,
                inactiveTrackColor: Pallete.whiteColor.withValues(alpha: 0.117),
                thumbColor: Pallete.whiteColor,
                trackHeight: 4,
                overlayShape: SliderComponentShape.noOverlay,
              ),
              child: Slider(
                value: sliderValue,
                min: 0,
                max: 1,
                onChanged: (value) {
                  sliderValue = value;
                },
                onChangeEnd: audioNotifier.seek,
              ),
            ),
            PlayerAudioStreamInfo(position: position, duration: duration),
          ],
        );
      },
    );
  }
}
