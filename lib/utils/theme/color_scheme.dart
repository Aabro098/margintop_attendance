import 'package:flutter/material.dart';
import 'package:margintop_attendance/utils/constants/colors_light.dart';
import 'package:margintop_attendance/utils/constants/colors_dark.dart';

class AppColorSchemes {
  AppColorSchemes._();

  /// Light Color Scheme
  static const ColorScheme lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: AppColorsLight.primary,
    onPrimary: Colors.white,
    secondary: AppColorsLight.secondary,
    onSecondary: Colors.white,
    surface: Colors.white,
    onSurface: AppColorsLight.textPrimary,
    error: AppColorsLight.error,
    onError: Colors.white,
  );

  /// Dark Color Scheme
  static const ColorScheme darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: AppColorsDark.primary,
    onPrimary: Colors.black,
    secondary: AppColorsDark.secondary,
    onSecondary: Colors.white,
    surface: AppColorsDark.surface,
    onSurface: AppColorsDark.textPrimary,
    error: AppColorsDark.error,
    onError: Colors.black,
  );
}
