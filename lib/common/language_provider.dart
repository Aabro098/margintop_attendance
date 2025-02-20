import 'package:flutter/material.dart'; // For using ChangeNotifier
import 'package:ordertracking_flutter/utils/local_storage/language_storage.dart';

class LanguageProvider with ChangeNotifier {
  String _languageCode = 'ne'; // Default language is English
  final LanguageStorage _languageStorage =
      LanguageStorage(); // Create an instance of SharedPreferencesService

  LanguageProvider() {
    _loadLanguagePreference(); // Load saved language preference when starting
  }

  String get languageCode => _languageCode; // Get the current language code

  void setLanguage(String languageCode) async {
    _languageCode = languageCode; // Update the language code
    await _languageStorage
        .saveLanguageCode(languageCode); // Save the new language code
    notifyListeners(); // Notify listeners to update UI
  }

  void _loadLanguagePreference() async {
    // Load saved language preference from shared preferences
    String? savedLanguageCode = await _languageStorage
        .loadLanguageCode(); // Get the saved language code
    if (savedLanguageCode != null) {
      _languageCode = savedLanguageCode; // Update to saved language code
      notifyListeners(); // Notify listeners to update UI
    }
  }
}
