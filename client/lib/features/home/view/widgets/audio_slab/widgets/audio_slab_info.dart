import 'package:client/core/theme/app_pallete.dart';
import 'package:client/features/home/models/audio_model.dart';
import 'package:client/features/home/view/widgets/image/image_container.dart';
import 'package:flutter/material.dart';

class AudioSlabInfo extends StatelessWidget {
  final AudioModel audio;
  const AudioSlabInfo({super.key, required this.audio});

  @override
  Widget build(BuildContext context) {
    final imageURL = audio.imageURL;
    final audioName = audio.name;
    final artist = audio.artist;

    return Row(
      spacing: 8,
      children: [
        Hero(
          tag: 'audio-image',
          child: ImageContainer(width: 48, imageURL: imageURL),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              audioName,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                overflow: TextOverflow.ellipsis,
              ),
              maxLines: 1,
            ),
            Text(
              artist,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                overflow: TextOverflow.ellipsis,
                color: Pallete.subtitleText,
              ),
              maxLines: 1,
            ),
          ],
        ),
      ],
    );
  }
}
