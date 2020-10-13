import 'package:flutter/widgets.dart';

import '../public.dart';

class MainBloc with ChangeNotifier {
  List<String> _list = SpUtil.getList();

  MainBloc() {
    setData(SpUtil.getList());
  }

  List<String> get list => _list;

  void addMultiData(String name) {
    List<String> nameList = name.split(',');

    if (nameList.isEmpty) {
      _list.add(name);
    } else {
      nameList.forEach((name) {
        _list.add(name);
      });
    }
    setData(_list);
  }

  void removeByIndex(int index) {
    if (index == unknownIndex) return;

    _list.removeAt(index);
    setData(_list);
  }

  void setData(List<String> list) {
    SpUtil.setList(list);
    _list = list;
    notifyListeners();
  }
}
