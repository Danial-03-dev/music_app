import 'package:client/core/widgets/custom_scroll_config.dart';
import 'package:client/core/widgets/loader.dart';
import 'package:client/features/home/view/widgets/list_items/latest_audio_list_item.dart';
import 'package:client/features/home/view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LatestAudioList extends ConsumerWidget {
  const LatestAudioList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text('Latest', style: Theme.of(context).textTheme.titleLarge),
        ),
        ref
            .watch(getAudioListProvider)
            .when(
              data: (audios) {
                final itemCount = audios.length > 8 ? 8 : audios.length;

                return SizedBox(
                  height: 256,
                  child: CustomScrollConfig(
                    child: ListView.builder(
                      itemCount: itemCount,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final audio = audios[index];
                        return LatestAudioListItem(audio: audio);
                      },
                    ),
                  ),
                );
              },
              error: (error, st) => Center(child: Text(error.toString())),
              loading: () => const Loader(),
            ),
      ],
    );
  }
}
