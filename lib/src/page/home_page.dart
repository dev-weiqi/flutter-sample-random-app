import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../public.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _itemHeight = 60;
  ScrollController _controller = ScrollController();
  int _lastSelectedIndex = unknownIndex;

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MainBloc>(builder: (context, bloc, child) {
      List<String> list = bloc.list;
      return Scaffold(
          appBar: buildAppBar(actions: [_buildMenuButton(context)]),
          backgroundColor: colorLight,
          body: ListView.builder(
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) {
              Color bgColor = index % 2 == 0 ? Colors.white : colorLight;
              return Dismissible(
                  onDismissed: (direction) {
                    _lastSelectedIndex = unknownIndex;
                    bloc.removeByIndex(index);
                  },
                  key: UniqueKey(),

                  /// 只允許左滑
                  direction: DismissDirection.endToStart,

                  /// 左滑刪除樣式
                  background: Container(
                      color: Colors.red,
                      child: ListTile(
                          trailing: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ))),
                  child: Container(
                      color: bgColor, child: _buildListBody(list, index)));
            },
            controller: _controller,
          ),
          floatingActionButton: _buildFAB(list));
    });
  }

  Widget _buildMenuButton(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.edit),
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => AddPage())));
  }

  Widget _buildListBody(List<String> list, int index) {
    Text text = Text(
      list[index],
      style: TextStyle(color: colorDark, fontSize: 20),
    );

    Widget widget = index != _lastSelectedIndex
        ? text
        : Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Icon(
              Icons.check,
              color: Colors.redAccent,
            ),
            text
          ]);
    return ListTile(
      title: Container(
          height: _itemHeight, child: widget, alignment: Alignment.center),
      onTap: () {
        String name = list[index];
        String uriString = "https://www.google.com/search?q=$name";
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return WebViewWidget(title: name, url: Uri.encodeFull(uriString));
        }));
      },
    );
  }

  Widget _buildFAB(List<String> list) {
    double size = 80;
    return Container(
        width: size,
        height: size,
        child: FloatingActionButton(
          onPressed: () {
            _buildDialog(context, list);
          },
          child: Icon(
            Icons.sync,
            size: size / 2,
            color: Colors.white,
          ),
          backgroundColor: colorDark,
        ));
  }

  void _buildDialog(BuildContext context, List<String> list) {
    int randomIndex = Random().nextInt(list.length);
    TextStyle btnTextStyle = TextStyle(color: colorDark);
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return CupertinoAlertDialog(
              content: Text.rich(TextSpan(
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      decoration: TextDecoration.none),
                  children: <TextSpan>[
                    TextSpan(text: '就決定是'),
                    TextSpan(
                        text: ' ${list[randomIndex]} ',
                        style: TextStyle(
                            fontSize: 22,
                            color: Colors.indigo,
                            fontWeight: FontWeight.bold)),
                    TextSpan(text: '了！')
                  ])),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      _buildDialog(context, list);
                    },
                    child: Text('再選一次', style: btnTextStyle)),
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      _setLastSelected(randomIndex);
                      _controller.jumpTo(randomIndex * _itemHeight);
                    },
                    child: Text('確定', style: btnTextStyle))
              ]);
        });
  }

  void _setLastSelected(int index) {
    setState(() {
      _lastSelectedIndex = index;
    });
  }
}
