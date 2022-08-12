
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class UserProvider extends ChangeNotifier {
  bool _isLogin = false;

  bool get isLogin => _isLogin;

  bool get isNotLogin => !_isLogin;


}
