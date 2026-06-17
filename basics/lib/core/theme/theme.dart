import 'package:flutter/material.dart';
import 'app_pallete.dart';

class AppTheme {
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
  );
}
