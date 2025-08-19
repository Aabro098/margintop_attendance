import 'package:flutter/foundation.dart';

class DrawerProvider extends ChangeNotifier {
  String _selectedItem = 'Attendance';

  String get selectedItem => _selectedItem;

  void setSelectedItem(String item) {
    _selectedItem = item;
    notifyListeners();
  }
}
