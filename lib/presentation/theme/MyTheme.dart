import 'package:flutter/material.dart';

class MyTheme {
  // --- نام فونت اصلی پروژه ---
  static const String defaultFontFamily = 'YekanBakh';

  // --- پالت رنگی تم روشن (Light) ---
  static const Color primaryColor = Color(0xFF217CF3);
  static const Color secondaryColor = Color(0xFF262A35);
  static const Color primaryTextColor = Color(0xFF262A35);
  static const Color secondaryTextColor = Color.fromARGB(255, 167, 166, 166);
  static const Color surfaceColor = Color.fromARGB(255, 240, 240, 240);

  // --- پالت رنگی تم تاریک (Dark) ---
  static const Color darkBackgroundColor = Color(0xFF121212);
  static const Color darkSurfaceColor = Color(0xFF1E1E1E);
  static const Color darkPrimaryTextColor = Color(0xFFFFFFFF);
  static const Color darkSecondaryTextColor = Color.fromARGB(
    255,
    167,
    166,
    166,
  );

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
        primaryContainer: primaryColor, // جهت اطمینان M3
        onPrimaryContainer: Colors.white,
      ),
      // 📌 استایل اختصاصی FAB برای کل پروژه (حل مشکل رنگ و گردی کامل)
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: darkSurfaceColor,
        foregroundColor: darkPrimaryTextColor,
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
        primary: primaryColor,
        surface: darkSurfaceColor,
        primaryContainer: primaryColor,
        onPrimaryContainer: Colors.white,
      ),
      // 📌 استایل اختصاصی FAB برای تم تاریک
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: surfaceColor,
        foregroundColor: primaryTextColor,
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

    final baseStyle = TextStyle(
      fontFamily: defaultFontFamily,
      color: textColor,
    );

    return TextTheme(
      displayLarge: baseStyle.copyWith(
        fontSize: 57,
        fontWeight: FontWeight.w300,
      ),
      displayMedium: baseStyle.copyWith(
        fontSize: 45,
        fontWeight: FontWeight.w300,
      ),
      displaySmall: baseStyle.copyWith(
        fontSize: 36,
        fontWeight: FontWeight.w400,
      ),
      headlineLarge: baseStyle.copyWith(
        fontSize: 32,
        fontWeight: FontWeight.w800,
      ),
      headlineMedium: baseStyle.copyWith(
        fontSize: 28,
        fontWeight: FontWeight.w700,
      ),
      headlineSmall: baseStyle.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.w700,
      ),
      titleLarge: baseStyle.copyWith(fontSize: 22, fontWeight: FontWeight.w700),
      titleMedium: baseStyle.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      titleSmall: baseStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
      bodyLarge: baseStyle.copyWith(fontSize: 16, fontWeight: FontWeight.w400),
      bodyMedium: baseStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w400),
      bodySmall: baseStyle.copyWith(
        color: subTextColor,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      labelLarge: baseStyle.copyWith(
        color: subTextColor,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      labelMedium: baseStyle.copyWith(
        color: subTextColor,
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
      labelSmall: baseStyle.copyWith(
        color: subTextColor,
        fontSize: 11,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
