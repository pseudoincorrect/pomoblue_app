import 'dart:async';

import 'package:pomoblue/src/bloc/timer/timer_bloc.dart';

const Duration period = Duration(milliseconds: 100);
const int defaultWorkTime = 25 * 60; // seconds

class TimerController {
  TimerBloc _bloc;
  Timer _timer;
  TimerState _timerState;
  int _counter;
  int _resetVal;

  void setup(TimerBloc timerBloc) {
    _bloc = timerBloc;
    _resetVal = defaultWorkTime;
    _counter = _resetVal;
    _timerState = TimerState.done;
    _bloc.controlEvents.listen(onControlEvent);
    _bloc.controlEvents.listen(updateTimerFSM);
    _bloc.counterResetVal.listen(onResetValData);
    _bloc.updateCounterVal(_counter);
    _bloc.updateCurrentState(_timerState);
  }

  void onPeriodicEvent(Timer timer) {
    _bloc.updateCounterVal(_counter);
    if (_counter > 0) {
      _counter--;
    } else {
      _timer.cancel();
      _bloc.updateControlEvent(TimerEvent.timeOut);
    }
  }

  void onControlEvent(TimerEvent timerEvent) {
    if (timerEvent == TimerEvent.start) {
      if (_timer == null) {
        _timer = Timer.periodic(period, onPeriodicEvent);
      } else if (!_timer.isActive) {
        _timer = Timer.periodic(period, onPeriodicEvent);
      }
    }
    if (timerEvent == TimerEvent.pause) {
      _timer.cancel();
    }
    if (timerEvent == TimerEvent.reset) {
      _counter = _resetVal;
      _bloc.updateCounterVal(_counter);
      if (_timer != null) _timer.cancel();
    }
  }

  void onResetValData(int newVal) {
    print("newVal");
    _resetVal = newVal;
    if (_timerState == TimerState.done) {
      _counter = newVal;
      _bloc.updateCounterVal(_counter);
    }
  }

  void updateTimerFSM(TimerEvent timerEvent) {
    if (timerEvent == TimerEvent.reset) {
      _timerState = TimerState.done;
    } else {
      switch (_timerState) {
        case TimerState.running:
          if (timerEvent == TimerEvent.timeOut)
            _timerState = TimerState.done;
          else if (timerEvent == TimerEvent.pause)
            _timerState = TimerState.paused;
          break;

        case TimerState.paused:
          if (timerEvent == TimerEvent.start) {
            _timerState = TimerState.running;
          }
          break;

        case TimerState.done:
          if (timerEvent == TimerEvent.start) {
            _timerState = TimerState.running;
          }
          break;

        default:
          break;
      }
    }
    TimerBloc.printState(_timerState);
  }
}
