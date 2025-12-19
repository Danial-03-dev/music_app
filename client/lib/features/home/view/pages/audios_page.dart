import 'package:client/core/providers/current_audio/current_audio_notifier.dart';
import 'package:client/core/providers/current_user/current_user_notifier.dart';
import 'package:client/core/theme/app_pallete.dart';
import 'package:client/core/widgets/loader.dart';
import 'package:client/features/home/view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AudiosPage extends ConsumerWidget {
  const AudiosPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final token = ref.watch(currentUserProvider)?.token ?? '';

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
