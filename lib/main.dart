import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'auth/iAuth_manager.dart';


// **Setup your directory settings here**:
const String clientId = 'bbe45ebc-fb38-48d8-8abd-9c5a9d38a6fd';
const List<String> scopes = ['openid', 'profile', 'offline_access'];


void main()  {

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mordre/Mtime',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(title: 'Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {


  const MyHomePage({Key? key, required this.title, }) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? accessToken;


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text(
              'AzureAD OAuth',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.launch),
            title: const Text('Login'),
            onTap: () {
              login();
            },
          ),
          ListTile(
            leading: const Icon(Icons.launch),
            title: const Text('\Who is logged in?'),
            onTap: () {
              showLoginInfo().then((value) => showMessage(value));
            },
          ),

        ],
      ),
    );
  }

  void showError(dynamic ex) {
    showMessage(ex.toString());
  }

  void showMessage(String text) {
    var alert = AlertDialog(
      content: Text(text),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Ok'))
      ],
    );
    showDialog(context: context, builder: (BuildContext context) => alert);
  }

  Future<String> showLoginInfo() async {
    return await AuthManager.instance?.getActiveAccount();
  }



  void login() async {
   AuthManager.instance?.Login();
  }


}



