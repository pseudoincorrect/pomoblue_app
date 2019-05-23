import 'package:flutter/material.dart';
import 'package:pomoblue/src/bloc/timer/timer_controller_interface.dart';
import './timer_bloc.dart';
export './timer_bloc.dart';

class TimerBlocProvider extends InheritedWidget {
  final TimerBloc bloc;
  final TimerControllerInterface timerControllerInterface;

  TimerBlocProvider({Key key, Widget child})
      : bloc = TimerBloc(),
        timerControllerInterface = TimerControllerInterface(),
        super(key: key, child: child) {
    timerControllerInterface.setup(bloc);
  }

  bool updateShouldNotify(_) => true;

  static TimerBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(TimerBlocProvider)
            as TimerBlocProvider)
        .bloc;
  }
}
