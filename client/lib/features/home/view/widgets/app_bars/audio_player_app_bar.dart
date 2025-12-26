import 'package:client/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AudioPlayerAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AudioPlayerAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
