import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:margintop_solutions/screens/Auth/login.dart';
import 'package:margintop_solutions/utils/constants/api_constants.dart';
import 'package:margintop_solutions/utils/helpers/app_globals.dart';
import 'package:margintop_solutions/utils/local_storage/user_prefs.dart';

/// Class for Using the DioClient for managing HTTP networking.
class DioClient {
  DioClient._();

  //! ALWAYS USE  '_method': 'DELETE' OR 'PUT' inside data.
  //* Eg.
  //*  final formData = FormData.fromMap({
  //* '_method': 'DELETE',
  //* });
  //* final response = await dio.post('/user/delete', data: formData);

  /// Initialize the Dio Client with default parameters.
  static Future<Dio> initClient() async {
    final dio = Dio(
      BaseOptions(
        baseUrl: UrlStrings.baseUrl,
        connectTimeout: const Duration(seconds: 12),
        receiveTimeout: const Duration(seconds: 12),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'multipart/form-data',
        },
      ),
    );
    dio.interceptors.add(AuthInterceptor());
    return dio;
  }

  /// Initialize the Dio Client for public access without authentication (like for login).
  static Future<Dio> initPublicClient() async {
    return Dio(
      BaseOptions(
        baseUrl: UrlStrings.baseUrl,
        connectTimeout: const Duration(seconds: 12),
        receiveTimeout: const Duration(seconds: 12),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'multipart/form-data',
        },
      ),
    );
  }

  static String parseDioError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout ||
        e.type == DioExceptionType.connectionError) {
      return "Connection timed out / इन्टरनेट कनेक्शन असफल भयो।";
    }

    final response = e.response;

    if (response != null && response.data is Map<String, dynamic>) {
      final data = response.data as Map<String, dynamic>;

      // ✅ Check for multiple field errors FIRST
      final errors = data['errors'];
      if (errors != null && errors is Map<String, dynamic>) {
        List<String> allErrors = [];

        for (final entry in errors.entries) {
          final value = entry.value;

          if (value is List && value.isNotEmpty) {
            allErrors.add('${value.first}');
          } else if (value is String && value.isNotEmpty) {
            allErrors.add(value);
          }
        }

        if (allErrors.isNotEmpty) {
          return allErrors.join('\n');
        }
      } else if (errors is List) {
        for (final e in errors) {
          if (e is Map<String, dynamic>) {
            final msgs = (e['message'] as List<dynamic>?)?.join(', ') ?? '';
            if (msgs.isNotEmpty) return msgs;
          }
        }
      }

      // ✅ Fallback to generic message extraction for other formats
      final extractedMessage = extractMessage(data);
      if (extractedMessage != null) {
        return extractedMessage;
      }

      return 'Unknown server error';
    }

    return e.message ?? 'No response received';
  }

  static String formatFieldName(String field) {
    return field.replaceAll('_', ' ').toUpperCase();
  }

  static String? extractMessage(dynamic value) {
    if (value is String && value.isNotEmpty) {
      return value;
    }

    if (value is Map) {
      // Case 1: Check if "message" key contains field-specific errors
      if (value['message'] is Map) {
        final messageMap = value['message'] as Map;

        // Extract first field's error message
        for (final fieldValue in messageMap.values) {
          if (fieldValue is List && fieldValue.isNotEmpty) {
            // Return first error from the list
            return fieldValue.first?.toString();
          } else if (fieldValue is String && fieldValue.isNotEmpty) {
            return fieldValue;
          }
        }
      }

      // Case 2: Direct "message" with string value
      if (value['message'] is String &&
          (value['message'] as String).isNotEmpty) {
        return value['message'];
      }

      // Case 3: Check for direct field errors (email, phone, etc.) at root level
      for (final entry in value.entries) {
        if (entry.key == 'status') continue; // Skip status field

        if (entry.value is List && (entry.value as List).isNotEmpty) {
          return (entry.value as List).first?.toString();
        } else if (entry.value is String &&
            (entry.value as String).isNotEmpty) {
          return entry.value;
        }
      }

      // Case 4: Recursive fallback for nested structures
      for (final v in value.values) {
        final result = extractMessage(v);
        if (result != null) return result;
      }
    }

    if (value is List && value.isNotEmpty) {
      // Handle arrays of error messages
      return value.first?.toString();
    }

    return null;
  }
}

class AuthInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await UserPrefs.getToken();
    if (token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      // Clear auth token
      await UserPrefs().clearUser();

      // Navigate to login safely
      // await navigatorKey.currentState?.pushAndRemoveUntil(
      //   MaterialPageRoute(builder: (context) => const LoginScreen()),
      //   (_) => false,
      // );
    }

    handler.next(err); // IMPORTANT: continue error propagation
  }
}
