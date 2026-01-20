import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:margintop_solutions/services/user_services.dart';
import 'package:margintop_solutions/utils/local_storage/user_prefs.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    isLoading = true;
    try {
      final response = await UserServices().loginUser(
        email: email,
        password: password,
      );

      final responseData = response['data'];

      final token = responseData['token'];
      final name = responseData['user']['name'];

      await UserPrefs().saveUser(name, email, token);
    } on DioException {
      rethrow;
    } catch (e) {
      rethrow;
    } finally {
      isLoading = false;
    }
  }

  Future<void> requestChangePassword({required String email}) async {
    isLoading = true;
    try {
      await UserServices().requestChange(
        email: email,
      );
    } on DioException {
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading = false;
    }
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    isLoading = true;
    try {
      await UserServices().changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );
    } on DioException {
      rethrow;
    } catch (e) {
      rethrow;
    } finally {
      isLoading = false;
    }
  }
}
