import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:pomoblue/src/bloc/timer/timer_bloc.dart';

void main() {
  group(
    'TimerBloc Class Tests',
    () {
      test(
        'updateControlEvent should emit a TimerEvent event',
        () async {
          // SETUP
          final timerBloc = TimerBloc();
          final TimerEvent controlEventsent = TimerEvent.pause;
          // // RUN TIME
          scheduleMicrotask(() {
            timerBloc.updateControlEvent(controlEventsent);
          });
          // TEST
          await expectLater(timerBloc.controlEvents, emits(TimerEvent.pause));
        },
      );
      test(
        'updateControlEvent should expect a listened TimerEvent equal to the one emited',
        () async {
          // SETUP
          final timerBloc = TimerBloc();
          final TimerEvent controlEventsent = TimerEvent.pause;
          dynamic firstEvent = timerBloc.controlEvents.first;
          // // RUN TIME
          timerBloc.updateControlEvent(controlEventsent);
          dynamic controlEventReceived = await firstEvent;
          // TEST
          expect(controlEventReceived, controlEventsent);
        },
      );
      test(
        'updateCounterVal should expect a listened integer equal to the one emited',
        () async {
          // SETUP
          final timerBloc = TimerBloc();
          final int counterValsent = 1;
          dynamic firstEvent = timerBloc.counterVal.first;
          // // RUN TIME
          timerBloc.updateCounterVal(counterValsent);
          dynamic counterValReceived = await firstEvent;
          // TEST
          expect(counterValReceived, counterValsent);
        },
      );
      test(
        'updateCounterVal should expect a listened integer equal to the one emited',
        () async {
          // SETUP
          final timerBloc = TimerBloc();
          final int counterValsent = 1;
          dynamic firstEvent = timerBloc.counterVal.first;
          // // RUN TIME
          timerBloc.updateCounterVal(counterValsent);
          dynamic counterValReceived = await firstEvent;
          // TEST
          expect(counterValReceived, counterValsent);
        },
      );
      test(
        'updateCounterResetVal should expect a listened integer equal to the one emited',
        () async {
          // SETUP
          final timerBloc = TimerBloc();
          final int counterResedValsent = 999;
          dynamic firstEvent = timerBloc.counterResetVal.first;
          // // RUN TIME
          timerBloc.updateCounterResetVal(counterResedValsent);
          dynamic counterResedValReceived = await firstEvent;
          // TEST
          expect(counterResedValReceived, counterResedValsent);
        },
      );
    },
  );
}
