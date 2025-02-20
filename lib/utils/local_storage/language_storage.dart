import 'package:shared_preferences/shared_preferences.dart';

class LanguageStorage {
  static const String _languageCodeKey =
      'languageCode'; // Key for storing the language code

  // Method to save the language code
  Future<void> saveLanguageCode(String languageCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        _languageCodeKey, languageCode); // Save the language code
  }

  // Method to load the language code
  Future<String?> loadLanguageCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_languageCodeKey); // Return the saved language code
  }
}
