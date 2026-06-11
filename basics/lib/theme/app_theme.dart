import 'package:flutter/material.dart';

class AppTheme {
  // ─── Palette ──────────────────────────────────────────────────────
  static const Color primary = Color(0xFF000000);
  static const Color primaryDark = Color(0xFF212121);
  static const Color accent = Color(0xFF000000);
  static const Color success = Color(0xFF2E7D32);
  static const Color warning = Color(0xFFE65100);

  static const Color bgDark = Color(0xFFFFFFFF);
  static const Color bgCard = Color(0xFFF5F5F5);
  static const Color bgSurface = Color(0xFFEEEEEE);

  static const Color textPrimary = Color(0xFF000000);
  static const Color textSecondary = Color(0xFF212121);
  static const Color textMuted = Color(0xFF757575);

  // ─── Gradients ────────────────────────────────────────────────────
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFFFFFFFF), Color(0xFFEEEEEE)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [Color(0xFF000000), Color(0xFF424242)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient bgGradient = LinearGradient(
    colors: [bgDark, bgSurface],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // ─── Theme ────────────────────────────────────────────────────────
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: bgDark,
      colorScheme: const ColorScheme.light(
        primary: primary,
        secondary: accent,
        surface: bgCard,
        onPrimary: Colors.white,
        onSurface: textPrimary,
      ),
      fontFamily: 'sans-serif',
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: textPrimary,
          fontSize: 22,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.5,
        ),
        iconTheme: IconThemeData(color: textPrimary),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: bgCard,
        selectedItemColor: primary,
        unselectedItemColor: textMuted,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      cardTheme: CardThemeData(
        color: bgCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Color(0xFFE0E0E0), width: 1),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: bgCard,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Color(0xFF000000), width: 1.5),
        ),
        hintStyle: const TextStyle(color: textMuted),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          textStyle:
              const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}