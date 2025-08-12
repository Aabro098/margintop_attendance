import 'package:flutter/material.dart';
import 'package:margintop_attendance/utils/constants/colors.dart';

class AppColorSchemes {
  static const Color seedColor = Color(0xFF37474F); // Base color

  /// Light Color Scheme
  static ColorScheme lightColorScheme = ColorScheme.fromSeed(
    seedColor: seedColor,
    brightness: Brightness.light,
    primary: AppColors.primaryLight,
    secondary: AppColors.secondaryLight,
    surface: Colors.white,
    onPrimary: Colors.white,
    onSecondary: Colors.black,
    onSurface: Colors.black87,
  );

  /// Dark Color Scheme
  static ColorScheme darkColorScheme = ColorScheme.fromSeed(
    seedColor: seedColor,
    brightness: Brightness.dark,
    primary: AppColors.primaryLight,
    secondary: AppColors.secondaryLight,
    surface: const Color(0xFF1E1E1E),
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: Colors.white70,
  );
}
