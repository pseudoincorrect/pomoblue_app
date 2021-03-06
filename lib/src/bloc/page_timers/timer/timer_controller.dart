import 'dart:async';
import '../page_timers_provider.dart';
import './timer_events.dart';

const Duration period = Duration(milliseconds: 1000);

class TimerController {
  TimerEvents bloc;
  Timer timer;
  TimerState timerState;
  int counter;
  int resetVal;
  static const int defaultTimeInSecs = 25 * secondsInMinutes;

  void setup(TimerEvents timerEvents,
      {int defaultTime = TimerController.defaultTimeInSecs}) {
    // Attributes
    bloc = timerEvents;
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
      bloc.updateCounterVal(counter);
    } else {
      cancelTimer();
      bloc.updateControlEvent(TimerEvent.timeOut);
    }
  }

  void onControlEvent(TimerEvent timerEvent) {
    if (timerEvent == TimerEvent.start) {
      // if (timerState == TimerState.done) return;
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

    if (timerEvent == TimerEvent.timeOut) {
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
