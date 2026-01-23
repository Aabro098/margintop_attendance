import 'package:shared_preferences/shared_preferences.dart';

class UserPrefs {
  // Save user data
  Future<void> saveUser(String name, String email, String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name);
    await prefs.setString('auth_token', token);
  }

  // Get user details
  Future<String> getName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('name');
    return name ?? '';
  }

  static Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token') ?? '';
  }

  Future<void> clearUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
