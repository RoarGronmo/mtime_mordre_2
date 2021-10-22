import 'package:flutter/cupertino.dart';
import 'package:msal_js/msal_js.dart';
import 'iAuth_manager.dart';

AuthManager getManager() => Auth0ManagerForWeb();

class Auth0ManagerForWeb extends AuthManager {
  static const String clientId = 'bbe45ebc-fb38-48d8-8abd-9c5a9d38a6fd';
  static const List<String> scopes = ['openid', 'profile', 'offline_access'];
  static AccountInfo? _account;
  static String? _accessToken;
  static String? sessionId;

  static final PublicClientApplication pca = init();

  static init(){
    return  PublicClientApplication(
      Configuration()
        ..auth = (BrowserAuthOptions()
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
  }

  @override
  Future<String> Login(BuildContext context) async {

    /// Starts a popup login.
    print("Starting login from Web-client");
    try {
      // Handle redirect flow
      final AuthenticationResult? redirectResult =
      await pca.handleRedirectFuture();

      if (redirectResult != null) {
        // Just came back from a successful redirect flow
        print('Redirect login successful. name: ${redirectResult.account!.name}');

        // Set the account as active for convienence
        pca.setActiveAccount(redirectResult.account);
      } else {
        // Normal page load (not from an auth redirect)
        // Check if an account is logged in
        final List<AccountInfo> accounts = pca.getAllAccounts();

        if (accounts.isNotEmpty) {
          // An account is logged in, set the first one as active for convienence
          pca.setActiveAccount(accounts.first);
        }
      }
    } on AuthException catch (ex) {
      // Redirect auth failed
      print('MSAL: ${ex.message}');
    }
    try {
      final response = await pca.loginPopup(PopupRequest()..scopes = scopes);
      _account = response.account;

      print('Popup login successful. name: ${_account!.name}');
      return response.accessToken;
    } on AuthException catch (ex) {
      print('MSAL: ${ex.errorCode}:${ex.errorMessage}');
      return "Empty";
    }

  }


  @override
  Future<void> logout() async {
    pca.logoutRedirect();
  }

  @override
  Future<String?> getSession() async{
    return sessionId;
  }

  @override
  void onChange(){
    notifyListeners();
  }

  @override
  Future<String> getActiveAccount() async {
    return _account!.username;
  }


  bool isLoggedIn()  {
    print("ISLOGGED IN");
    print(_account?.username);
    return _account?.username != null ? true : false;
  }

}