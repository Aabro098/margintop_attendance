import 'package:flutter/material.dart';
import 'package:margintop_solutions/utils/constants/colors_light.dart';
import 'package:margintop_solutions/utils/constants/colors_dark.dart';
import 'package:margintop_solutions/utils/constants/sizes.dart';
import 'package:margintop_solutions/utils/theme/custom/text_theme.dart';

/// Class for Elevated Button Theme with static variable `lightTheme`
class AppElevatedButtonTheme {
  /// Static variable for Elevated Button (Light)
  static ElevatedButtonThemeData lightTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      splashFactory: NoSplash.splashFactory,
      backgroundColor: AppColorsLight.primary,
      foregroundColor: Colors.white, // Text/Icon color
      disabledBackgroundColor: Colors.grey.withAlpha(172),
      minimumSize: const Size(double.infinity, 52),
      textStyle: AppTypography.lightTextTheme.titleMedium,
      padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.md, vertical: AppSizes.sm),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
      ),
      elevation: 1,
    ),
  );
  static ElevatedButtonThemeData darkTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      splashFactory: NoSplash.splashFactory,
      backgroundColor: AppColorsDark.primary,
      foregroundColor: Colors.white, // Dark surface for contrast
      disabledBackgroundColor: Colors.grey.withAlpha(42),
      minimumSize: const Size(double.infinity, 52),
      textStyle: AppTypography.lightTextTheme.titleMedium,
      padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.md, vertical: AppSizes.sm),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
      ),
      elevation: 1,
    ),
  );
}
