import 'package:flutter/foundation.dart';

class AttendanceProvider with ChangeNotifier {
  String? _checkIn;
  String? _checkOut;
  bool _isAbsent = false;

  String? get checkIn => _checkIn;
  String? get checkOut => _checkOut;
  bool get isAbsent => _isAbsent;

  void setCheckIn(String? value) {
    _checkIn = value;
    notifyListeners();
  }

  void setCheckOut(String? value) {
    _checkOut = value;
    notifyListeners();
  }

  set absent(bool value) {
    _isAbsent = value;
    notifyListeners();
  }
}
