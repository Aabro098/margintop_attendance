import 'package:flutter/material.dart';

class LocalizationManager {
  static const List<Map<String, dynamic>> supportedLocales = [
    {'locale': Locale('en', 'US'), 'full_name': 'English'},
    {'locale': Locale('ne', 'NP'), 'full_name': 'Nepali'},
    // {'locale': Locale('ca', 'ES'), 'full_name': 'Català'},
    // {'locale': Locale('de', 'DE'), 'full_name': 'Deutsch'},
    // {'locale': Locale('es', 'ES'), 'full_name': 'Español'},
    // {'locale': Locale('fr', 'FR'), 'full_name': 'Français'},
    // {'locale': Locale('it', 'IT'), 'full_name': 'Italiano'}
  ];

  // Helper to retrieve only the supported locales for MaterialApp
  static List<Locale> get supportedLocaleList =>
      supportedLocales.map((e) => e['locale'] as Locale).toList();
}
