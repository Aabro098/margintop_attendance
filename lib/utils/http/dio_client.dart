import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioClient {
  late Dio _dio;

  // Singleton instance of DioClient
  static final DioClient _instance = DioClient._internal();
  factory DioClient() => _instance;

  // Constructor (_internal)
  DioClient._internal() {
    // Create a new instance of DioClient
    _dio = Dio(
      BaseOptions(
        baseUrl: 'http://localhost:3000',
        connectTimeout: Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        contentType: 'application/json',
        responseType: ResponseType.json,
      ),
    );

    // Adding Middleware to DioClient
    _dio.interceptors.addAll([
      LogInterceptor(requestBody: true, responseBody: true),
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          options.headers["Authorization"] = "Bearer YOUR_ACCESS_TOKEN";
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          _handleDioError(e);
          return handler.next(e);
        },
      ),
    ]);
  }

  // Getter for the dio
  Dio get dio => _dio;

  Future<Response?> get(String endpoint,
      {Map<String, dynamic>? queryParams}) async {
    try {
      Response response =
          await _dio.get(endpoint, queryParameters: queryParams);
      return response;
    } catch (e) {
      debugPrint("GET request error: $e");
      return null;
    }
  }

  Future<Response?> post(String endpoint, {dynamic data}) async {
    try {
      Response response = await _dio.post(endpoint, data: jsonEncode(data));
      return response;
    } catch (e) {
      debugPrint("POST request error: $e");
      return null;
    }
  }

  Future<Response?> put(String endpoint, {dynamic data}) async {
    try {
      Response response = await _dio.put(endpoint, data: jsonEncode(data));
      return response;
    } catch (e) {
      debugPrint("PUT request error: $e");
      return null;
    }
  }

  Future<Response?> delete(String endpoint) async {
    try {
      Response response = await _dio.delete(endpoint);
      return response;
    } catch (e) {
      debugPrint("DELETE request error: $e");
      return null;
    }
  }

  void _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        debugPrint("Connection timeout error");
        break;
      case DioExceptionType.receiveTimeout:
        debugPrint("Receive timeout error");
        break;
      case DioExceptionType.badResponse:
        debugPrint(
            "Bad response: ${e.response?.statusCode} - ${e.response?.data}");
        break;
      case DioExceptionType.cancel:
        debugPrint("Request cancelled");
        break;
      default:
        debugPrint("Unknown error: ${e.message}");
    }
  }
}
