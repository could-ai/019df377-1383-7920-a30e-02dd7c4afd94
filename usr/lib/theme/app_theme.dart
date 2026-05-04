import 'package:flutter/material.dart';

class AppTheme {
  // Industrial Color Palette
  static const Color matteBlack = Color(0xFF121212);
  static const Color darkCharcoal = Color(0xFF1E1E1E);
  static const Color steelGray = Color(0xFF2C2C2C);
  static const Color safetyOrange = Color(0xFFFF5E00);
  static const Color safetyOrangeDark = Color(0xFFCC4A00);
  static const Color brushedSilver = Color(0xFFB0B0B0);
  static const Color pureWhite = Color(0xFFFFFFFF);
  static const Color hazardRed = Color(0xFFD32F2F);
  static const Color successGreen = Color(0xFF388E3C);
  static const Color cautionYellow = Color(0xFFFBC02D);

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: matteBlack,
      primaryColor: safetyOrange,
      colorScheme: const ColorScheme.dark(
        primary: safetyOrange,
        secondary: steelGray,
        surface: darkCharcoal,
        error: hazardRed,
        onPrimary: pureWhite,
        onSecondary: pureWhite,
        onSurface: brushedSilver,
        onError: pureWhite,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: darkCharcoal,
        foregroundColor: pureWhite,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: safetyOrange),
        titleTextStyle: TextStyle(
          color: pureWhite,
          fontSize: 20,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.2,
        ),
      ),
      cardTheme: CardTheme(
        color: darkCharcoal,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: steelGray, width: 2),
        ),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: safetyOrange,
          foregroundColor: pureWhite,
          elevation: 6,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: safetyOrange,
          side: const BorderSide(color: safetyOrange, width: 2),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: safetyOrange,
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: steelGray,
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: steelGray, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: safetyOrange, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: hazardRed, width: 2),
        ),
        labelStyle: const TextStyle(color: brushedSilver),
        hintStyle: const TextStyle(color: Colors.grey),
      ),
      dividerTheme: const DividerThemeData(
        color: steelGray,
        thickness: 2,
        space: 24,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: safetyOrange,
        foregroundColor: pureWhite,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(color: pureWhite, fontWeight: FontWeight.w900),
        displayMedium: TextStyle(color: pureWhite, fontWeight: FontWeight.w800),
        displaySmall: TextStyle(color: pureWhite, fontWeight: FontWeight.w700),
        headlineLarge: TextStyle(color: pureWhite, fontWeight: FontWeight.w800),
        headlineMedium: TextStyle(color: pureWhite, fontWeight: FontWeight.w700),
        headlineSmall: TextStyle(color: pureWhite, fontWeight: FontWeight.w600),
        titleLarge: TextStyle(color: pureWhite, fontWeight: FontWeight.w700),
        titleMedium: TextStyle(color: pureWhite, fontWeight: FontWeight.w600),
        titleSmall: TextStyle(color: brushedSilver, fontWeight: FontWeight.w500),
        bodyLarge: TextStyle(color: pureWhite),
        bodyMedium: TextStyle(color: brushedSilver),
        bodySmall: TextStyle(color: Colors.grey),
      ),
      iconTheme: const IconThemeData(
        color: brushedSilver,
        size: 24,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: darkCharcoal,
        selectedItemColor: safetyOrange,
        unselectedItemColor: brushedSilver,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
    );
  }
}
