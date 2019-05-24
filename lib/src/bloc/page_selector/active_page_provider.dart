import 'package:flutter/material.dart';
import './active_page_bloc.dart';
export './active_page_bloc.dart';

class ActivePageProvider extends InheritedWidget {
  final ActivePageBloc bloc;

  ActivePageProvider({Key key, Widget child, this.bloc})
      : super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static ActivePageBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(ActivePageProvider)
            as ActivePageProvider)
        .bloc;
  }
}
