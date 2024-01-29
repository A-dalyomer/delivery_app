import 'package:flutter/material.dart';

import '../constants/const_colors.dart';

class ThemeManager {
  ThemeData appLightTheme() {
    Color primaryColor = ColorsManager.green;
    return ThemeData(
      scaffoldBackgroundColor: ColorsManager.lightTeal,
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
        ).titleLarge,
      ),
      primaryColor: primaryColor,
      brightness: Brightness.light,
      hintColor: ColorsManager.greyText,
      fontFamily: 'Tajawal',
      buttonTheme: ButtonThemeData(
        buttonColor: primaryColor,
        disabledColor: Colors.grey,
        minWidth: 20,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      buttonBarTheme: const ButtonBarThemeData(
        buttonPadding: EdgeInsets.only(left: 8, right: 8),
        buttonTextTheme: ButtonTextTheme.normal,
      ),
      textTheme: TextTheme(
        titleSmall: const TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: 'Tajawal',
        ),
        bodyMedium: const TextStyle(
          fontSize: 14,
          fontFamily: 'Tajawal',
        ),
        labelLarge: TextStyle(
          fontFamily: 'Tajawal',
          color: primaryColor,
        ),
      ).apply(
        bodyColor: ColorsManager.black,
      ),
    );
  }
}
