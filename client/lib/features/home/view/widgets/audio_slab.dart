import 'package:client/core/providers/current_audio/current_audio_notifier.dart';
import 'package:client/core/providers/current_user/current_user_notifier.dart';
import 'package:client/core/theme/app_pallete.dart';
import 'package:client/core/utils/utils.dart';
import 'package:client/features/home/view/pages/audio_player_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AudioSlab extends ConsumerWidget {
  const AudioSlab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentAudio = ref.watch(currentAudioProvider);
    final audioNotifier = ref.read(currentAudioProvider.notifier);
    final token = ref.watch(currentUserProvider)?.token ?? '';

    if (currentAudio == null) {
      return const SizedBox();
    }

    final imageURL = currentAudio.imageURL;
    final audioName = currentAudio.name;
    final artist = currentAudio.artist;
    final color = hexToColor(currentAudio.hexColor);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(AudioPlayerPage.route());
      },
      child: Stack(
        children: [
          Container(
            height: 66,
            width: MediaQuery.of(context).size.width - 16,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
            ),
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  spacing: 8,
                  children: [
                    Hero(
                      tag: 'audio-image',
                      child: Container(
                        width: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          image: DecorationImage(
                            image: NetworkImage(
                              imageURL,
                              headers: {'Authorization': 'Bearer $token'},
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          audioName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          artist,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Pallete.subtitleText,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.favorite_border_outlined,
                        color: Pallete.whiteColor,
                      ),
                    ),
                    IconButton(
                      onPressed: audioNotifier.playPause,
                      icon: Icon(
                        audioNotifier.getIsPlaying()
                            ? Icons.pause
                            : Icons.play_arrow_rounded,
                        color: Pallete.whiteColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          StreamBuilder(
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

              return Positioned(
                bottom: 0,
                left: 8,
                child: Container(
                  height: 2,
                  width: sliderValue * (MediaQuery.of(context).size.width - 32),
                  decoration: BoxDecoration(
                    color: Pallete.whiteColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              );
            },
          ),
          Positioned(
            bottom: 0,
            left: 8,
            child: Container(
              height: 2,
              width: MediaQuery.of(context).size.width - 32,
              decoration: BoxDecoration(
                color: Pallete.inactiveSeekColor,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
