
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mtime_mordre/snackbar.dart';
import 'auth/iAuth_manager.dart';
import 'mordre.dart';

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

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Mordre(
      androidDrawer: _AndroidDrawer(),
    );
  }
}

class _AndroidDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    void login() async {
      AuthManager.instance?.Login(context).then((value) => {
        Snackbar.buildSuccessSnackbar(
            context, "Success: " )
      });
    }

    void logout() async {
      await AuthManager.instance?.logout();
    }
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.green),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child:
                  new FutureBuilder<String?>(
                    future: AuthManager.instance?.getSession(), // a Future<String> or null
                    builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
                            return new Text('Result: ${snapshot.data}');
                      }
                  )
              ),

            ),
          ListTile(
            title: Text(
              'Mordre/Mtime',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.login),
            title:  Text('Login '),
            onTap: () {
              login();
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logg ut'),
            onTap: () {
              logout();
            },
          ),
          // Long drawer contents are often segmented.
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Divider(),
          ),
          ListTile(
            leading:  Icon(Icons.android),
            title: const Text("Settings"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );

  }

}

Widget _buildIosHomePage(BuildContext context) {
  return CupertinoTabScaffold(
    tabBar: CupertinoTabBar(
      items: const [
        BottomNavigationBarItem(
          label: "test",
          icon: Icon(Icons.access_time),
        ),
        BottomNavigationBarItem(
          label: "titt",
          icon: Icon(Icons.account_balance),
        ),
        BottomNavigationBarItem(
          label: "titt",
          icon: Icon(Icons.account_balance),
        ),
      ],
    ),
    tabBuilder: (context, index) {
      switch (index) {
        case 0:
          return CupertinoTabView(
            defaultTitle: "Test",
          );
        case 1:
          return CupertinoTabView(
            defaultTitle: "TESTsasd",
          );
        case 2:
          return CupertinoTabView(
            defaultTitle: "PROFILE",
          );
        default:
          assert(false, 'Unexpected tab');
          return const SizedBox.shrink();
      }
    },
  );
}

