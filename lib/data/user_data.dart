import 'package:flutter/material.dart';

class UserData extends ChangeNotifier {
  String _name = 'User';

  String get userName => _name;

  Future<void> loadName() async {
    notifyListeners();
  }

  void setName(String newName) {
    _name = newName;
    notifyListeners();
  }
}
