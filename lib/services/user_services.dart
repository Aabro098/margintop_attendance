import 'package:dio/dio.dart';
import 'package:margintop_attendance/utils/helpers/dio_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserServices {
  Future<Map<String, dynamic>?> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final dio = await DioClient().initClient();
      final formData = FormData.fromMap({'email': email, 'password': password});

      final response = await dio.post('/user/login', data: formData);

      final Map<String, dynamic> data = response.data;

      if (data['message'] == "Success" && data["status"] == 1) {
        final token = data['data']['token'];
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', token);
      }

      return data;
    } on DioException catch (e) {
      final apiResponse = DioClient.getErrorResponse(e);
      return apiResponse;
    }
  }

  Future<Map<String, dynamic>?> userDetails() async {
    try {
      final dio = await DioClient().initClient();

      final response = await dio.get('/user/me');

      final Map<String, dynamic> data = response.data;

      return data;
    } on DioException catch (e) {
      DioClient.checkDioError(e);
      return null;
    }
  }

  Future<Map<String, dynamic>?> logout() async {
    try {
      final dio = await DioClient().initClient();

      final response = await dio.post(
        '/user/logout',
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      final Map<String, dynamic> data = response.data;

      return data;
    } on DioException catch (e) {
      final apiResponse = DioClient.getErrorResponse(e);
      return apiResponse;
    }
  }

  Future<Map<String, dynamic>?> changePassword({
    required String currentPassword,
    required String confirmPassword,
  }) async {
    try {
      final dio = await DioClient().initClient();
      final formData = FormData.fromMap({
        'current_password': currentPassword,
        'new_password': confirmPassword,
      });

      final response = await dio.put('/user/update-password', data: formData);

      final Map<String, dynamic> data = response.data;

      return data;
    } on DioException catch (e) {
      final apiResponse = DioClient.getErrorResponse(e);
      return apiResponse;
    }
  }

  Future<Map<String, dynamic>?> requestChange({
    required String email,
  }) async {
    try {
      final dio = await DioClient().initClient();
      final formData = FormData.fromMap({
        'email': email,
      });

      final response = await dio.post('/user/forgot-password', data: formData);

      final Map<String, dynamic> data = response.data;

      return data;
    } on DioException catch (e) {
      final apiResponse = DioClient.getErrorResponse(e);
      return apiResponse;
    }
  }
}
