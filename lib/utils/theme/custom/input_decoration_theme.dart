import 'package:flutter/material.dart';
import 'package:margintop_solutions/utils/constants/colors_light.dart';
import 'package:margintop_solutions/utils/constants/colors_dark.dart';
import 'package:margintop_solutions/utils/constants/sizes.dart';
import 'package:margintop_solutions/utils/theme/custom/text_theme.dart';

/// Class for Input Decoration Theme with static variable `lightTheme`
class AppInputDecoration {
  /// Static variable for Input Decoration (Light)
  static InputDecorationTheme lightTheme = InputDecorationTheme(
    hintStyle: AppTypography.lightTextTheme.titleMedium,
    errorMaxLines: 3,
    errorStyle:
        AppTypography.lightTextTheme.titleSmall?.copyWith(color: Colors.red),
    contentPadding: const EdgeInsets.symmetric(
      vertical: AppSizes.md,
      horizontal: AppSizes.md,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        color: Colors.black,
        width: 1.2,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        color: Colors.red,
        width: 1.2,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        color: AppColorsLight.primary,
        width: 1.2,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        color: AppColorsLight.primary,
        width: 1.2,
      ),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        color: Colors.black,
        width: 1.2,
      ),
    ),
  );

  static InputDecorationTheme darkTheme = InputDecorationTheme(
    hintStyle: AppTypography.darkTextTheme.titleMedium,
    errorMaxLines: 3,
    errorStyle:
        AppTypography.darkTextTheme.titleSmall?.copyWith(color: Colors.red),
    contentPadding: const EdgeInsets.symmetric(
      vertical: AppSizes.md,
      horizontal: AppSizes.md,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        color: Colors.white,
        width: 1.2,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        color: Colors.red,
        width: 1.2,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        color: AppColorsDark.primary,
        width: 1.2,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        color: AppColorsDark.primary,
        width: 1.2,
      ),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        color: Colors.white,
        width: 1.2,
      ),
    ),
  );
}
