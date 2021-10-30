import 'package:flutter/material.dart';
import 'package:mtime_mordre/auth/i_auth_manager.dart';
import 'package:mtime_mordre/router/router.dart';


void main()  {
  WidgetsFlutterBinding.ensureInitialized();
  String? sid;
  sid = AuthManager.instance?.getSession();
  if(sid != null){
    runApp(const MWork());
  }else{
    AuthManager.instance?.login().then((val) => {
      runApp(const MWork()),
    }).onError((error, stackTrace) =>
      {
        print(error.toString())
      }
    );
  }
  
}
