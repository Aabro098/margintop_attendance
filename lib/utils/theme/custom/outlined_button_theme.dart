import 'package:flutter/material.dart';
import 'package:margintop_attendance/utils/constants/colors_dark.dart';
import 'package:margintop_attendance/utils/constants/colors_light.dart';
import 'package:margintop_attendance/utils/theme/custom/text_theme.dart';

/// Class for Outlined Button Theme with static variables for light and dark themes
class AppOutlinedButtonTheme {
  /// Static variable for Outlined Button (Light)
  static OutlinedButtonThemeData lightTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: AppColorsLight.primary,
      textStyle: AppTypography.lightTextTheme.titleLarge,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      minimumSize: const Size(double.infinity, 48),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8), // Less circular
      ),
      side: const BorderSide(
        color: AppColorsLight.primary,
      ),
    ),
  );

  /// Static variable for Outlined Button (Dark)
  static OutlinedButtonThemeData darkTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      textStyle: AppTypography.lightTextTheme.titleLarge,
      foregroundColor: AppColorsDark.primary,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      minimumSize: const Size(double.infinity, 48),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8), // Match light theme
      ),
      side: const BorderSide(
        color: AppColorsDark.primary,
      ),
    ),
  );
}
