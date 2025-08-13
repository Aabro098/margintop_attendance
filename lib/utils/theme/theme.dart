import 'package:flutter/material.dart';
import 'package:margintop_attendance/utils/constants/colors_light.dart';
import 'package:margintop_attendance/utils/theme/color_scheme.dart';
import 'package:margintop_attendance/utils/theme/custom/app_bar_theme.dart';
import 'package:margintop_attendance/utils/constants/colors_dark.dart';
import 'package:margintop_attendance/utils/theme/custom/drawer_theme.dart';
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
    primaryColor: AppColorsLight.primary,
    colorScheme: AppColorSchemes.lightColorScheme,
    textTheme: AppTypography.lightTextTheme,
    pageTransitionsTheme: AppPageTransitionsTheme.pageTransitionsTheme,
    inputDecorationTheme: AppInputDecoration.lightTheme,
    elevatedButtonTheme: AppElevatedButtonTheme.lightTheme,
    appBarTheme: AppAppBarTheme.lightTheme,
    drawerTheme: AppDrawerTheme.lightTheme,
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: AppColorsDark.primary,
    colorScheme: AppColorSchemes.darkColorScheme,
    textTheme: AppTypography.darkTextTheme,
    pageTransitionsTheme: AppPageTransitionsTheme.pageTransitionsTheme,
    inputDecorationTheme: AppInputDecoration.darkTheme,
    elevatedButtonTheme: AppElevatedButtonTheme.darkTheme,
    appBarTheme: AppAppBarTheme.darkTheme,
    drawerTheme: AppDrawerTheme.darkTheme,
  );
}
