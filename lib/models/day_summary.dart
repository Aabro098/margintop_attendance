class AttendanceListResponse {
  final List<AttendanceData> data;
  final String message;
  final int status;

  AttendanceListResponse({
    required this.data,
    required this.message,
    required this.status,
  });

  factory AttendanceListResponse.fromJson(Map<String, dynamic> json) {
    return AttendanceListResponse(
      data: List<AttendanceData>.from(
          json['data'].map((x) => AttendanceData.fromJson(x))),
      message: json['message'],
      status: json['status'],
    );
  }
}

class AttendanceData {
  final int id;
  final String attendanceDate;
  final String? checkInTime;
  final String? checkOutTime;
  final String? status;
  final String? workSummary;

  AttendanceData({
    required this.id,
    required this.attendanceDate,
    this.checkInTime,
    this.checkOutTime,
    this.status,
    this.workSummary,
  });

  factory AttendanceData.fromJson(Map<String, dynamic> json) {
    return AttendanceData(
      id: json['id'],
      attendanceDate: json['attendance_date'],
      checkInTime: json['check_in_time'],
      checkOutTime: json['check_out_time'],
      status: json['status'],
      workSummary: json['work_summary'],
    );
  }
}
