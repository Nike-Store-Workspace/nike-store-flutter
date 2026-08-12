import 'package:flutter/material.dart';
import 'package:nike_store_flutter/presentation/root.dart';
import 'package:nike_store_flutter/presentation/theme/MyTheme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nike Store',
      theme: MyTheme.initTheme(),
      darkTheme: MyTheme.initDarkTheme(),
      themeMode: ThemeMode.system,
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: const RootScreen(),
      ),
    );
  }
}
