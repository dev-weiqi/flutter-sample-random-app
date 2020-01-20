import 'package:randomapp/src/sp_util.dart';
import 'package:rxdart/rxdart.dart';

class MainBloc {
  var _listSubject = BehaviorSubject<List<String>>();

  MainBloc() {
    setList(SpUtil.getList());
  }

  Stream<List<String>> get getListStream => _listSubject.stream;

  List<String> get list => _listSubject.value;

  void setList(List<String> list) {
    _listSubject.sink.add(list);
    SpUtil.setList(list);
  }

  void dispose() {
    _listSubject.close();
  }
}
