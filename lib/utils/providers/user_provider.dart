import 'package:flutter/widgets.dart';

class UserProvider extends ChangeNotifier {
  String _name = "...";
  String _email = "...";
  bool _isLoading = false;

  String get name => _name;
  String get email => _email;
  bool get isLoading => _isLoading;

  void setUserDetails({required String name, required String email}) {
    _name = name;
    _email = email;
    notifyListeners();
  }

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
