import 'package:client/features/home/models/audio_model.dart';
import 'package:client/features/home/view/widgets/audio_player/widgets/player_actions.dart';
import 'package:client/features/home/view/widgets/audio_player/widgets/player_audio_stream.dart';
import 'package:client/features/home/view/widgets/audio_player/widgets/player_extras.dart';
import 'package:client/features/home/view/widgets/audio_player/widgets/player_hero.dart';
import 'package:client/features/home/view/widgets/audio_player/widgets/player_info.dart';
import 'package:flutter/material.dart';

class AudioPlayer extends StatelessWidget {
  final AudioModel audio;

  const AudioPlayer({super.key, required this.audio});

  @override
  Widget build(BuildContext context) {
    final imageURL = audio.imageURL;

    return Column(
      children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 32),
            child: PlayerHero(imageURL: imageURL),
          ),
        ),

        Expanded(
          flex: 4,
          child: Column(
            spacing: 16,
            children: [
              PlayerInfo(audio: audio),
              const PlayerAudioStream(),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 512),
                child: Column(
                  spacing: 16,
                  children: [const PlayerActions(), const PlayerExtras()],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
