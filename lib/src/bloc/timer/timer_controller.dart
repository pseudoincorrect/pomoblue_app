import 'dart:async';
import 'package:pomoblue/src/bloc/timer/timer_bloc.dart';

const Duration period = Duration(milliseconds: 100);

class TimerController {
  TimerBloc bloc;
  Timer timer;
  TimerState timerState;
  int counter;
  int resetVal;
  static const int defaultWorkTime = 25 * 60; // seconds

  void setup(TimerBloc timerBloc, {int defaultTime = defaultWorkTime}) {
    // Attributes
    bloc = timerBloc;
    resetVal = defaultTime;
    counter = resetVal;
    timerState = TimerState.reset;
    // Inputs
    bloc.controlEvents.listen(onControlEvent);
    bloc.controlEvents.listen(updateTimerFSM);
    bloc.counterResetVal.listen(onResetValData);
    // Outputs
    bloc.updateCounterVal(counter);
    bloc.updateCurrentState(timerState);
  }

  void onPeriodicEvent(Timer timer) {
    if (counter > 0) {
      counter--;
    } else {
      cancelTimer();
      bloc.updateControlEvent(TimerEvent.timeOut);
    }
    bloc.updateCounterVal(counter);
  }

  void onControlEvent(TimerEvent timerEvent) {
    if (timerEvent == TimerEvent.start) {
      if (timer == null) {
        timer = Timer.periodic(period, onPeriodicEvent);
      } else if (!timer.isActive) {
        timer = Timer.periodic(period, onPeriodicEvent);
      }
    }
    if (timerEvent == TimerEvent.pause) {
      bloc.updateCounterVal(counter);
      cancelTimer();
    }
    if (timerEvent == TimerEvent.reset) {
      counter = resetVal;
      bloc.updateCounterVal(counter);
      cancelTimer();
    }
  }

  void onResetValData(int newVal) {
    resetVal = newVal;
    if (timerState == TimerState.done || timerState == TimerState.reset) {
      counter = newVal;
      bloc.updateCounterVal(counter);
    }
  }

  void cancelTimer() {
    if (timer != null) timer.cancel();
  }

  void updateTimerFSM(TimerEvent timerEvent) {
    if (timerEvent == TimerEvent.reset) {
      timerState = TimerState.reset;
    } else {
      switch (timerState) {
        case TimerState.reset:
          if (timerEvent == TimerEvent.start) {
            timerState = TimerState.running;
          }
          break;

        case TimerState.running:
          if (timerEvent == TimerEvent.timeOut)
            timerState = TimerState.done;
          else if (timerEvent == TimerEvent.pause)
            timerState = TimerState.paused;
          break;

        case TimerState.paused:
          if (timerEvent == TimerEvent.start) {
            timerState = TimerState.running;
          }
          break;

        case TimerState.done:
          if (timerEvent == TimerEvent.start) {
            timerState = TimerState.running;
          }
          break;

        default:
          break;
      }
    }
    bloc.updateCurrentState(timerState);
  }
}
