import 'package:flutter/material.dart';
import './page_timers_bloc.dart';
export './page_timers_bloc.dart';

const int secondsInMinutes = 60;

class PageTimersProvider extends InheritedWidget {
  final PageTimersBloc bloc;

  PageTimersProvider({Key key, Widget child, this.bloc})
      : super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static PageTimersBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(PageTimersProvider)
            as PageTimersProvider)
        .bloc;
  }
}
