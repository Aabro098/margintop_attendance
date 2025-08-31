import 'package:flutter/widgets.dart';
import 'package:margintop_solutions/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  String _name = "...";
  String _email = "...";
  bool _isLoading = false;

  String get name => _name;
  String get email => _email;
  bool get isLoading => _isLoading;

  /// ✅ New method: set details from User model
  void setUserFromModel(User user) {
    _name = user.name;
    _email = user.email;
    notifyListeners();
  }

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void clearUserData() {
    _name = "...";
    _email = "...";
    notifyListeners();
  }
}
