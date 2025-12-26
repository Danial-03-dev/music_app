import 'package:client/core/theme/app_pallete.dart';
import 'package:client/features/home/models/audio_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlayerInfo extends ConsumerWidget {
  final AudioModel audio;

  const PlayerInfo({super.key, required this.audio});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final audioName = audio.name;
    final artist = audio.artist;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(audioName, style: Theme.of(context).textTheme.titleLarge),
            Text(
              artist,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: Pallete.subtitleText),
            ),
          ],
        ),
      ],
    );
  }
}
