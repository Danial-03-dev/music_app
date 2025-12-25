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
    appBarTheme: AppBarTheme(backgroundColor: Pallete.backgroundColor),
    textTheme: TextTheme(
      displayLarge: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
      titleMedium: TextStyle(fontSize: 16),
    ).apply(bodyColor: Pallete.whiteColor, displayColor: Pallete.whiteColor),
    scaffoldBackgroundColor: Pallete.backgroundColor,
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(24),
      enabledBorder: _getInputBorder(),
      focusedBorder: _getInputBorder(color: Pallete.gradient2),
      errorBorder: _getInputBorder(color: Pallete.errorColor),
      focusedErrorBorder: _getInputBorder(color: Pallete.gradient2),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Pallete.backgroundColor,
    ),
  );
}
