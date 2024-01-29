import 'dart:io';

import 'package:bloomdeliveyapp/business_logic/utils/theme_manager.dart';
import 'package:bloomdeliveyapp/services/service_locator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'business_logic/utils/http_overrides.dart';
import 'ui/views/splash_screen/splash.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  setupServiceLocator();
  runApp(EasyLocalization(
    supportedLocales: const [Locale('en'), Locale('ar')],
    path: 'assets/translations',
    fallbackLocale: const Locale('en'),
    startLocale: const Locale('en'),
    useOnlyLangCode: true,
    child: const MyApp(),
  ));
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
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      theme: themeManager.appLightTheme(),
      home: const Splash(),
    );
  }
}
