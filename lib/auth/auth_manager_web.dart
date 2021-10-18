import 'package:msal_js/msal_js.dart';

import 'auth_manager.dart';
import 'dart:js' as js;

import 'iAuth_manager.dart';
//other imports
AuthManager getManager() => Auth0ManagerForWeb();

class Auth0ManagerForWeb extends AuthManager {

  // **Setup your directory settings here**:
  static const String clientId = 'bbe45ebc-fb38-48d8-8abd-9c5a9d38a6fd';
  static const List<String> scopes = ['openid', 'profile', 'offline_access'];
  AccountInfo? _account;


  @override
  Future<AccountInfo?> Login() async {
    final publicClientApp = PublicClientApplication(
      Configuration()
        ..auth = (BrowserAuthOptions()
        // Give MSAL our client ID
          ..clientId = clientId
          ..authority = 'https://login.microsoftonline.com/294c7ede-2387-42ab-bbff-e5eb67ca3aee')

        ..system = (BrowserSystemOptions()
          ..loggerOptions = (LoggerOptions()
            ..loggerCallback = (LogLevel level, String message, bool containsPii){
              if (containsPii) {
                return;
              }

              // MSAL log message
              print('MSAL: [$level] $message');
            }
          // Log just about everything for the purpose of this demo
            ..logLevel = LogLevel.verbose)),
    );
    /// Starts a popup login.
    print("Starting login from Web-client");

    try {
      // Handle redirect flow
      final AuthenticationResult? redirectResult =
      await publicClientApp.handleRedirectFuture();

      if (redirectResult != null) {
        // Just came back from a successful redirect flow
        print('Redirect login successful. name: ${redirectResult.account!.name}');

        // Set the account as active for convienence
        publicClientApp.setActiveAccount(redirectResult.account);
      } else {
        // Normal page load (not from an auth redirect)

        // Check if an account is logged in
        final List<AccountInfo> accounts = publicClientApp.getAllAccounts();

        if (accounts.isNotEmpty) {
          // An account is logged in, set the first one as active for convienence
          publicClientApp.setActiveAccount(accounts.first);
        }
      }
    } on AuthException catch (ex) {
      // Redirect auth failed
      print("SCREWS");
      print('MSAL: ${ex.message}');
    }
    try {
      final response = await publicClientApp
          .loginPopup(PopupRequest()..scopes = scopes);


      _account = response.account;

      print('Popup login successful. name: ${_account!.name}');
    } on AuthException catch (ex) {
      print('MSAL: ${ex.errorCode}:${ex.errorMessage}');
    }
    return _account;
  }


  void _loggerCallback(LogLevel level, String message, bool containsPii) {
    if (containsPii) {
      return;
    }

    // MSAL log message
    print('MSAL: [$level] $message');
  }

  @override
  Future<void> logout() async {
    //stuff that uses dart:js
  }

  @override
  Future<String> getActiveAccount() async {
    return "";
  }

}