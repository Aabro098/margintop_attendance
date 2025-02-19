import 'package:shared_preferences/shared_preferences.dart';

class LanguageStorage {
  static const String _keyLanguage = "language_code";

  static Future<void> saveLanguage(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyLanguage, languageCode);
  }

  static Future<String> getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyLanguage) ?? 'en'; // Default: English
  }
}
