import 'dart:convert';
import 'package:mtime_mordre/auth/auth_manager.dart';

import 'iApiService.dart';
import 'package:http/http.dart' as http;
import '../config.dart' as Config;
class ApiServiceMordre extends ApiService {

  @override
  Future<String> loginSession(oauth_token) async {
    String api_uri = Config.endpoint_mordre;
    String method = "logInSession";
    String moduleName = "Authentication";
      final response = await http.post(
        Uri.parse(api_uri),
        body: json.encode({
          'method': method,
          'moduleName': moduleName,
          'payload': {'oauth2AccessToken' : oauth_token}
        }),
      );
      if(jsonDecode(response.body)['statusId'] != 1){
        throw Exception(jsonDecode(response.body)['statusText']);
      }
      return jsonDecode(response.body)['payload']['session']['id'];
    }

  @override
  Future<dynamic> listR1s() async {
    String api_uri = Config.endpoint_mordre;
    String method = "listR1s";
    String moduleName = "MOrdre";
    final response = await http.post(
      Uri.parse(api_uri),
      body: json.encode({
        'method': method,
        'moduleName': moduleName,
        'sessionId': Auth0Manager.sessionId,
        'payload': null
      }),
    );
    var res =jsonDecode(response.body);
    if(res['statusId'] != 1){
      throw Exception(res['statusText']);
    }
    return res;
  }
}