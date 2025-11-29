import 'package:client/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

OutlineInputBorder _getInputBorder({Color color = Pallete.borderColor}) {
  return OutlineInputBorder(
    borderSide: BorderSide(color: color, width: 3),
    borderRadius: BorderRadius.circular(12),
  );
}

class AppTheme {
  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Pallete.backgroundColor,
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(24),
      enabledBorder: _getInputBorder(),
      focusedBorder: _getInputBorder(color: Pallete.gradient2),
    ),
  );
}
