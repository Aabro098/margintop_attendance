import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ordertracking_flutter/utils/local_storage/localization_storage.dart';

class LocalizationProvider extends ChangeNotifier {
  Locale _locale = const Locale('en', 'US');

  Locale get locale => _locale;

  // Load the saved locale from SharedPreferences when initialized
  Future<void> loadSavedLocale() async {
    _locale = await loadLocaleFromSharedPreference();
    notifyListeners();
  }

  // Change the locale and save it to SharedPreferences
  Future<void> switchLocale(Locale newLocale) async {
    _locale = newLocale;
    if (kDebugMode) {
      print(_locale);
    }
    saveLocaleToSharedPreference(newLocale);
    notifyListeners(); // Notify listeners to rebuild with the new locale
  }
}
