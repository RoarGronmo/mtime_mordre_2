import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Services/ApiService_fake.dart';
import 'auth/iAuth_manager.dart';

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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    bool? isLoggedIn()  {
      return  AuthManager.instance?.isLoggedIn();
    }
    bool?  ila = isLoggedIn();

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
          if(ila == false)
            ListTile(
              leading: const Icon(Icons.launch),
              title:  Text('Login ' + ila.toString()),
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
          ListTile(
            leading: const Icon(Icons.launch),
            title: const Text('Logg ut'),
            onTap: () {
              logout();
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
    String sid = new ApiServiceFake().loginSession() as String;
  }

  void logout() async {
    await AuthManager.instance?.logout();
  }




}
