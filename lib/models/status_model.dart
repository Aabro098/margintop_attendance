import 'package:margintop_solutions/models/user_model.dart';

class AttendanceResponse {
  final AttendanceData data;
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
      data: AttendanceData.fromJson(json['data']),
      count: json['count'],
      message: json['message'],
      status: json['status'],
    );
  }
}

class AttendanceData {
  final int id;
  final String? attendanceDate;
  final String? checkInTime;
  final String? checkOutTime;
  final String? status;
  final String? workSummary;
  final User user;

  AttendanceData({
    required this.id,
    this.attendanceDate,
    this.checkInTime,
    this.checkOutTime,
    this.status,
    this.workSummary,
    required this.user,
  });

  factory AttendanceData.fromJson(Map<String, dynamic> json) {
    return AttendanceData(
      id: json['id'],
      attendanceDate: json['attendance_date'],
      checkInTime: json['check_in_time'],
      checkOutTime: json['check_out_time'],
      status: json['status'],
      workSummary: json['work_summary'],
      user: User.fromJson(json['user']),
    );
  }
}
