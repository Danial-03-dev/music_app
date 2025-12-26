import 'package:client/core/providers/current_audio/current_audio_notifier.dart';
import 'package:client/core/theme/app_pallete.dart';
import 'package:client/features/home/models/audio_model.dart';
import 'package:client/features/home/view/widgets/image/image_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecentAudioListItem extends ConsumerWidget {
  final AudioModel audio;

  const RecentAudioListItem({super.key, required this.audio});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageURL = audio.imageURL;
    final name = audio.name;

    void handlePlayAudio() {
      ref.read(currentAudioProvider.notifier).updateAudio(audio);
    }

    final double borderRadius = 4;
    return Semantics(
      label: 'Play audio $name',
      button: true,
      child: InkWell(
        onTap: handlePlayAudio,
        child: Container(
          decoration: BoxDecoration(
            color: Pallete.borderColor,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: const EdgeInsets.only(right: 8),
          child: Row(
            spacing: 8,
            children: [
              ImageContainer(
                imageURL: imageURL,
                width: 56,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(borderRadius),
                  bottomLeft: Radius.circular(borderRadius),
                ),
              ),
              Flexible(
                child: Text(
                  name,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
