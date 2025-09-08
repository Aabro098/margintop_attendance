import 'package:shared_preferences/shared_preferences.dart';

Future<void> clearSharedPreferences() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('auth_token');
  await prefs.remove('name');
  await prefs.remove('email');
}
