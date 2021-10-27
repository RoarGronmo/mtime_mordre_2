import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:mtime_mordre/models/Bil.dart';

class DepartmentsModel extends ChangeNotifier {
  final List<MordreBil> _items = [];

  UnmodifiableListView<MordreBil> get items => UnmodifiableListView(_items);



  void add(MordreBil item) {
    _items.add(item);
    notifyListeners();
  }

  void removeAll() {
    _items.clear();
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}