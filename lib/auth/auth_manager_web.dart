
import 'package:msal_js/msal_js.dart';
import 'package:mtime_mordre/services/api_service.dart';
import 'i_auth_manager.dart';

AuthManager getManager() => Auth0ManagerForWeb();

class Auth0ManagerForWeb extends AuthManager {
  static const String clientId = 'bbe45ebc-fb38-48d8-8abd-9c5a9d38a6fd';
  static const List<String> scopes = ['openid', 'profile', 'offline_access'];
  static AccountInfo? _account;
  static String? _accessToken;
  static String? sessionId;

  static final PublicClientApplication pca = init();

  static init() {
    return PublicClientApplication(
      Configuration()
        ..auth = (BrowserAuthOptions()
          ..clientId = clientId
          ..authority =
              'https://login.microsoftonline.com/294c7ede-2387-42ab-bbff-e5eb67ca3aee')
        ..system = (BrowserSystemOptions()
          ..loggerOptions = (LoggerOptions()
            ..loggerCallback =
                (LogLevel level, String message, bool containsPii) {
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
  Future<String> login() async {
    try {
      final AuthenticationResult? redirectResult =
          await pca.handleRedirectFuture();

      if (redirectResult != null) {
        // Just came back from a successful redirect flow
        print(
            'Redirect login successful. name: ${redirectResult.account!.name}');
        await ApiServiceMordre()
            .loginSession(redirectResult.accessToken)
            .then((sid) => {
                  sessionId = sid,
                });
        // Set the account as active for convienence
        pca.setActiveAccount(redirectResult.account);
      } else {
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
      await ApiServiceMordre().loginSession(response.accessToken).then((sid) => {
            sessionId = sid,
      });
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
  String? getSession()  {
    return sessionId;
  }

  @override
  void onChange() {
    notifyListeners();
  }

  @override
  String getActiveAccount() {
    return _account!.username;
  }

  bool isLoggedIn() {
    print("ISLOGGED IN");
    print(_account?.username);
    return _account?.username != null ? true : false;
  }
}
