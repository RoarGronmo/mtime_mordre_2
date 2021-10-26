import 'dart:convert';
import 'package:mtime_mordre/auth/iAuth_manager.dart';
import 'api_service_interface.dart';
import 'package:http/http.dart' as http;
import '../config.dart' as Config;

class ApiServiceMordre extends ApiService {

  @override
  Future<String> loginSession(oauthToken) async {
    String apiUri = Config.endpoint_mordre;
    String method = "logInSession";
    String moduleName = "Authentication";
      final response = await http.post(
        Uri.parse(apiUri),
        body: json.encode({
          'method': method,
          'moduleName': moduleName,
          'payload': {'oauth2AccessToken' : oauthToken}
        }),
      );
      if(jsonDecode(response.body)['statusId'] != 1){
        throw Exception(jsonDecode(response.body)['statusText']);
      }
      return jsonDecode(response.body)['payload']['session']['id'];
    }

  @override
  Future<dynamic> listR1s() async {
    String apiUri = Config.endpoint_mordre;
    String method = "listR1s";
    String moduleName = "MOrdre";
    final response = await http.post(
      Uri.parse(apiUri),
      body: json.encode({
        'method': method,
        'moduleName': moduleName,
        'sessionId': AuthManager.instance?.getSession().toString(),
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