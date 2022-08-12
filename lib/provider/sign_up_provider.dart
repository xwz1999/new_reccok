import 'package:flutter/material.dart';

class SignUpProvider extends ChangeNotifier {
  String? _nickName;

  String? get nickName => _nickName;

  String? _tel;

  String? get tel => _tel;

  Map<String, dynamic> get toMap => {
        'nickName': _nickName,
        'tel': _tel,
      };

  setNickName(String name) {
    _nickName = name;
    notifyListeners();
  }

  setTel(String tel) {
    _tel = tel;
    notifyListeners();
  }

  clearAll() {
    _nickName = null;
    _tel = null;
    notifyListeners();
  }
}
