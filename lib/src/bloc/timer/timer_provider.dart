import 'package:flutter/material.dart';
import 'package:pomoblue/src/bloc/timer/timer_controller.dart';
import './timer_bloc.dart';
export './timer_bloc.dart';

class TimerBlocProvider extends InheritedWidget {
  final TimerBloc bloc;
  final TimerController timerController;

  TimerBlocProvider({Key key, Widget child})
      : bloc = TimerBloc(),
        timerController = TimerController(),
        super(key: key, child: child) {
    timerController.setup(bloc);
  }

  bool updateShouldNotify(_) => true;

  static TimerBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(TimerBlocProvider)
            as TimerBlocProvider)
        .bloc;
  }
}
