import './timer/timer_interface.dart';
import './timer/timer_events.dart';
import 'package:rxdart/rxdart.dart';

enum Pages { work, shortPause, longPause, none }

const Map<Pages, int> TimersResetVal = {
  Pages.work: 60 * 25, // seconds
  Pages.shortPause: 60 * 5, // seconds
  Pages.longPause: 60 * 45, // seconds
};

class PageTimersBloc {
  Map<Pages, TimerInterface> timers = Map();
  final activePage = BehaviorSubject<Pages>();

  PageTimersBloc() {
    for (var page in Pages.values) {
      final timerEvents = TimerEvents();
      final timerInterface = TimerInterface(timerEvents);
      timers[page] = timerInterface;
      timerInterface.timerController.resetVal = TimersResetVal[page];
    }
    _listenCounterEvent();
    _updateActivePage(Pages.none);
    resetAll();
  }

  getMytimer(Pages page) {
    return timers[page];
  }

  Observable<Pages> get current => activePage.stream;

  void _updateActivePage(Pages page) {
    activePage.add(page);
  }

  void _listenCounterEvent() {
    for (var page in timers.keys) {
      timers[page].timerEvents.controlEvents.listen(
        (TimerEvent event) {
          _setActivePage(page, event);
        },
      );
    }
  }

  void resetAll() {
    for (var timer in timers.values) {
      timer.timerEvents.updateControlEvent(TimerEvent.reset);
    }
  }

  void _setActivePage(Pages pageFrom, TimerEvent event) {
    if (event == TimerEvent.reset) {
      _updateActivePage(Pages.none);
    }
    if (event == TimerEvent.timeOut) {
      _updateActivePage(Pages.none);
    }
    if (event == TimerEvent.start) {
      _updateActivePage(pageFrom);
    }
  }

  dispose() {
    activePage.close();
  }
}
