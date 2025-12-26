import 'package:client/features/home/view/widgets/image/image_container.dart';
import 'package:flutter/material.dart';

class PlayerHero extends StatelessWidget {
  final String imageURL;
  const PlayerHero({super.key, required this.imageURL});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'audio-image',
      child: ImageContainer(
        imageURL: imageURL,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
