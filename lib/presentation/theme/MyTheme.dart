import 'package:flutter/material.dart';

class MyTheme {
  // --- پالت رنگی تم روشن (Light) ---
  static const Color primaryColor = Color(0xFF217CF3);
  static const Color secondaryColor = Color(0xFF262A35);
  static const Color primaryTextColor = Color(0xFF262A35);
  static const Color secondaryTextColor = Color(0xFF757575);
  // static const Color secondaryTextColor = Color(0xFFB3B6BE);

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
      fontFamily: 'IranYekan',
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: Brightness.light,
        primary: primaryColor,
        secondary: secondaryColor,
      ),
      textTheme: prepareTextTheme(isDark: false),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
        titleTextStyle: TextStyle(
          fontFamily: 'IranYekan',
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
      fontFamily: 'IranYekan',
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
          fontFamily: 'IranYekan',
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

    // تعریف بیس استایل برای جلوگیری از تکرار fontFamily
    final baseStyle = TextStyle(fontFamily: 'IranYekan', color: textColor);

    return TextTheme(
      // --- DISPLAY ---
      displayLarge: baseStyle.copyWith(
        fontSize: 57,
        fontWeight: FontWeight.w400,
      ),
      displayMedium: baseStyle.copyWith(
        fontSize: 45,
        fontWeight: FontWeight.w400,
      ),
      displaySmall: baseStyle.copyWith(
        fontSize: 36,
        fontWeight: FontWeight.w400,
      ),

      // --- HEADLINE ---
      headlineLarge: baseStyle.copyWith(
        fontSize: 24,
        fontWeight:
            FontWeight.w700, // برای فونت‌های فارسی وزن بولد خوانایی بهتری دارد
      ),
      headlineMedium: baseStyle.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.w700,
      ),
      headlineSmall: baseStyle.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),

      // --- TITLE ---
      titleLarge: baseStyle.copyWith(fontSize: 22, fontWeight: FontWeight.w700),
      titleMedium: baseStyle.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      titleSmall: baseStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),

      // --- BODY ---
      bodyLarge: baseStyle.copyWith(fontSize: 16, fontWeight: FontWeight.w400),
      bodyMedium: baseStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w400),
      bodySmall: baseStyle.copyWith(
        color: subTextColor, // رنگ فرعی برای توضیحات کوچک
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),

      // --- LABEL ---
      labelLarge: baseStyle.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w500, // مناسب برای دکمه‌ها و چیپ‌ها
      ),
      labelMedium: baseStyle.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      labelSmall: baseStyle.copyWith(
        color: subTextColor,
        fontSize: 11,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
