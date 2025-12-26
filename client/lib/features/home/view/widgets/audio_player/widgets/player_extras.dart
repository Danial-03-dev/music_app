import 'package:client/features/home/view/widgets/buttons/custom_icon_button.dart';
import 'package:flutter/material.dart';

class PlayerExtras extends StatelessWidget {
  const PlayerExtras({super.key});

  @override
  Widget build(BuildContext context) {
    const double iconSize = 32;

    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomIconButton(icon: Icons.computer_rounded, iconSize: iconSize),
        CustomIconButton(icon: Icons.playlist_play_rounded, iconSize: iconSize),
      ],
    );
  }
}
