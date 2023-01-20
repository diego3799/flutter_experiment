import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  late String _jwt;

  String get jwt => _jwt;

  void setUserJwt(String jwt) {
    _jwt = jwt;
    notifyListeners();
  }
}
