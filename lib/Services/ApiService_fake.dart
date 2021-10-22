import 'iApiService.dart';

class ApiServiceFake extends ApiService {
  @override
  Future<String> loginSession(String oauth_token) async {
    return "80c9113a-8c4f-440a-a2ae-409166b652f2";
  }

  @override
  Future<dynamic> listR1s() async {

    return {
      "statusId": 1,
      "debug": null,
      "payload": {
        "1000": {
          "rNo": 1000,
          "nm": "Felles - Alle",
          "r5": 0,
          "r10": " "
        },
        "1001": {
          "rNo": 1001,
          "nm": "Innleige Bil/Utstyr",
          "r5": 0,
          "r10": " "
        },
        "7000": {
          "rNo": 7000,
          "nm": "COSP-3-2008-XC90595",
          "r5": 60606,
          "r10": "606"
        },
        "7044": {
          "rNo": 7044,
          "nm": "COSP-3-2005-TP93645",
          "r5": 60606,
          "r10": "606"
        },
        "7090": {
          "rNo": 7090,
          "nm": "GENI-4-2012-CW96801",
          "r5": 60626,
          "r10": "606"
        },
      }
    };
  }
}