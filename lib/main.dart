import 'package:flutter/material.dart';
import 'package:mtime_mordre/auth/iAuth_manager.dart';
import 'package:mtime_mordre/_router.dart';


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
