import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:margintop_solutions/models/month_summary.dart';
import 'package:margintop_solutions/models/status_model.dart';
import 'package:margintop_solutions/utils/helpers/dio_client.dart';
import 'package:margintop_solutions/utils/helpers/helper_functions.dart';
import 'package:margintop_solutions/utils/providers/attendance_provider.dart';
import 'package:provider/provider.dart';

class AttendanceServices {
  Future<Map<String, dynamic>?> checkIn({
    required BuildContext context,
    required String status,
  }) async {
    try {
      final provider = context.read<AttendanceProvider>();
      final dio = await DioClient().initClient();
      final formData = FormData.fromMap({
        'status': status,
      });

      final response =
          await dio.post('/user/attendance/check-in', data: formData);

      final Map<String, dynamic> data = response.data;

      if (data['message'] == "Success" && data["status"] == 1) {
        final String checkIn = formatToTime(data['data']['check_in']);
        provider.updateStatus(checkIn: checkIn);
      }

      return data;
    } on DioException catch (e) {
      final apiResponse = DioClient.getErrorResponse(e);
      return apiResponse;
    }
  }

  Future<Map<String, dynamic>?> checkOut({
    required BuildContext context,
    required String workSummary,
  }) async {
    try {
      final provider = context.read<AttendanceProvider>();
      final dio = await DioClient().initClient();
      final formData = FormData.fromMap({
        'work_summary': workSummary,
      });

      final response =
          await dio.post('/user/attendance/check-out', data: formData);

      final Map<String, dynamic> data = response.data;

      if (data['message'] == "Success" && data["status"] == 1) {
        final String checkOut = formatToTime(data['data']['check_out']);
        provider.updateStatus(checkOut: checkOut);
      }

      return data;
    } on DioException catch (e) {
      final apiResponse = DioClient.getErrorResponse(e);
      return apiResponse;
    }
  }

  Future<Map<String, dynamic>?> absent({
    required BuildContext context,
    required String reason,
  }) async {
    try {
      final provider = context.read<AttendanceProvider>();
      final dio = await DioClient().initClient();
      final formData = FormData.fromMap({
        'work_summary': reason,
      });

      final response =
          await dio.post('/user/attendance/absent', data: formData);
      final Map<String, dynamic> data = response.data;

      if (data['message'] == "Success" && data["status"] == 1) {
        provider.updateStatus(isAbsent: true);
      }

      return data;
    } on DioException catch (e) {
      final apiResponse = DioClient.getErrorResponse(e);
      return apiResponse;
    }
  }

  Future<AttendanceResponse> getStatus() async {
    try {
      final dio = await DioClient().initClient();

      final response = await dio.get('/user/attendance/status');
      final Map<String, dynamic> data = response.data;

      return AttendanceResponse.fromJson(data);
    } on DioException catch (e) {
      final apiResponse = DioClient.getErrorResponse(e);
      return apiResponse;
    }
  }

  Future<AttendanceSummaryResponse> getSummary(int month) async {
    try {
      final dio = await DioClient().initClient();

      final response =
          await dio.get('/user/attendance/stats?year=2025&month=$month');
      // print("The response is $response");
      final Map<String, dynamic> data = response.data;

      return AttendanceSummaryResponse.fromJson(data);
    } on DioException catch (e) {
      final apiResponse = DioClient.getErrorResponse(e);
      return apiResponse;
    }
  }
}
