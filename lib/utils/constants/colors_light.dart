// ignore_for_file: public_member_api_docs
import 'package:flutter/material.dart';

class AppColorsLight {
  AppColorsLight._();

  //! === Primary Brand Colors ===
  static const Color primary = Color(0xFF26A69A); // fresh mint teal
  static const Color secondary = Color(0xFF00796B); // darker teal accent
  static const Color primaryDisabled = Color(0xFFE0E0E0); // light grey disabled

  //! === Secondary Colors ===
  static const Color secondaryOpacity = Color(0x8026A69A); // 50% opacity
  static const Color secondaryClicked = Color(0xCC00796B); // 80% opacity

  //! === Info Button ===
  static const Color info = Color(0xFF29B6F6); // bright sky blue

  //! === Background / Surface ===
  static const Color background = Color(0xFFFFFFFF); // pure white
  static const Color surface =
      Color.fromARGB(255, 2, 13, 10); // light minty grey
  static const Color container = Color(0xFFEEEEEE); // very light teal container

  //! === Tile / Hover / Selector ===
  static const Color tile = Color(0x14007E6E); // subtle teal hover

  //! === Pills ===
  static const Color pillBackground = Color(0x0F26A69A); // soft mint overlay
  static const Color pillText = Color(0xFF26A69A); // mint text

  //! === Error ===
  static const Color error = Color(0xFFB00020); // modern red

  //! === Text Colors ===
  static const Color textPrimary = Color(0xFF212121); // dark text
  static const Color textSecondary = Color(0x99121212); // 60% opacity
  static const Color textTertiary = Color(0x73121212); // 45% opacity
  static const Color textQuaternary = Color(0xA6212121); // subtle dark

  //! === Logo / Accent ===
  static const Color logoColor = Color(0xFF26A69A); // mint teal for brand
}
