import 'package:flutter/material.dart';

class MyTheme {
  // --- نام فونت اصلی پروژه ---
  static const String defaultFontFamily = 'YekanBakh';

  // --- پالت رنگی تم روشن (Light) ---
  static const Color primaryColor = Color(0xFF217CF3);
  static const Color secondaryColor = Color(0xFF262A35);
  static const Color primaryTextColor = Color(0xFF262A35);
  static const Color secondaryTextColor = Color(0xFF757575);
  static const Color surfaceColor = Color.fromARGB(255, 240, 240, 240);

  // --- پالت رنگی تم تاریک (Dark) ---
  static const Color darkBackgroundColor = Color(0xFF121212);
  static const Color darkSurfaceColor = Color(0xFF1E1E1E);
  static const Color darkPrimaryTextColor = Color(0xFFFFFFFF);
  static const Color darkSecondaryTextColor = Color(0xFFB0B0B0);

  // ☀️ تم روشن
  static ThemeData initTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      fontFamily: defaultFontFamily,
      scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: Brightness.light,
        primary: primaryColor,
        secondary: secondaryColor,
        surface: surfaceColor,
      ),
      textTheme: prepareTextTheme(isDark: false),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
        titleTextStyle: TextStyle(
          fontFamily: defaultFontFamily,
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: primaryTextColor,
        ),
      ),
    );
  }

  // 🌙 تم تاریک
  static ThemeData initDarkTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: darkBackgroundColor,
      fontFamily: defaultFontFamily,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: Brightness.dark,
        surface: darkSurfaceColor,
      ),
      textTheme: prepareTextTheme(isDark: true),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: darkSurfaceColor,
        titleTextStyle: TextStyle(
          fontFamily: defaultFontFamily,
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: darkPrimaryTextColor,
        ),
      ),
    );
  }

  static TextTheme prepareTextTheme({required bool isDark}) {
    final textColor = isDark ? darkPrimaryTextColor : primaryTextColor;
    final subTextColor = isDark ? darkSecondaryTextColor : secondaryTextColor;

    // تعریف بیس استایل همراه با فونت یکان بخوا
    final baseStyle = TextStyle(
      fontFamily: defaultFontFamily,
      color: textColor,
    );

    return TextTheme(
      // --- DISPLAY ---
      displayLarge: baseStyle.copyWith(
        fontSize: 57,
        fontWeight: FontWeight.w300, // Light
      ),
      displayMedium: baseStyle.copyWith(
        fontSize: 45,
        fontWeight: FontWeight.w300, // Light
      ),
      displaySmall: baseStyle.copyWith(
        fontSize: 36,
        fontWeight: FontWeight.w400, // Regular
      ),

      // --- HEADLINE ---
      headlineLarge: baseStyle.copyWith(
        fontSize: 32,
        fontWeight: FontWeight.w800, // ExtraBold
      ),
      headlineMedium: baseStyle.copyWith(
        fontSize: 28,
        fontWeight: FontWeight.w700, // Bold
      ),
      headlineSmall: baseStyle.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.w700, // Bold
      ),

      // --- TITLE ---
      titleLarge: baseStyle.copyWith(
        fontSize: 22,
        fontWeight: FontWeight.w700, // Bold
      ),
      titleMedium: baseStyle.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w600, // SemiBold
      ),
      titleSmall: baseStyle.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w600, // SemiBold
      ),

      // --- BODY ---
      bodyLarge: baseStyle.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w400, // Regular
      ),
      bodyMedium: baseStyle.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w400, // Regular
      ),
      bodySmall: baseStyle.copyWith(
        color: subTextColor,
        fontSize: 12,
        fontWeight: FontWeight.w400, // Regular
      ),

      // --- LABEL ---
      labelLarge: baseStyle.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w600, // SemiBold
      ),
      labelMedium: baseStyle.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w600, // SemiBold
      ),
      labelSmall: baseStyle.copyWith(
        color: subTextColor,
        fontSize: 11,
        fontWeight: FontWeight.w400, // Regular
      ),
    );
  }
}
