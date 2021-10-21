import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mtime_mordre/Services/ApiService.dart';
import 'package:mtime_mordre/snackbar.dart';
import 'Services/ApiService_fake.dart';
import 'auth/iAuth_manager.dart';
import 'models/Bil.dart';

class Mordre_Mtime extends StatelessWidget {
  const Mordre_Mtime({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mordre/Mtime',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(title: 'Home'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title, }) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? accessToken;
  String? sessionId;
  dynamic departments;

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
              'Mordre/Mtime',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
            ListTile(
              leading: const Icon(Icons.launch),
              title:  Text('Login '),
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
          if(sessionId != null)
            ListTile(
              leading: const Icon(Icons.launch),
              title: const Text('Check session'),
              onTap: () {
                showMessage(sessionId!);
              },
            ),
          ListTile(
            leading: const Icon(Icons.launch),
            title: const Text('Logg ut'),
            onTap: () {
              logout();
            },
          ),
          if(sessionId != null)
            ListTile(
              leading: const Icon(Icons.launch),
              title: const Text('Hent biler fra API'),
              onTap: () {
                fetchR1s();
              },
            ),
          if(departments != null)
            Expanded(
                child : SizedBox(
                    height: 400.0,
                    child: ListView.builder(
                        itemCount: departments.length,
                        itemBuilder: (context, index) {
                          return ListTile(title: Text(departments[index].nm));
                        }
                    )
                )),
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
    AuthManager.instance?.Login().then((token) => {
      new ApiServiceMordre().loginSession(token).then((sid) => {
        print("SID below: "),
        print(sid),
        setState(() {
          sessionId = sid;
        })
      })
    });
  }

  fetchR1s(){
    new ApiServiceMordre().listR1s(sessionId!).then((value) => {
      Snackbar.buildSuccessSnackbar(context, "Success!"),
        setState(() {
          var list = value['payload'];
          var flattenedList = [];
          list.forEach((k, v) => flattenedList.add(v));
          departments =
          flattenedList.map((model) => MordreBil.fromJson(model)).toList();
        })

    }).onError((error, stackTrace) => {
      Snackbar.buildErrorSnackbar(context, "Kunne ikke hente biler. Details: " + error.toString() )
    });
  }

  void logout() async {
    await AuthManager.instance?.logout();
  }
}
