import 'package:flutter/material.dart';

import '../constants/const_colors.dart';

class ThemeManager {
  ThemeData appLightTheme() {
    Color primaryColor = ColorsManager.green;
    return ThemeData(
      scaffoldBackgroundColor: ColorsManager.lightTeal,
      primaryColor: primaryColor,
      brightness: Brightness.light,
      hintColor: ColorsManager.greyText,
      fontFamily: 'Tajawal',
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: ColorsManager.black),
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding:
            const EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 8),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: ColorsManager.green),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
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
