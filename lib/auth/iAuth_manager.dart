
import 'auth_manager_stub.dart'
  if (dart.library.io) 'auth_manager.dart'
  if (dart.library.js) 'auth_manager_web.dart';

abstract class AuthManager {
  static AuthManager? _instance;

  static AuthManager? get instance {
    _instance ??= getManager();
    return _instance;
  }

  Future<void> Login();
  Future<String> getActiveAccount();
  Future<void> logout();
}