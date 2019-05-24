import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';
import 'package:pomoblue/src/bloc/timer/timer_bloc.dart';

enum Page { work, shortPause, longPause, none }

class ActivePageBloc {
  final TimerBloc timerBloc;
  final activePage = BehaviorSubject<Page>();

  ActivePageBloc({this.timerBloc}) {
    updateactivePage(Page.none);
    timerBloc.currentState.listen(onCounterState);
  }

  Observable<Page> get current => activePage.stream;

  void updateactivePage(Page page) {
    activePage.add(page);
  }

  void onCounterState(TimerState timerState) {
    if (timerState == TimerState.done || timerState == TimerState.reset) {
      updateactivePage(Page.none);
    }
  }

  dispose() {
    activePage.close();
  }
}
