
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mtime_mordre/home.dart';
import 'package:mtime_mordre/snackbar.dart';
import 'Services/api_service.dart';
import 'models/Bil.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key, required this.title, }) : super(key: key);
  final String title;

  @override
  _Onboarding createState() => _Onboarding();
}

class _Onboarding extends State<Onboarding> {
  late List<dynamic> departments = [];
  @override
  void initState() {
    _setData();
    super.initState();
  }

  void _setData() {
    fetchR1s();
  }

  fetchR1s() {
    ApiServiceMordre()
        .listR1s()
        .then((value) => {
      Snackbar.buildSuccessSnackbar(context, "Success!"),
      setState(() {
        var list = value['payload'];
        var flattenedList = [];
        list.forEach((k, v) => flattenedList.add(v));
        departments = flattenedList
            .map((model) => MordreBil.fromJson(model))
            .toList();
      })
    })
        .onError((error, stackTrace) => {
      Snackbar.buildErrorSnackbar(context,
          "Kunne ikke hente biler. Details: " + error.toString())
    });
  }

  @override
  Widget build(BuildContext context) {
    return _onboarding(context);
  }

  Widget _onboarding(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Velkommen"),
      ),
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomePage(title: 'mWork')),
              );
            },
            child: const Text('Gå til mWork'),
          ),
          if (departments.isNotEmpty)
            Expanded(
              child: Card(
                color: Colors.deepPurple,
                child: ListView.builder(
                    itemCount: departments.length,
                    itemBuilder: (context, index) {
                      return ListTile(title: Text(departments[index].nm));
                    }),
              ),
            ),
        ]),
      ),
    );
  }
}


