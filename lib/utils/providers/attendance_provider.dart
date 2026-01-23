import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:margintop_solutions/services/attendance_services.dart';
import 'package:margintop_solutions/utils/constants/enums.dart';
import 'package:margintop_solutions/utils/helpers/helper_functions.dart';

class AttendanceProvider with ChangeNotifier {
  String? _checkIn;
  String? _checkOut;
  WorkLocation? _location = WorkLocation.home;
  bool _isAbsent = false;

  int _presentDays = 0;
  int _absentDays = 0;
  int _totalHours = 0;

  int get presentDays => _presentDays;
  int get absentDays => _absentDays;
  int get totalHours => _totalHours;

  bool _isFetchingStatus = false;
  bool get isFetchingStatus => _isFetchingStatus;

  set isFetchingStatus(bool value) {
    _isFetchingStatus = value;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  String? get checkIn => _checkIn;
  String? get checkOut => _checkOut;
  bool get isAbsent => _isAbsent;
  WorkLocation? get location => _location;

  Future<void> initializeProvider() async {
    isFetchingStatus = true;
    try {
      await fetchSummary();
      await fetchStatus();
    } finally {
      isFetchingStatus = false;
    }
    return;
  }

  Future<void> fetchStatus() async {
    try {
      final response = await AttendanceServices().getStatus();

      final attendance = response.data.first;

      _checkIn = attendance.checkInTime;
      _checkOut = attendance.checkOutTime;
      String? status = attendance.status;
      if (status == "absent") {
        updateStatus(isAbsent: true);
      } else if (status == "remote") {
        _location = WorkLocation.home;
        await updateStatus(location: _location);
      } else if (status == "present") {
        _location = WorkLocation.office;
        await updateStatus(location: _location);
      }

      if (checkIn != null) {
        await updateStatus(checkIn: formatToTime(checkIn ?? ''));
      }

      if (checkOut != null) {
        await updateStatus(checkOut: formatToTime(checkOut ?? ''));
      }
    } on DioException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> userCheckIn(WorkLocation location) async {
    isLoading = true;
    try {
      final response = await AttendanceServices().checkIn(
        status: location.statusValue,
      );

      final String checkIn = formatToTime(response['data']['check_in_time']);
      await updateStatus(checkIn: checkIn, location: location);
    } on DioException {
      rethrow;
    } catch (e) {
      rethrow;
    } finally {
      isLoading = false;
    }
  }

  Future<void> userCheckOut(String details) async {
    isLoading = true;
    try {
      final response = await AttendanceServices().checkOut(
        workSummary: details,
      );
      final checkOut = formatToTime(response['data']['check_out_time']);
      await updateStatus(checkOut: checkOut);
    } on DioException {
      rethrow;
    } catch (e) {
      rethrow;
    } finally {
      isLoading = false;
    }
  }

  Future<void> userAbsent(String details) async {
    isLoading = true;
    try {
      await AttendanceServices().absent(
        reason: details,
      );
      await updateStatus(isAbsent: true);
    } on DioException {
      rethrow;
    } catch (e) {
      rethrow;
    } finally {
      isLoading = false;
    }
  }

  Future<void> fetchSummary() async {
    try {
      final response = await AttendanceServices().getSummaryMonth(
        year: DateTime.now().year,
        month: DateTime.now().month,
      );

      _presentDays =
          response.data.summary.presentDays + response.data.summary.remoteDays;
      _absentDays = response.data.summary.absentDays;
      _totalHours = response.data.summary.totalHours;
      notifyListeners();
    } on DioException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> fetchSummaryDay(DateTime date) async {
    isLoading = true;
    final dateTime = DateTime.parse(date.toString());
    final year = dateTime.year;
    final month = dateTime.month;
    final day = dateTime.day;

    try {
      final response = await AttendanceServices()
          .getSummaryDay(year: year, month: month, day: day);

      final Map<String, dynamic> responseData;
      if (response.data.first.status != "absent") {
        responseData = {
          'status': response.data.first.status ?? '',
          'checkIn': response.data.first.checkInTime ?? '',
          'checkOut': response.data.first.checkOutTime ?? '',
          'workSummary': response.data.first.workSummary ?? '',
        };
      } else {
        _isAbsent = true;
        responseData = {
          'status': response.data.first.status ?? '',
          'workSummary': response.data.first.workSummary ?? '',
        };
      }

      return responseData;
    } on DioException {
      rethrow;
    } catch (e) {
      rethrow;
    } finally {
      isLoading = false;
    }
  }

  Future<void> updateStatus({
    String? checkIn,
    String? checkOut,
    bool? isAbsent,
    WorkLocation? location,
  }) async {
    if (checkIn != null) _checkIn = checkIn;
    if (checkOut != null) _checkOut = checkOut;
    if (isAbsent != null) _isAbsent = isAbsent;
    if (location != null) _location = location;

    notifyListeners();
  }

  Future<void> clearStatus() async {
    _checkIn = null;
    _checkOut = null;
    _isAbsent = false;

    notifyListeners();
  }

  Future<void> toggleLocation(WorkLocation location) async {
    _location = location;
    notifyListeners();
  }
}
