import 'package:flutter/material.dart';
import 'package:randomapp/src/main_bloc.dart';

class BlocProvider extends InheritedWidget {
  final MainBloc bloc = MainBloc();

  BlocProvider({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_) => true;

  static MainBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<BlocProvider>().bloc;
  }
}
