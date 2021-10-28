import 'package:flutter/material.dart';
import 'package:mtime_mordre/Services/api_service.dart';
import 'package:mtime_mordre/models/Office.dart';
import 'package:mtime_mordre/widgets/snackbar.dart';

class PickOffice extends StatefulWidget {
  @override
  _PickOfficeState createState() => _PickOfficeState();
}

class _PickOfficeState extends State<PickOffice> {
  late List<dynamic> offices = [];
  TextEditingController editingController = TextEditingController();

  @override
  void initState() {
    _setData();
    super.initState();
  }

  void _setData() {
    fetchR10s();
  }

  fetchR10s() {
    ApiServiceMordre()
        .listR10s()
        .then((value) => {
      Snackbar.buildSuccessSnackbar(context, "Success!"),
      setState(() {
        var list = value['payload'];
        var flattenedList = [];
        list.forEach((k, v) => flattenedList.add(v));
        offices = flattenedList
            .map((model) => MordreOffice.fromJson(model))
            .toList();
      })
    })
        .onError((error, stackTrace) => {
      Snackbar.buildErrorSnackbar(context,
          "Kunne ikke hente kontor. Details: " + error.toString())
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      const SizedBox(height: 30),
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
      ListView.builder(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          itemCount: offices.length,
          itemBuilder: (context, index) {
            return ListTile(
                title: Text(offices[index].nm + ' - ' +  offices[index].rNo));
          }),
    ]);
  }

  void filterSearchResults(String query) {
    List<MordreOffice> searchList = <MordreOffice>[];
    if (query.isNotEmpty) {
      offices.forEach((item) {
        if (item.nm.contains(query)) {
          searchList.add(item);
        } else if (item.rNo.toString().contains(query)) {
          searchList.add(item);
        }
      });
      setState(() {
        offices.clear();
        offices.addAll(searchList);
      });
      return;
    }
  }
}
