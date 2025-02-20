import 'dart:convert'; // For converting JSON strings
import 'package:flutter/services.dart'; // For loading files
import 'package:flutter/material.dart'; // For using Flutter widgets

class AppLocalizations {
  final Locale locale; // The current locale (language) of the app

  AppLocalizations(this.locale); // Constructor to set the locale

  static AppLocalizations? of(BuildContext context) {
    // Get the current AppLocalizations instance
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      AppLocalizationsDelegate();

  static Map<String, String>? _localizedStrings; // Store translations

  Future<bool> load() async {
    // Load the JSON file for the current language
    String jsonString = await rootBundle
        .loadString('lib/localization/${locale.languageCode}.json');

    // Convert JSON string to a map
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    // Map keys to strings
    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });
    return true; // Indicate loading is complete
  }

  String translate(String key) {
    // Get the translated text for a given key
    return _localizedStrings![key] ?? key; // Return key if no translation found
  }
}

// Delegate class to manage localization
class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    // Check if the locale is supported (English or Nepali)
    return ['en', 'ne'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations =
        AppLocalizations(locale); // Create instance for the locale
    await localizations.load(); // Load translations
    return localizations; // Return loaded localizations
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false; // No need to reload
}
