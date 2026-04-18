import 'package:flutter/material.dart';

class AppTheme {
  static const Color ivory = Color(0xFFFFFBF8);
  static const Color blush = Color(0xFFF3E8E5);
  static const Color softSurface = Color(0xFFFAF7EF);
  static const Color maroon = Color(0xFF5A1924);
  static const Color olive = Color(0xFF75763E);
  static const Color cocoa = Color(0xFF4E423D);

  static ThemeData get lightTheme {
    final colorScheme =
        ColorScheme.fromSeed(
          seedColor: maroon,
          brightness: Brightness.light,
        ).copyWith(
          primary: maroon,
          secondary: olive,
          surface: softSurface,
          surfaceContainer: softSurface,
          surfaceContainerHigh: blush,
          onPrimary: Colors.white,
          onSurface: cocoa,
        );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: ivory,
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 34,
          fontWeight: FontWeight.w700,
          color: cocoa,
          letterSpacing: 0.2,
        ),
        headlineMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: cocoa,
        ),
        titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: cocoa,
        ),
        bodyLarge: TextStyle(fontSize: 16, color: cocoa, height: 1.4),
        bodyMedium: TextStyle(fontSize: 14, color: cocoa),
      ),
      cardTheme: CardThemeData(
        color: softSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: cocoa,
        contentTextStyle: const TextStyle(color: Colors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
    );
  }
}
