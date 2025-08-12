import 'package:flutter/material.dart';
import 'package:margintop_attendance/utils/theme/custom/elevated_button_theme.dart';
import 'package:margintop_attendance/utils/theme/custom/input_decoration_theme.dart';
import 'package:margintop_attendance/utils/theme/custom/page_transitions_theme.dart';
import 'package:margintop_attendance/utils/theme/custom/text_theme.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    textTheme: AppTypography.lightTextTheme,
    pageTransitionsTheme: AppPageTransitionsTheme.pageTransitionsTheme,
    inputDecorationTheme: AppInputDecoration.lightTheme,
    elevatedButtonTheme: AppButtonTheme.lightTheme,
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    textTheme: AppTypography.darkTextTheme,
    pageTransitionsTheme: AppPageTransitionsTheme.pageTransitionsTheme,
    inputDecorationTheme: AppInputDecoration.darkTheme,
    elevatedButtonTheme: AppButtonTheme.darkTheme,
  );
}
