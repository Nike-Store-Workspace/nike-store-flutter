import 'package:flutter/material.dart';
import 'package:nike_store_flutter/data/repository/auth_repository_impl.dart';
import 'package:nike_store_flutter/presentation/auth/auth.dart';
import 'package:nike_store_flutter/presentation/root.dart';
import 'package:nike_store_flutter/presentation/theme/MyTheme.dart';
import 'package:nike_store_flutter/presentation/settings/app_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([authRepository.loadAuthInfo(), AppPreferences.load()]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(listenable: Listenable.merge([AppPreferences.locale, AppPreferences.themeMode]), builder: (context, _) => MaterialApp(
      title: 'Nike Store',
      theme: MyTheme.initTheme(),
      darkTheme: MyTheme.initDarkTheme(),
      themeMode: AppPreferences.themeMode.value,
      locale: AppPreferences.locale.value,
      supportedLocales: const [Locale('fa'), Locale('en')],
      home: Directionality(textDirection: AppPreferences.locale.value.languageCode == 'fa' ? TextDirection.rtl : TextDirection.ltr, child: const RootScreen()),
    ));
  }
}
