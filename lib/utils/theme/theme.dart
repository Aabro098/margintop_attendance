import 'package:flutter/material.dart';
import 'package:ordertracking_flutter/utils/theme/custom/text_theme.dart';

class AppTheme {
  AppTheme._();

  // *ThemeData created for both Light Theme and Dark Theme

  /*
  TODO: Add more Theme Classes
  TODO: Add more attributes to theme data
  */

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    textTheme: AppTextTheme.lightTextTheme,
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    textTheme: AppTextTheme.darkTextTheme,
  );
}
