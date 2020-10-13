import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:randomapp/src/utils/toast_util.dart';

import '../public.dart';

class AddPage extends StatefulWidget {
  AddPage({Key key}) : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  TextEditingController _controller = TextEditingController();

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
            padding: EdgeInsets.symmetric(vertical: 24, horizontal: 8),
            child: Column(
              children: <Widget>[
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Expanded(flex: 8, child: _buildInput()),
                  Expanded(flex: 2, child: _buildConfirm(context))
                ]),
                Text(
                  '＊ 可使用逗號 "," 來新增多筆資料',
                  style: TextStyle(color: Colors.black),
                )
              ],
            )));
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
                ToastUtil.showToast(context, '請輸入名稱！');
                return;
              }

              MainBloc mainBloc = Provider.of(context);
              if (input == 'reset') {
                mainBloc.setData(defList);
              } else {
                mainBloc.addMultiData(input);
              }

              Navigator.pop(context, true);
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
}
