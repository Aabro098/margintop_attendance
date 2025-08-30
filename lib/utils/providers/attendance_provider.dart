import 'package:flutter/foundation.dart';

class AttendanceProvider with ChangeNotifier {
  String? _checkIn;
  String? _checkOut;
  bool _isAbsent = false;
  bool _isFirst = true;

  String? get checkIn => _checkIn;
  String? get checkOut => _checkOut;
  bool get isAbsent => _isAbsent;
  bool get isFirst => _isFirst;

  void updateStatus({
    String? checkIn,
    String? checkOut,
    bool? isAbsent,
  }) {
    if (checkIn != null) _checkIn = checkIn;
    if (checkOut != null) _checkOut = checkOut;
    if (isAbsent != null) _isAbsent = isAbsent;

    notifyListeners();
  }

  set first(bool value) {
    _isFirst = value;
    notifyListeners();
  }
}
