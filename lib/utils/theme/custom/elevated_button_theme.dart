import 'package:flutter/material.dart';
import 'package:margintop_attendance/utils/constants/colors_light.dart';
import 'package:margintop_attendance/utils/constants/colors_dark.dart';
import 'package:margintop_attendance/utils/theme/custom/text_theme.dart';

/// Class for Elevated Button Theme with static variable `lightTheme`
class AppElevatedButtonTheme {
  /// Static variable for Elevated Button (Light)
  static ElevatedButtonThemeData lightTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColorsLight.primary,
      foregroundColor: Colors.white, // Text/Icon color
      minimumSize: const Size(double.infinity, 52),
      textStyle: AppTypography.lightTextTheme.titleLarge,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 1,
    ),
  );
  static ElevatedButtonThemeData darkTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColorsDark.primary,
      foregroundColor: Colors.white, // Dark surface for contrast
      minimumSize: const Size(double.infinity, 52),
      textStyle: AppTypography.lightTextTheme.titleLarge,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 1,
    ),
  );
}
