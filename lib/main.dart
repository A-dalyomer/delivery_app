import 'dart:io';
import 'package:bloomdeliveyapp/business_logic/constants/const_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'ui/views/splash_screen/splash.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(EasyLocalization(
    supportedLocales: const [
      Locale('en'),
      Locale('ar'),
    ],
    path: 'assets/translations',
    fallbackLocale: const Locale('en'),
    startLocale: const Locale('en'),
    useOnlyLangCode: true,
    child: const MyApp(),
  ));
}

const balbirGradient = LinearGradient(
    colors: [Color(0xFFFF82b8), Color(0xFFFF91ca)],
    tileMode: TileMode.clamp,
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    stops: [0.0, 1.0]);

const tajribaBackgroundLighter = Color(0xFFffffff);
var tajribaBackground = Colors.grey[200];
const tajribaPrimary = Color.fromARGB(255, 81, 149, 32);
const tajribaAccent = Color.fromARGB(255, 210, 164, 161);
const tajribaSeconday = Color.fromARGB(255, 4, 226, 100);
const tajribaPrimaryLighter = Color(0xFF94d3ac);

Map<int, Color> bluecareCustomColor = {
  50: const Color.fromRGBO(136, 14, 79, .1),
  100: const Color.fromRGBO(136, 14, 79, .2),
  200: const Color.fromRGBO(136, 14, 79, .3),
  300: const Color.fromRGBO(136, 14, 79, .8),
  400: const Color.fromRGBO(136, 14, 79, .5),
  500: const Color.fromRGBO(136, 14, 79, .6),
  600: const Color.fromRGBO(136, 14, 79, .7),
  700: const Color.fromRGBO(136, 14, 79, .8),
  800: const Color.fromRGBO(136, 14, 79, .9),
  900: const Color.fromRGBO(109, 92, 126, 1.0),
};
MaterialColor bluecareColor = MaterialColor(0xFF880E4F, bluecareCustomColor);
MaterialColor bcColor = MaterialColor(0xFFf75a0d, bluecareCustomColor);
MaterialColor bcSColor = MaterialColor(0xFF849547, bluecareCustomColor);
MaterialColor bcSTColor = MaterialColor(0xFFd3dbff, bluecareCustomColor);
final routeObserver = RouteObserver<PageRoute>();
const duration = Duration(milliseconds: 300);

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Color primaryColor = tajribaPrimary;
  Color accentColor = tajribaAccent;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: ColorsManager.lightTeal,
        snackBarTheme: const SnackBarThemeData(),
        /* bottomAppBarTheme: BottomAppBarTheme(
          color: tajribaBackgroundLighter,
          elevation: 2,
        ),
        bottomAppBarColor: tajribaBackgroundLighter, */
        dialogTheme: DialogTheme(
          backgroundColor: tajribaBackground,
          contentTextStyle: const TextStyle(
              fontFamily: 'Tajawal',
              color: Colors.black87,
              fontWeight: FontWeight.bold),
          titleTextStyle: const TextStyle(
            fontFamily: 'Tajawal',
            color: Colors.black87,
          ),
          //contentTextStyle: Theme.of(context).textTheme.bodyText2,
        ),
        appBarTheme: AppBarTheme(
          elevation: 0,
          color: Colors.white,
          centerTitle: true,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          toolbarTextStyle: TextTheme(
            titleSmall: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'Tajawal',
            ),
            headlineSmall: const TextStyle().copyWith(
              color: Colors.black,
              fontFamily: 'Tajawal',
              fontWeight: FontWeight.bold,
              //height: 2,
            ),
            titleLarge: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Colors.black,
                  fontFamily: 'Tajawal',
                  fontWeight: FontWeight.bold,
                  //height: 2,
                ),
          ).bodyMedium,
          titleTextStyle: TextTheme(
            titleSmall: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'Tajawal',
            ),
            headlineSmall: const TextStyle().copyWith(
              color: Colors.black,
              fontFamily: 'Tajawal',
              fontWeight: FontWeight.bold,
              //height: 2,
            ),
            titleLarge: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Colors.black,
                  fontFamily: 'Tajawal',
                  fontWeight: FontWeight.bold,
                  //height: 2,
                ),
          ).titleLarge,
        ),
        cardTheme: CardTheme(
          color: tajribaBackgroundLighter,
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        primaryColor: primaryColor,
        brightness: Brightness.light,
        hintColor: accentColor,
        fontFamily: 'Tajawal',
        buttonTheme: ButtonThemeData(
          buttonColor: primaryColor,
          disabledColor: Colors.grey,
          minWidth: 20,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        buttonBarTheme: const ButtonBarThemeData(
            buttonPadding: EdgeInsets.only(left: 8, right: 8),
            buttonTextTheme: ButtonTextTheme.normal),
        textTheme: TextTheme(
          headlineMedium: const TextStyle(
            fontWeight: FontWeight.bold,
            color: tajribaPrimary,
            fontFamily: 'Tajawal',
            //fontSize: 18,
          ),
          headlineSmall: TextStyle(
            fontWeight: FontWeight.bold,
            color: primaryColor,
            fontFamily: 'Tajawal',
          ),
          titleLarge: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontFamily: 'Tajawal',
            //height: 2,
          ),
          titleMedium: TextStyle(
            fontWeight: FontWeight.bold,
            color: primaryColor,
            fontFamily: 'Tajawal',
          ),
          titleSmall: const TextStyle(
              //height: 2,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'Tajawal'),
          bodyLarge: const TextStyle(
            fontWeight: FontWeight.normal,
            height: 1.5,
            fontSize: 14,
            fontFamily: 'Tajawal',
            color: Colors.black,
          ),
          bodyMedium: const TextStyle(
            fontSize: 14,
            //height: 1,
            fontFamily: 'Tajawal',
            color: Colors.grey,
          ),
          labelLarge: TextStyle(
            fontFamily: 'Tajawal',
            //height: 2,
            color: primaryColor,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsetsDirectional.fromSTEB(12, 8, 12, 8),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(8)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: tajribaPrimary),
              borderRadius: BorderRadius.circular(8)),
          errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.redAccent),
              borderRadius: BorderRadius.circular(8)),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.redAccent),
              borderRadius: BorderRadius.circular(8)),
          filled: true,
          fillColor: tajribaBackgroundLighter,

          labelStyle: const TextStyle(
            fontSize: 12.0,
            fontFamily: 'Tajawal',
            color: Colors.grey,
          ),
          hintStyle: const TextStyle(
            fontSize: 12.0,
            fontFamily: 'Tajawal',
            color: Colors.grey,
          ),
          //contentPadding: EdgeInsetsDirectional.only(top: 16),
          //isDense: true,
          prefixStyle: Theme.of(context).textTheme.bodyMedium,
        ),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: bluecareColor)
            .copyWith(background: tajribaBackground),
      ),
      home: const Splash(),
      navigatorObservers: [routeObserver],
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
