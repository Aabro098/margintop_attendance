import 'package:flutter/foundation.dart';

class AttendanceProvider with ChangeNotifier {
  String? _checkIn;
  String? _checkOut;

  String? get checkIn => _checkIn;
  String? get checkOut => _checkOut;

  void setCheckIn(String? value) {
    _checkIn = value;
    notifyListeners();
  }

  void setCheckOut(String? value) {
    _checkOut = value;
    notifyListeners();
  }
}
