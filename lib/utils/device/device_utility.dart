import 'package:flutter/material.dart';

class DeviceUtility {
  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }
}
