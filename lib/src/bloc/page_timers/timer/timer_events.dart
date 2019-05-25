import 'package:rxdart/rxdart.dart';

enum TimerEvent { start, pause, reset, timeOut }

enum TimerState { reset, running, paused, done }

class TimerEvents {
  final _timerEvents = PublishSubject<TimerEvent>();
  final _timerCurrentState = BehaviorSubject<TimerState>();
  final _timerCounterVal = BehaviorSubject<int>();
  final _timerResetVal = BehaviorSubject<int>();

  // TIMER EVENTS
  Observable<TimerEvent> get controlEvents => _timerEvents.stream;

  void updateControlEvent(TimerEvent event) {
    _timerEvents.add(event);
  }

  // TIMER STATE
  Observable<TimerState> get currentState => _timerCurrentState.stream;

  void updateCurrentState(TimerState state) {
    _timerCurrentState.add(state);
  }

  // TIMER COUNTER
  Observable<int> get counterVal => _timerCounterVal.stream;

  void updateCounterVal(int value) {
    _timerCounterVal.add(value);
  }

  // TIMER RESET VAL
  Observable<int> get counterResetVal => _timerResetVal.stream;

  void updateCounterResetVal(int resetVal) {
    _timerResetVal.add(resetVal);
  }

  dispose() {
    _timerEvents.close();
    _timerCurrentState.close();
    _timerCounterVal.close();
  }

  static void printEvent(TimerEvent timerEvent) {
    if (timerEvent == TimerEvent.start) print('timerEvent start');
    if (timerEvent == TimerEvent.pause) print('timerEvent stop');
    if (timerEvent == TimerEvent.reset) print('timerEvent reset');
  }

  static void printState(TimerState timerState) {
    if (timerState == TimerState.running) print("TimerState.running");
    if (timerState == TimerState.paused) print("TimerState.paused");
    if (timerState == TimerState.done) print("TimerState.done");
  }
}
