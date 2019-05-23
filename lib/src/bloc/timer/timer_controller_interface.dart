import './timer_controller.dart';
import 'package:pomoblue/src/bloc/timer/timer_bloc.dart';

class TimerControllerInterface {
  TimerController _timerController;

  TimerControllerInterface() {
    _timerController = TimerController();
  }

  setup(TimerBloc timerBloc) {
    _timerController.setup(timerBloc);
  }
}
