import 'dart:convert';
import 'iApiService.dart';
import 'package:http/http.dart' as http;

class ApiServiceMordre extends ApiService {

  @override
  Future<String> loginSession(oauth_token) async {
    String api_uri = "https://api.norva24.no/app/dev/8/Service/execute.aspx";
    String method = "logInSession";
    String moduleName = "Authentication";
    try {
      final response = await http.post(
        Uri.parse(api_uri),
        body: json.encode({
          'method': method,
          'moduleName': moduleName,
          'payload': {'oauth2AccessToken' : oauth_token}
        }),
      );
      return jsonDecode(response.body)['payload']['session']['id'];
    } catch (err) {
      print(err.toString());
      return "";
    }
  }

  @override
  Future<dynamic> listR1s(String sid) async {
    String api_uri = "https://api.norva24.no/app/dev/8/Service/execute.aspx";
    String method = "listR1s";
    String moduleName = "MOrdre";
    try {
      final response = await http.post(
        Uri.parse(api_uri),
        body: json.encode({
          'method': method,
          'moduleName': moduleName,
          'sessionId': sid,
          'payload': null
        }),
      );
      return jsonDecode(response.body);
    } catch (err) {
      print(err.toString());
    }
  }
}