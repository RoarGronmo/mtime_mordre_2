
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mtime_mordre/Screens/home.dart';
import 'package:mtime_mordre/snackbar.dart';
import '../Services/api_service.dart';
import '../models/Bil.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key, required this.title, }) : super(key: key);
  final String title;

  @override
  _Onboarding createState() => _Onboarding();
}

class _Onboarding extends State<Onboarding> {
  late List<dynamic> departments = [];
  TextEditingController editingController = TextEditingController();
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
          TextField(
            controller: editingController,
            onChanged: (value) {
              filterSearchResults(value);
            },
            decoration: InputDecoration(
                labelText: "Search",
                hintText: "Search",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)))),
          ),
          if (departments.isNotEmpty)
            Expanded(
              child: Card(
                color: Colors.deepPurple,
                child: ListView.builder(
                    shrinkWrap: true,
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

  void filterSearchResults(String query) {
    List<MordreBil> searchList = <MordreBil>[];
    if(query.isNotEmpty) {
      departments.forEach((item) {
        if(item.nm.contains(query)) {
          print(item);
          searchList.add(item);
        }
      });
      setState(() {
        print(searchList);
        departments.clear();
        departments.addAll(searchList);
      });
      return;

    }
  }
}


