import 'package:flutter/cupertino.dart';

import 'auth_manager_stub.dart'
  if (dart.library.io) 'auth_manager.dart'
  if (dart.library.js) 'auth_manager_web.dart';

abstract class AuthManager extends ChangeNotifier  {
  static AuthManager? _instance;

  static AuthManager? get instance {
    _instance ??= getManager();
    return _instance;
  }

  Future<String> Login();
  String getActiveAccount();
  Future<void> logout();
  bool isLoggedIn();
  String? getSession();
}