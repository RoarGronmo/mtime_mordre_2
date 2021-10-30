
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mtime_mordre/Screens/screen_onboarding.dart';
import 'package:mtime_mordre/widgets/widget_snackbar.dart';
import '../auth/i_auth_manager.dart';
import 'screen_drawer.dart';

class Mordre_Mtime extends StatelessWidget {
  const Mordre_Mtime({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'mWork',
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
      return const Mordre(
        androidDrawer: MainDrawer(),
      );
  }
}

class MainDrawer extends StatefulWidget{
  const MainDrawer({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AndroidDrawer();

}

class _AndroidDrawer extends State<MainDrawer> {
  final String? account = AuthManager.instance?.getActiveAccount().toString();
  @override
  Widget build(BuildContext context) {
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
              Text("Du er logget inn som " + account!)
              ),

            ),
          ListTile(
            title: Text(
              'mWork',
              style: Theme.of(context).textTheme.headline5,
            ),
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


