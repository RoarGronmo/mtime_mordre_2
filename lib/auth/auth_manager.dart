import 'package:aad_oauth/aad_oauth.dart';
import 'package:aad_oauth/model/config.dart';
import 'package:mtime_mordre/Services/api_service.dart';
import '../snackbar.dart';
import 'iAuth_manager.dart';

AuthManager getManager() => Auth0Manager();

class Auth0Manager extends AuthManager {
  static String? _accessToken;
  static String? sessionId;

  static final Config config = Config(
      tenant: '294c7ede-2387-42ab-bbff-e5eb67ca3aee',
      clientId: 'bbe45ebc-fb38-48d8-8abd-9c5a9d38a6fd',
      scope: 'openid profile offline_access',
      redirectUri: 'https://login.live.com/oauth20_desktop.srf');
  final AadOAuth oauth = AadOAuth(config);

  @override
  Future<String> login() async {
    try {
      print("Starting login from Native client");
      await oauth.login().then((value) async => {
      _accessToken = await oauth.getAccessToken(),
        await ApiServiceMordre()
            .loginSession(_accessToken!)
            .then((sid) => {
          print(sid),
          sessionId = sid,
        })
      });
      print('Popup login successful. token: ${_accessToken}');
      return _accessToken.toString();
    } catch (e) {
      print('Erroro');
      throw Error();
    }
  }

  @override
  String? getSession() {
    return sessionId;
  }

  bool isLoggedIn() {
    return _accessToken != null ? true : false;
  }

  @override
  Future<void> logout() async {
    await oauth.logout();
    print(_accessToken);
  }

  @override
  String getActiveAccount() {
    return "Mitt navn må hentast frå accessToken. Metode altså ikkje fullstendig implementert her.";
  }
}
