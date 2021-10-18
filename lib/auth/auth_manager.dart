
import 'package:aad_oauth/aad_oauth.dart';
import 'package:aad_oauth/model/config.dart';
import 'iAuth_manager.dart';
//other imports

AuthManager getManager() => Auth0Manager();
class Auth0Manager extends AuthManager {
  String? accessToken;


  static final Config config = Config(
      tenant: '294c7ede-2387-42ab-bbff-e5eb67ca3aee',
      clientId: 'bbe45ebc-fb38-48d8-8abd-9c5a9d38a6fd',
      scope: 'openid profile offline_access',
      redirectUri: 'https://login.live.com/oauth20_desktop.srf');
  final AadOAuth oauth = AadOAuth(config);

  @override
  Future<void> Login() async {

    try {
      print("Starting login from Native client");
      //WebView.platform = WebView();
      await oauth.login();

      accessToken = await oauth.getAccessToken();
      print('Popup login successful. name: ${accessToken}');
    } catch (e) {
      print('Erroro');
      throw Error();
    }
  }


  @override
  Future<void> logout() async {
    //stuff that uses classic dart.io
  }

  @override
  Future<String> getActiveAccount() async {
    throw UnsupportedError('Cannot create an auth manager');
  }
}