import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static final locale = ValueNotifier<Locale>(const Locale('fa'));
  static final themeMode = ValueNotifier<ThemeMode>(ThemeMode.system);
  static Future<void> load() async {
    final p = await SharedPreferences.getInstance();
    locale.value = Locale(p.getString('language') ?? 'fa');
    themeMode.value = ThemeMode.values.firstWhere((e) => e.name == (p.getString('theme') ?? 'system'), orElse: () => ThemeMode.system);
  }
  static Future<void> setLocale(Locale value) async { locale.value = value; final p = await SharedPreferences.getInstance(); await p.setString('language', value.languageCode); }
  static Future<void> setTheme(ThemeMode value) async { themeMode.value = value; final p = await SharedPreferences.getInstance(); await p.setString('theme', value.name); }
}
