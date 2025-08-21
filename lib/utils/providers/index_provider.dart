import 'package:flutter/foundation.dart';

class IndexProvider with ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void setIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void removeRoute() {
    _selectedIndex = 1;
    notifyListeners();
  }
}
