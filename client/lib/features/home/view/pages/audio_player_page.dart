import 'package:client/core/providers/current_audio/current_audio_notifier.dart';
import 'package:client/core/theme/app_pallete.dart';
import 'package:client/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AudioPlayerPage extends ConsumerWidget {
  static Function route = () => PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) {
      return AudioPlayerPage();
    },
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final tween = Tween(
        begin: const Offset(0, 1),
        end: Offset.zero,
      ).chain(CurveTween(curve: Curves.easeIn));

      final offsetAnimation = animation.drive(tween);

      return SlideTransition(position: offsetAnimation, child: child);
    },
  );

  const AudioPlayerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentAudio = ref.watch(currentAudioProvider);
    final audioNotifier = ref.read(currentAudioProvider.notifier);

    final imageURL = currentAudio?.imageURL ?? '';
    final audioName = currentAudio?.name ?? '';
    final artist = currentAudio?.artist ?? '';
    final color = currentAudio?.hexColor ?? '#FFFFFF';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [hexToColor(color), const Color(0xFF121212)],
        ),
      ),
      child: Scaffold(
        backgroundColor: Pallete.transparentColor,
        appBar: AppBar(
          backgroundColor: Pallete.transparentColor,
          leading: Transform.translate(
            offset: const Offset(-16, 0),
            child: InkWell(
              highlightColor: Pallete.transparentColor,
              focusColor: Pallete.transparentColor,
              splashColor: Pallete.transparentColor,
              hoverColor: Pallete.transparentColor,
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/images/pull-down-arrow.png',
                  color: Pallete.whiteColor,
                ),
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: Hero(
                  tag: 'audio-image',
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(imageURL),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ),

            Expanded(
              flex: 4,
              child: Column(
                spacing: 16,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            audioName,
                            style: const TextStyle(
                              color: Pallete.whiteColor,
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            artist,
                            style: const TextStyle(
                              color: Pallete.subtitleText,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.favorite_border_outlined,
                          color: Pallete.whiteColor,
                        ),
                      ),
                    ],
                  ),
                  StreamBuilder(
                    stream: audioNotifier.audioPlayer?.positionStream,
                    builder: (context, asyncSnapshot) {
                      if (asyncSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const SizedBox();
                      }

                      final position = asyncSnapshot.data;
                      final duration = audioNotifier.audioPlayer!.duration;

                      double sliderValue = 0;
                      if (position != null && duration != null) {
                        sliderValue =
                            position.inMicroseconds / duration.inMicroseconds;
                      }

                      return Column(
                        children: [
                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              activeTrackColor: Pallete.whiteColor,
                              inactiveTrackColor: Pallete.whiteColor.withValues(
                                alpha: 0.117,
                              ),
                              thumbColor: Pallete.whiteColor,
                              trackHeight: 4,
                              overlayShape: SliderComponentShape.noOverlay,
                            ),
                            child: Slider(
                              value: sliderValue,
                              min: 0,
                              max: 1,
                              onChanged: (value) {
                                sliderValue = value;
                              },
                              onChangeEnd: audioNotifier.seek,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${position?.inMinutes}:${(position?.inSeconds ?? 0) < 10 ? '0' : ''}${position?.inSeconds}',
                                style: const TextStyle(
                                  color: Pallete.subtitleText,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              Text(
                                '${duration?.inMinutes}:${(duration?.inSeconds ?? 0) < 10 ? '0' : ''}${(duration?.inSeconds ?? 0) - (duration?.inMinutes ?? 0) * 60}',
                                style: const TextStyle(
                                  color: Pallete.subtitleText,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          'assets/images/shuffle.png',
                          color: Pallete.whiteColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          'assets/images/previous-audio.png',
                          color: Pallete.whiteColor,
                        ),
                      ),
                      IconButton(
                        onPressed: audioNotifier.playPause,
                        icon: Icon(
                          audioNotifier.isPlaying
                              ? Icons.pause_circle_filled_rounded
                              : Icons.play_circle_fill_rounded,
                        ),
                        iconSize: 80,
                        color: Pallete.whiteColor,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          'assets/images/next-audio.png',
                          color: Pallete.whiteColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          'assets/images/repeat.png',
                          color: Pallete.whiteColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          'assets/images/connect-device.png',
                          color: Pallete.whiteColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          'assets/images/playlist.png',
                          color: Pallete.whiteColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
