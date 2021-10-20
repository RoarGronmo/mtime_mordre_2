abstract class ApiService {
  Future<String> loginSession(String oauth_token);
  Future<dynamic> listR1s(String sid);
}