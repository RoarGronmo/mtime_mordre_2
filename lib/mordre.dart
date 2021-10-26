import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mtime_mordre/snackbar.dart';
import 'Services/api_service.dart';
import 'models/Bil.dart';

class Mordre extends StatefulWidget {
  static const title = 'MordreTime';
  static const androidIcon = Icon(Icons.music_note);

  const Mordre({Key? key, this.androidDrawer}) : super(key: key);

  final Widget? androidDrawer;

  @override
  _MordreState createState() => _MordreState();
}

class _MordreState extends State<Mordre> {
  late List<dynamic> departments = [];

  @override
  void initState() {
    _setData();
    super.initState();
  }

  void _setData() {}

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
              Snackbar.buildErrorSnackbar(context, "Kunne ikke hente biler. Details: " + error.toString())
        });
  }

  Future<void> _refreshData() {
    return Future.delayed(
      // This is just an arbitrary delay that simulates some network activity.
      const Duration(seconds: 2),
      () => setState(() => _setData()),
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Mordre.title),
      ),
      drawer: widget.androidDrawer,
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          ElevatedButton(
            onPressed: () {
              fetchR1s();
            },
            child: const Text('Hent biler'),
          ),
          const SizedBox(height: 30),
          if(departments.isNotEmpty)
            Expanded(
              child: Card(
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

  @override
  Widget build(context) {
    return _buildAndroid(context);
  }
}
