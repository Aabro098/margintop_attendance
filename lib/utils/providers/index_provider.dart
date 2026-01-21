import 'package:flutter/foundation.dart';

class IndexProvider with ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  Future<void> setIndex(int index) async {
    _selectedIndex = index;
    notifyListeners();
  }

  void removeRoute() {
    _selectedIndex = 1;
    notifyListeners();
  }
}
