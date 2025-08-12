import 'package:flutter/material.dart';
import 'package:margintop_attendance/utils/constants/colors_light.dart';
import 'package:margintop_attendance/utils/constants/colors_dark.dart';
import 'package:margintop_attendance/utils/theme/custom/text_theme.dart';

class AppAppBarTheme {
  static AppBarTheme lightTheme = AppBarTheme(
    backgroundColor: AppColorsLight.primary,
    foregroundColor: Colors.white,
    titleTextStyle: AppTypography.lightTextTheme.displaySmall,
    centerTitle: true,
    toolbarHeight: 56,
    leadingWidth: 72,
    elevation: 0,
  );

  static AppBarTheme darkTheme = AppBarTheme(
    backgroundColor: AppColorsDark.primary,
    foregroundColor: Colors.white,
    titleTextStyle: AppTypography.darkTextTheme.displaySmall,
    centerTitle: true,
    toolbarHeight: 56,
    leadingWidth: 72,
    elevation: 0,
  );
}
