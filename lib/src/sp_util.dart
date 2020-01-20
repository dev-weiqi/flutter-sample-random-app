import 'package:shared_preferences/shared_preferences.dart';

import 'const.dart';

class SpUtil {
  SpUtil._();

  static const _prefKeyList = '_prefKeyList';

  static SpUtil _singleton;
  static SharedPreferences _prefs;

  static Future<SpUtil> getInstance() async {
    if (_singleton == null) {
      _singleton = SpUtil._();
      await _singleton._init();
    }
    return _singleton;
  }

  Future _init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static setList(List<String> list) async {
    _prefs.setStringList(_prefKeyList, list);
  }

  static List<String> getList() {
    return _prefs.getStringList(_prefKeyList) ?? defList;
  }
}
