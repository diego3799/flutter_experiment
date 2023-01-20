import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserProvider with ChangeNotifier {
  String? _jwt;

  static const _storage = FlutterSecureStorage();
  String? get jwt => _jwt;

  void setUserJwt(String jwt) {
    _jwt = jwt;
    _storage.write(key: "jwt", value: jwt);
    notifyListeners();
  }

  Future<void> loadVars() async {
    String? jwt = await _storage.read(key: "jwt");

    if (jwt != null) {
      _jwt = jwt;
    }
  }
}
