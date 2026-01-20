import 'package:dio/dio.dart';
import 'package:margintop_solutions/services/dio_services.dart';
import 'package:margintop_solutions/utils/constants/api_constants.dart';

class UserServices {
  static final UserServices _instance = UserServices._internal();

  factory UserServices() {
    return _instance;
  }

  UserServices._internal();

  Future<Map<String, dynamic>> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final dio = await DioClient.initClient();
      final formData = FormData.fromMap(
        {
          'email': email,
          'password': password,
        },
      );

      final response = await dio.post(UrlStrings.login, data: formData);

      final data = response.data;

      return data;
    } on DioException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> logout() async {
    try {
      final dio = await DioClient.initClient();

      final response = await dio.post(
        UrlStrings.logout,
      );
      final Map<String, dynamic> data = response.data;

      return data;
    } on DioException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      final dio = await DioClient.initClient();
      final formData = FormData.fromMap({
        'current_password': currentPassword,
        'new_password': newPassword,
      });

      final response =
          await dio.post(UrlStrings.changePassword, data: formData);
      final data = response.data;
      return data;
    } on DioException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> requestChange({
    required String email,
  }) async {
    try {
      final dio = await DioClient.initClient();
      final formData = FormData.fromMap({
        'email': email,
      });

      final response = await dio.post(UrlStrings.requestChange, data: formData);

      final Map<String, dynamic> data = response.data;

      return data;
    } on DioException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
