import 'package:flutter/material.dart';
import 'package:mtime_mordre/auth/iAuth_manager.dart';
import 'home.dart';

void main()  {
  WidgetsFlutterBinding.ensureInitialized();
  String? sid;
  sid = AuthManager.instance?.getSession();
  if(sid != null){
    runApp(const Mordre_Mtime());
  }else{
    AuthManager.instance?.Login().then((val) => {
      runApp(const Mordre_Mtime()),
    });
  }
  
}
