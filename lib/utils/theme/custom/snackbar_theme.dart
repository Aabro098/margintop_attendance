import 'package:flutter/material.dart';
import 'package:margintop_attendance/utils/constants/sizes.dart';

class AppSnackbarTheme {
  static SnackBarThemeData theme = SnackBarThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.md),
    ),
    behavior: SnackBarBehavior.floating,
    contentTextStyle: const TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    elevation: 5,
  );
}
