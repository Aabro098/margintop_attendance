import 'package:dio/dio.dart';
import 'package:margintop_solutions/models/day_summary.dart';
import 'package:margintop_solutions/models/month_summary.dart';
import 'package:margintop_solutions/models/status_model.dart';
import 'package:margintop_solutions/services/dio_services.dart';
import 'package:margintop_solutions/utils/constants/api_constants.dart';

class AttendanceServices {
  static final AttendanceServices _instance = AttendanceServices._internal();

  factory AttendanceServices() {
    return _instance;
  }

  AttendanceServices._internal();

  Future<Map<String, dynamic>> checkIn({
    required String status,
  }) async {
    try {
      final dio = await DioClient.initClient();

      final formData = FormData.fromMap({
        'status': status,
      });
      final response = await dio.post(UrlStrings.checkIn, data: formData);
      final data = response.data;
      return data;
    } on DioException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> checkOut({
    required String workSummary,
  }) async {
    try {
      final dio = await DioClient.initClient();
      final formData = FormData.fromMap({
        'work_summary': workSummary,
      });

      final response = await dio.post(UrlStrings.checkOut, data: formData);
      final data = response.data;
      return data;
    } on DioException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> absent({
    required String reason,
  }) async {
    try {
      final dio = await DioClient.initClient();
      final formData = FormData.fromMap({
        'work_summary': reason,
      });

      final response = await dio.post(UrlStrings.absent, data: formData);
      final data = response.data;
      return data;
    } on DioException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<AttendanceResponse> getStatus() async {
    try {
      final dio = await DioClient.initClient();

      final response = await dio.get(UrlStrings.getStatus);
      final Map<String, dynamic> data = response.data;

      return AttendanceResponse.fromJson(data);
    } on DioException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<AttendanceSummaryResponse> getSummaryMonth({
    required int year,
    required int month,
    int? day,
  }) async {
    try {
      final dio = await DioClient.initClient();

      final query = {
        "year": year,
        "month": month,
      };

      final response = await dio.get(UrlStrings.stats, queryParameters: query);

      final Map<String, dynamic> data = response.data;

      return AttendanceSummaryResponse.fromJson(data);
    } on DioException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<AttendanceListResponse> getSummaryDay({
    required int year,
    required int month,
    required int day,
  }) async {
    try {
      final dio = await DioClient.initClient();

      final query = {
        "year": year,
        "month": month,
        "day": day,
      };

      final response = await dio.get(UrlStrings.stats, queryParameters: query);

      final Map<String, dynamic> data = response.data;

      return AttendanceListResponse.fromJson(data);
    } on DioException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
