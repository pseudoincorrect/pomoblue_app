import 'package:flutter/material.dart';
import './timer_bloc.dart';
export './timer_bloc.dart';

class TimerBlocProvider extends InheritedWidget {
  final TimerBloc bloc;

  TimerBlocProvider({Key key, Widget child})
      : bloc = TimerBloc(),
        super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static TimerBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(TimerBlocProvider)
            as TimerBlocProvider)
        .bloc;
  }
}
