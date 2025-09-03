import 'package:margintop_solutions/models/user_model.dart';

class AttendanceResponse {
  final List<AttendanceData> data;
  final int count;
  final String message;
  final int status;

  AttendanceResponse({
    required this.data,
    required this.count,
    required this.message,
    required this.status,
  });

  factory AttendanceResponse.fromJson(Map<String, dynamic> json) {
    return AttendanceResponse(
      data: (json['data'] is List)
          ? (json['data'] as List)
              .map((e) => AttendanceData.fromJson(e))
              .toList()
          : (json['data'] == null
              ? []
              : [AttendanceData.fromJson(json['data'])]),
      count: json['count'] ?? 0,
      message: json['message'] ?? '',
      status: json['status'] ?? 0,
    );
  }
}

class AttendanceData {
  final int? id;
  final String? attendanceDate;
  final String? checkInTime;
  final String? checkOutTime;
  final String? status;
  final String? workSummary;
  final User? user;

  AttendanceData({
    this.id,
    this.attendanceDate,
    this.checkInTime,
    this.checkOutTime,
    this.status,
    this.workSummary,
    this.user,
  });

  factory AttendanceData.fromJson(Map<String, dynamic> json) {
    return AttendanceData(
      id: json['id'],
      attendanceDate: json['attendance_date'],
      checkInTime: json['check_in_time'],
      checkOutTime: json['check_out_time'],
      status: json['status'],
      workSummary: json['work_summary'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }
}
