// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

class AppColorsDark {
  AppColorsDark._();

  //! === Primary Brand Colors ===
  static const Color primary = Color(0xFF80CBC4); // lighter teal for dark mode
  static const Color secondary =
      Color(0xFF004D40); // dark teal background shade
  static const Color primaryDisabled = Color(0xFF424242);

  //! === Secondary Colors ===
  static const Color secondaryOpacity = Color(0x4D80CBC4); // 30% opacity
  static const Color secondaryClicked = Color(0xCC004D40); // 80% opacity

  //! === Info Button ===
  static const Color info = Color(0xFF64B5F6);

  //! === Background / Surface ===
  static const Color background = Color(0xFF121212);
  static const Color surface = Color(0xFF1E1E1E);
  static const Color container =
      Color(0xAA263238); // semi-transparent dark container

  //! === Tile / Hover / Selector ===
  static const Color tile = Color(0x2912969A); // 16% opacity (teal-ish)

  //! === Pills ===
  static const Color pillBackground = Color(0x1F80CBC4); // 12% opacity
  static const Color pillText = Color(0xFF80CBC4);

  //! === Error ===
  static const Color error = Color(0xFFEF5350);

  //! === Text Colors ===
  static const Color textPrimary = Colors.white70;
  static const Color textSecondary = Colors.white54;
  static const Color textTertiary = Colors.white38;
  static const Color textQuaternary = Colors.white30;
}
