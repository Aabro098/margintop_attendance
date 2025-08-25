import 'package:flutter/material.dart';

class AppCardTheme {
  static CardThemeData lightTheme = CardThemeData(
    color: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16), // soft rounded corners
    ),
  );

  static CardThemeData darkTheme = CardThemeData(
    color: Colors.white10,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16), // soft rounded corners
    ),
  );
}
