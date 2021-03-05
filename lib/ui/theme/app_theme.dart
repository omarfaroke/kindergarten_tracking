import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    fontFamily: "DinNextLtW23",
    backgroundColor: AppColors.lightAccent,
    primaryColor: AppColors.lightPrimary,
    accentColor: AppColors.lightAccent,
    scaffoldBackgroundColor: AppColors.lightAccent,
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: AppColors.lightTextAppBar),
      actionsIconTheme: IconThemeData(color: AppColors.lightTextAppBar),
      elevation: 0,
      textTheme: TextTheme(
        // ignore: deprecated_member_use
        title: TextStyle(
          fontFamily: "DinNextLtW23",
          color: AppColors.lightTextAppBar,
          fontSize: 20,
          fontWeight: FontWeight.w800,
        ),
      ),
    ),
    buttonColor: AppColors.buttonColor,
    iconTheme: IconThemeData(
      color: AppColors.iconColor,
    ),
  );

  static ThemeData dark = light;

  static List<ThemeData> get getThemes {
    return [light];
  }
}
