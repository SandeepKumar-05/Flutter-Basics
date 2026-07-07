import 'package:flutter/material.dart';
import 'app_pallete.dart';

class AppTheme {
  static _border([Color color = AppPallete.borderColor]) => OutlineInputBorder(
    borderSide: BorderSide(
      color: color,
      width: 3,
    ),
    borderRadius: BorderRadius.circular(10),
  );

  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPallete.darkBackground,
    colorScheme: const ColorScheme.dark(
      primary: AppPallete.darkPrimaryText,
      secondary: AppPallete.darkSecondaryText,
      surface: AppPallete.darkSurface,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppPallete.darkBackground,
      foregroundColor: AppPallete.darkPrimaryText,
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppPallete.darkPrimaryText,
        foregroundColor: AppPallete.darkBackground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(27),
      border: _border(),
      enabledBorder: _border(),
      focusedBorder: _border(AppPallete.gradient2),
      errorBorder: _border(AppPallete.error),
    ),
  );

  static final lightThemeMode = ThemeData.light().copyWith(
    scaffoldBackgroundColor: AppPallete.lightBackground,
    colorScheme: const ColorScheme.light(
      primary: AppPallete.lightPrimaryText,
      secondary: AppPallete.lightSecondaryText,
      surface: AppPallete.lightSurface,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppPallete.lightBackground,
      foregroundColor: AppPallete.lightPrimaryText,
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppPallete.lightPrimaryText,
        foregroundColor: AppPallete.lightBackground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(27),
      border: _border(Colors.grey.shade400),
      enabledBorder: _border(Colors.grey.shade400),
      focusedBorder: _border(AppPallete.gradient2),
      errorBorder: _border(AppPallete.error),
    ),
  );
}
