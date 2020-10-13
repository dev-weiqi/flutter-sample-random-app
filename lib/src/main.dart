import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:randomapp/src/public.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SpUtil.getInstance();
  return runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MainBloc>(
        create: (context) => MainBloc(),
        child: MaterialApp(
            home: HomePage(),
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