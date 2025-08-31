class AttendanceSummaryResponse {
  final AttendanceSummaryData data;
  final int count;
  final String message;
  final int status;

  AttendanceSummaryResponse({
    required this.data,
    required this.count,
    required this.message,
    required this.status,
  });

  factory AttendanceSummaryResponse.fromJson(Map<String, dynamic> json) {
    return AttendanceSummaryResponse(
      data: AttendanceSummaryData.fromJson(json['data']),
      count: json['count'],
      message: json['message'],
      status: json['status'],
    );
  }
}

class AttendanceSummaryData {
  final String month;
  final int year;
  final Summary summary;

  AttendanceSummaryData({
    required this.month,
    required this.year,
    required this.summary,
  });

  factory AttendanceSummaryData.fromJson(Map<String, dynamic> json) {
    return AttendanceSummaryData(
      month: json['month'],
      year: json['year'],
      summary: Summary.fromJson(json['summary']),
    );
  }
}

class Summary {
  final int presentDays;
  final int absentDays;
  final int leaveDays;
  final int remoteDays;
  final int totalHours;

  Summary({
    required this.presentDays,
    required this.absentDays,
    required this.leaveDays,
    required this.remoteDays,
    required this.totalHours,
  });

  factory Summary.fromJson(Map<String, dynamic> json) {
    final dynamic hours = json['total_hours'];
    return Summary(
      presentDays: json['present_days'],
      absentDays: json['absent_days'],
      leaveDays: json['leave_days'],
      remoteDays: json['remote_days'],
      totalHours: (hours is int)
          ? hours
          : (hours is double)
              ? hours.round()
              : 0, // fallback if null or unexpected
    );
  }
}
