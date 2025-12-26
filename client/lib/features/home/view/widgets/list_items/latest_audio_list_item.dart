import 'package:client/core/providers/current_audio/current_audio_notifier.dart';
import 'package:client/features/home/models/audio_model.dart';
import 'package:client/features/home/view/widgets/image/image_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LatestAudioListItem extends ConsumerWidget {
  final AudioModel audio;

  const LatestAudioListItem({super.key, required this.audio});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageURL = audio.imageURL;
    final audioName = audio.name;
    final artist = audio.artist;

    void handlePlayAudio() {
      ref.read(currentAudioProvider.notifier).updateAudio(audio);
    }

    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Semantics(
        label: 'Play audio $audioName',
        button: true,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: handlePlayAudio,
          child: SizedBox(
            width: 180,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4,
              children: [
                ImageContainer(height: 180, imageURL: imageURL),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 4,
                    children: [
                      Text(
                        audioName,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(overflow: TextOverflow.ellipsis),
                        maxLines: 1,
                      ),
                      Text(
                        artist,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
