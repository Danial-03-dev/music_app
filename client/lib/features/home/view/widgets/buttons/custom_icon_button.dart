import 'package:client/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData icon;
  final double? iconSize;
  final Color? color;

  const CustomIconButton({
    super.key,
    this.onPressed,
    required this.icon,
    this.iconSize = 52,
    this.color = Pallete.whiteColor,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon),
      iconSize: iconSize,
      color: color,
    );
  }
}
