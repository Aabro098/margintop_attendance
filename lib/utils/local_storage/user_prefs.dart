import 'package:shared_preferences/shared_preferences.dart';

class UserPrefs {
  // Save user data
  Future<void> saveUser(String name, String email, String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name);
    await prefs.setString('email', email);
    await prefs.setString('auth_token', token);
  }

  // Get user details
  Future<Map<String, dynamic>> getDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return {
      'name': prefs.getString('name'),
      'email': prefs.getString('email'),
    };
  }
}
