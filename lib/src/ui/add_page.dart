import 'package:flutter/material.dart';

import 'package:randomapp/main.dart';
import 'package:randomapp/src/bloc_provider.dart';
import 'package:randomapp/src/const.dart';
import 'package:randomapp/src/main_bloc.dart';

class AddPage extends StatefulWidget {
  AddPage({Key key}) : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  TextEditingController _controller = TextEditingController();
  MainBloc _mainBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _mainBloc = BlocProvider.of(context);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(title: '新增名稱'),
        backgroundColor: colorLight,
        body: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Expanded(flex: 8, child: _buildInput()),
              Expanded(flex: 2, child: _buildConfirm(context))
            ])));
  }

  Widget _buildConfirm(BuildContext context) {
    double size = 55;
    return Container(
        width: size,
        height: size,

        /// 添加圓形背景
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: colorDark,
        ),
        child: IconButton(
            color: Colors.white,
            icon: Icon(Icons.done_outline),
            onPressed: () {
              String input = _controller.text;

              if (input.isEmpty) {
                showToast(context, '請輸入名稱！');
              } else if (input == 'reset') {
                _reset(context);
              } else {
                _save(context, input);
              }
            }));
  }

  Widget _buildInput() {
    return Container(
      child: Card(

          /// 圓角
          shape: StadiumBorder(),
          elevation: 3,
          child: TextField(
              controller: _controller,
              cursorColor: colorDark,
              style: TextStyle(fontSize: 24),
              decoration: InputDecoration(

                  /// 去除底線
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(10),
                  prefixIcon: Icon(Icons.edit)))),
    );
  }

  void _save(BuildContext context, String name) {
    List<String> list = _mainBloc.list;
    if (list.contains(name)) {
      showToast(context, '已有相同的名稱！');
      return;
    }

    list.add(_controller.text);
    _mainBloc.setList(list);
    Navigator.pop(context, true);
  }

  void _reset(BuildContext context) {
    _mainBloc.setList(defList);
    Navigator.pop(context, true);
  }
}
