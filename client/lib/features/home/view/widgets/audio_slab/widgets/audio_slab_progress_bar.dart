import 'package:client/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AudioSlabProgressBar extends StatelessWidget {
  final Color? color;
  final double width;

  const AudioSlabProgressBar({
    super.key,
    this.color = Pallete.whiteColor,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 8,
      child: Container(
        height: 2,
        width: width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
