import 'package:client/core/providers/current_audio/current_audio_notifier.dart';
import 'package:client/core/providers/current_user/current_user_notifier.dart';
import 'package:client/core/theme/app_pallete.dart';
import 'package:client/core/utils/utils.dart';
import 'package:client/core/widgets/loader.dart';
import 'package:client/features/home/view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AudiosPage extends ConsumerWidget {
  const AudiosPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final token = ref.watch(currentUserProvider)?.token ?? '';
    final currentAudio = ref.watch(currentAudioProvider);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      decoration: currentAudio == null
          ? null
          : BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  hexToColor(currentAudio.hexColor),
                  Pallete.transparentColor,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.0, 0.2],
              ),
            ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 32),
            child: SizedBox(
              height: 280,
              child: FutureBuilder(
                future: ref
                    .watch(homeViewModelProvider.notifier)
                    .getRecentAudios(),
                builder: (context, asyncSnapshot) {
                  if (asyncSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (asyncSnapshot.hasError) {
                    return Center(child: Text('Error: ${asyncSnapshot.error}'));
                  }
                  final recentlyPlayedAudios = asyncSnapshot.data ?? [];
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          childAspectRatio: 3,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                    itemCount: recentlyPlayedAudios.length,
                    itemBuilder: (context, index) {
                      final audio = recentlyPlayedAudios[index];
                      final imageURL = audio.imageURL;
                      final name = audio.name;

                      return GestureDetector(
                        onTap: () {
                          ref
                              .read(currentAudioProvider.notifier)
                              .updateAudio(audio);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Pallete.borderColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          padding: const EdgeInsets.only(right: 20),
                          child: Row(
                            spacing: 8,
                            children: [
                              Container(
                                width: 56,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4),
                                    bottomLeft: Radius.circular(4),
                                  ),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      imageURL,
                                      headers: {
                                        'Authorization': 'Bearer $token',
                                      },
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  name,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),

          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Latest',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            ),
          ),
          ref
              .watch(getAudioListProvider)
              .when(
                data: (audios) {
                  return SizedBox(
                    height: 256,
                    child: ListView.builder(
                      itemCount: audios.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final audio = audios[index];
                        return GestureDetector(
                          onTap: () {
                            ref
                                .read(currentAudioProvider.notifier)
                                .updateAudio(audio);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 4,
                              children: [
                                Container(
                                  width: 180,
                                  height: 180,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        audio.imageURL,
                                        headers: {
                                          'Authorization': 'Bearer $token',
                                        },
                                      ),
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                SizedBox(
                                  width: 180,
                                  child: Text(
                                    audio.name,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    maxLines: 1,
                                  ),
                                ),
                                SizedBox(
                                  width: 180,
                                  child: Text(
                                    audio.artist,
                                    style: TextStyle(
                                      color: Pallete.subtitleText,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
                error: (error, st) => Center(child: Text(error.toString())),
                loading: () => const Loader(),
              ),
        ],
      ),
    );
  }
}
