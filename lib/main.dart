import 'package:deliveyapp/business_logic/utils/theme_manager.dart';
import 'package:flutter/material.dart';

import 'ui/views/splash_screen/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    ThemeManager themeManager = ThemeManager();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeManager.appLightTheme(),
      home: const Splash(),
    );
  }
}
