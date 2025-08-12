import 'package:flutter/material.dart';
import 'package:margintop_attendance/utils/constants/colors_dark.dart';
import 'package:margintop_attendance/utils/constants/colors_light.dart';

class AppDrawerTheme {
  static DrawerThemeData lightTheme = const DrawerThemeData(
    backgroundColor: AppColorsLight.primary,
    elevation: 16,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(right: Radius.circular(20))),
  );

  static DrawerThemeData darkTheme = const DrawerThemeData(
    backgroundColor: AppColorsDark.primary,
    elevation: 16,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(right: Radius.circular(20))),
  );
}
