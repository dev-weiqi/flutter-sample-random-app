import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:randomapp/src/bloc_provider.dart';
import 'package:randomapp/src/sp_util.dart';
import 'package:randomapp/src/const.dart';
import 'package:randomapp/src/ui/list_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SpUtil.getInstance();
  return runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        child: MaterialApp(
            home: ListPage(),
            theme: ThemeData(primaryColor: colorDark, accentColor: colorDark)));
  }
}

Widget buildAppBar({String title = appName, List<Widget> actions = const []}) {
  return AppBar(
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      backgroundColor: colorDark,
      actions: actions);
}

void showToast(BuildContext context, String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white);
}
