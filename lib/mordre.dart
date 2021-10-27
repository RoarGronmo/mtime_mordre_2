import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Mordre extends StatefulWidget {
  static const title = 'MordreTime';
  static const androidIcon = Icon(Icons.music_note);

  const Mordre({Key? key, this.androidDrawer}) : super(key: key);

  final Widget? androidDrawer;

  @override
  _MordreState createState() => _MordreState();
}

class _MordreState extends State<Mordre> {

  @override
  void initState() {
    _setData();
    super.initState();
  }

  void _setData() {

  }


  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Mordre.title),
      ),
      drawer: widget.androidDrawer,
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          const SizedBox(height: 30),
        ]),
      ),
    );
  }

  @override
  Widget build(context) {
      return _buildAndroid(context);
  }
}
