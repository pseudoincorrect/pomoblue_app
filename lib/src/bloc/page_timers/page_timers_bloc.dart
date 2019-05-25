import './timer/timer_interface.dart';
import './timer/timer_events.dart';
import 'package:rxdart/rxdart.dart';
import 'package:audioplayers/audio_cache.dart';
import 'page_timers_provider.dart';

enum Pages { work, shortPause, longPause, none }

const Map<Pages, int> TimersResetVal = {
  Pages.work: secondsInMinutes * 25, // seconds
  Pages.shortPause: secondsInMinutes * 5, // seconds
  Pages.longPause: secondsInMinutes * 45, // seconds
};

class PageTimersBloc {
  Map<Pages, TimerInterface> timers = Map();
  final activePage = BehaviorSubject<Pages>();
  final AudioCache _audioPlayer = new AudioCache();

  PageTimersBloc() {
    for (var page in Pages.values) {
      final timerEvents = TimerEvents();
      final timerInterface = TimerInterface(timerEvents);
      timers[page] = timerInterface;
      timerInterface.timerController.resetVal = TimersResetVal[page];
    }
    _listenCounterEvent();
    _updateActivePage(Pages.none);
    _initAllResetVal();
    resetAll();
  }

  getMytimer(Pages page) {
    return timers[page];
  }

  Observable<Pages> get current => activePage.stream;

  void _updateActivePage(Pages page) {
    activePage.add(page);
  }

  void _initAllResetVal() {
    for (var page in timers.keys) {
      int resetVal = TimersResetVal[page];
      timers[page].timerEvents.updateCounterResetVal(resetVal);
    }
  }

  void _listenCounterEvent() {
    for (var page in timers.keys) {
      timers[page].timerEvents.controlEvents.listen(
        (TimerEvent event) {
          _setActivePage(page, event);
          _emitSounds(event);
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

  Future<void> _emitSounds(TimerEvent event) async {
    if (event == TimerEvent.timeOut) {
      await _audioPlayer.play('sounds/notification.mp3');
    }
  }

  dispose() {
    activePage.close();
  }
}
