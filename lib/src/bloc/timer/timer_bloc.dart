import 'package:rxdart/rxdart.dart';
import 'dart:async';

enum TimerEvent { start, stop, reset }

enum TimerState { running, stopped }

class TimerBloc {
  final _timerEvents = PublishSubject<TimerEvent>();
  final _timerCurrentState = BehaviorSubject<TimerState>();
  final _timerCounterVal = BehaviorSubject<int>();

  // TIMER EVENTS
  Stream get getEvents => _timerEvents.stream;

  void updateEvent(TimerEvent event) {
    _timerEvents.add(event);
  }

  // TIMER STATE
  Stream get getCurrentState => _timerCurrentState.stream;

  void updateCurrentState(TimerState state) {
    _timerCurrentState.add(state);
  }

  // TIMER COUNTER
  Stream get getCounterVal => _timerCounterVal.stream;

  void updateCounterVal(int value) {
    _timerCounterVal.add(value);
  }

  dispose() {
    _timerEvents.close();
    _timerCurrentState.close();
    _timerCounterVal.close();
  }
}
