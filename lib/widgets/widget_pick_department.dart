import 'package:flutter/material.dart';
import 'package:mtime_mordre/services/api_service.dart';
import 'package:mtime_mordre/models/model_car.dart';
import 'package:mtime_mordre/widgets/widget_snackbar.dart';

class PickDepartment extends StatefulWidget {
  @override
  _PickDepartmentState createState() => _PickDepartmentState();
}

class _PickDepartmentState extends State<PickDepartment> {
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
                    .map((model) => MWorkCar.fromJson(model))
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
    return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
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
    SizedBox(
    height: 350,
    child:
      ListView.builder(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          itemCount: departments.length,
          itemBuilder: (context, index) {
            return Card(
              child:ListTile(
                title: Text(departments[index].nm +
                    " - " +
                    departments[index].rNo.toString()))
            );
          }),
      )
    ]);
  }

  void filterSearchResults(String query) {
    List<MWorkCar> searchList = <MWorkCar>[];
    if (query.isNotEmpty) {
      departments.forEach((item) {
        if (item.nm.contains(query)) {
          searchList.add(item);
        } else if (item.rNo.toString().contains(query)) {
          searchList.add(item);
        }
      });
      setState(() {
        departments.clear();
        departments.addAll(searchList);
      });
      return;
    }
  }
}
