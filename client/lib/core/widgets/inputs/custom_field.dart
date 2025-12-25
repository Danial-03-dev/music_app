import 'package:client/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class Customfield extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final bool obscureText;
  final bool readOnly;
  final VoidCallback? onTap;

  const Customfield({
    super.key,
    required this.hintText,
    this.controller,
    this.obscureText = false,
    this.readOnly = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(hintText: hintText),
      obscureText: obscureText,
      readOnly: readOnly,
      onTap: onTap,
      style: TextStyle(color: Pallete.whiteColor),
      validator: readOnly
          ? null
          : (value) {
              if (value!.trim().isEmpty) {
                return '$hintText is missing!';
              }

              if (value.length > 56) {
                return 'Too long $hintText';
              }

              return null;
            },
    );
  }
}
