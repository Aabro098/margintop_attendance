import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';

// class LanguageStorage {
//   static const String _languageCodeKey =
//       'languageCode'; // Key for storing the language code

//   // Method to save the language code
//   Future<void> saveLanguageCode(String languageCode) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString(
//         _languageCodeKey, languageCode); // Save the language code
//   }

//   // Method to load the language code
//   Future<String?> loadLanguageCode() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_languageCodeKey); // Return the saved language code
//   }
// }

Future<void> saveLocaleToSharedPreference(Locale newLocale) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('selected_language', newLocale.languageCode);
  await prefs.setString('selected_country', newLocale.countryCode ?? '');
}

Future<Locale> loadLocaleFromSharedPreference() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? languageCode = prefs.getString('selected_language');
  String? countryCode = prefs.getString('selected_country');
  Locale locale = Locale('en', 'US');
  if (languageCode != null) {
    locale = Locale(languageCode, countryCode);
  }
  return locale;
}

Future<void> clearSharedPreferences() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.clear();
}
