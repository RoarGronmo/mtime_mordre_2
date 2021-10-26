abstract class ApiService {
  Future<String> loginSession(String oauthToken);
  Future<dynamic> listR1s();
}