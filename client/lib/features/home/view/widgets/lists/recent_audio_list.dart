import 'package:client/core/theme/app_pallete.dart';
import 'package:client/core/widgets/loader.dart';
import 'package:client/features/home/view/widgets/list_items/recent_audio_list_item.dart';
import 'package:client/features/home/view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecentAudioList extends ConsumerWidget {
  const RecentAudioList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text('Recent', style: Theme.of(context).textTheme.titleLarge),
        SizedBox(
          height: 156,
          child: ref
              .watch(getLocalAudioListProvider)
              .when(
                data: (audios) {
                  if (audios.isEmpty) {
                    return Center(
                      child: Text(
                        'No recent audios',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Pallete.greyColor,
                        ),
                      ),
                    );
                  }

                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          childAspectRatio: 3,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                    itemCount: audios.length,
                    itemBuilder: (context, index) {
                      final audio = audios[index];
                      return RecentAudioListItem(audio: audio);
                    },
                  );
                },
                error: (error, stackTrace) {
                  return Center(child: Text('Error: ${error.toString()}'));
                },
                loading: () {
                  return const Loader();
                },
              ),
        ),
      ],
    );
  }
}
