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

  Future<void> updateStatus({
    String? checkIn,
    String? checkOut,
    bool? isAbsent,
  }) async {
    if (checkIn != null) _checkIn = checkIn;
    if (checkOut != null) _checkOut = checkOut;
    if (isAbsent != null) _isAbsent = isAbsent;

    notifyListeners();
  }

  Future<void> clearStatus() async {
    _checkIn = null;
    _checkOut = null;
    _isAbsent = false;
    _isFirst = true;

    notifyListeners();
  }

  set first(bool value) {
    _isFirst = value;
    notifyListeners();
  }
}
