import 'package:client/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class PlayerAudioStreamInfo extends StatelessWidget {
  final Duration? position;
  final Duration? duration;

  const PlayerAudioStreamInfo({super.key, this.position, this.duration});

  @override
  Widget build(BuildContext context) {
    final textStyles = TextStyle(
      color: Pallete.subtitleText,
      fontSize: 13,
      fontWeight: FontWeight.w300,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${position?.inMinutes}:${(position?.inSeconds ?? 0) < 10 ? '0' : ''}${position?.inSeconds}',
          style: textStyles,
        ),
        Text(
          '${duration?.inMinutes}:${(duration?.inSeconds ?? 0) < 10 ? '0' : ''}${(duration?.inSeconds ?? 0) - (duration?.inMinutes ?? 0) * 60}',
          style: textStyles,
        ),
      ],
    );
  }
}
