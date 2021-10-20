abstract class ApiService {
  Future<String> loginSession();
  Future<dynamic> listR1s(String sid);
}