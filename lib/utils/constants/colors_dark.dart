// ignore_for_file: public_member_api_docs
import 'package:flutter/material.dart';

class AppColorsDark {
  AppColorsDark._();

  //! === Primary Brand Colors ===
  static const Color primary = Color(0xFF80CBC4); // soft mint teal
  static const Color secondary = Color(0xFF00675B); // deep teal
  static const Color primaryDisabled = Color(0xFF37474F); // dark grey

  //! === Secondary Colors ===
  static const Color secondaryOpacity = Color(0x4D80CBC4); // 30% opacity
  static const Color secondaryClicked = Color(0xCC00675B); // 80% opacity

  //! === Info Button ===
  static const Color info = Color(0xFF4FC3F7); // bright sky blue

  //! === Background / Surface ===
  static const Color background = Color(0xFF121212); // almost black
  static const Color surface = Color(0xFF1E2C2B); // slightly lighter dark teal
  static const Color container =
      Color(0xFF1E1E1E); // semi-transparent dark container

  //! === Tile / Hover / Selector ===
  static const Color tile = Color(0x2912969A); // soft teal hover

  //! === Pills ===
  static const Color pillBackground = Color(0x1F80CBC4); // subtle teal overlay
  static const Color pillText = Color(0xFF80CBC4); // mint teal text

  //! === Error ===
  static const Color error = Color(0xFFEF5350); // bright red

  //! === Text Colors ===
  static const Color textPrimary = Colors.white70; // main text
  static const Color textSecondary = Colors.white54; // secondary text
  static const Color textTertiary = Colors.white38; // muted text
  static const Color textQuaternary = Colors.white30; // subtle text
}
