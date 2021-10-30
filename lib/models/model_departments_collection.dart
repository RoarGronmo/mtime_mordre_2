import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:mtime_mordre/models/model_car.dart';

class DepartmentsModel extends ChangeNotifier {
  final List<MWorkCar> _items = [];

  UnmodifiableListView<MWorkCar> get items => UnmodifiableListView(_items);

  void add(MWorkCar item) {
    _items.add(item);
    notifyListeners();
  }

  void removeAll() {
    _items.clear();
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}