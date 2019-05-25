import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:pomoblue/src/bloc/page_timers/timer/timer_events.dart';

void main() {
  group(
    'PageTimerBloc Class Tests',
    () {
      final timerEvents = TimerEvents();

      test(
        'updateControlEvent should emit a TimerEvent event',
        () async {
          // SETUP
          final TimerEvent controlEventsent = TimerEvent.pause;
          // // RUN TIME
          scheduleMicrotask(() {
            timerEvents.updateControlEvent(controlEventsent);
          });
          // TEST
          await expectLater(timerEvents.controlEvents, emits(TimerEvent.pause));
        },
      );
      test(
        'updateControlEvent should expect a listened TimerEvent equal to the one emited',
        () async {
          // SETUP
          final TimerEvent controlEventsent = TimerEvent.pause;
          dynamic firstEvent = timerEvents.controlEvents.first;
          // // RUN TIME
          timerEvents.updateControlEvent(controlEventsent);
          dynamic controlEventReceived = await firstEvent;
          // TEST
          expect(controlEventReceived, controlEventsent);
        },
      );
      test(
        'updateCounterVal should expect a listened integer equal to the one emited',
        () async {
          // SETUP
          final int counterValsent = 1;
          dynamic firstEvent = timerEvents.counterVal.first;
          // // RUN TIME
          timerEvents.updateCounterVal(counterValsent);
          dynamic counterValReceived = await firstEvent;
          // TEST
          expect(counterValReceived, counterValsent);
        },
      );
      test(
        'updateCounterVal should expect a listened integer equal to the one emited',
        () async {
          // SETUP
          final int counterValsent = 1;
          dynamic firstEvent = timerEvents.counterVal.first;
          // // RUN TIME
          timerEvents.updateCounterVal(counterValsent);
          dynamic counterValReceived = await firstEvent;
          // TEST
          expect(counterValReceived, counterValsent);
        },
      );
      test(
        'updateCounterResetVal should expect a listened integer equal to the one emited',
        () async {
          // SETUP
          final int counterResedValsent = 999;
          dynamic firstEvent = timerEvents.counterResetVal.first;
          // // RUN TIME
          timerEvents.updateCounterResetVal(counterResedValsent);
          dynamic counterResedValReceived = await firstEvent;
          // TEST
          expect(counterResedValReceived, counterResedValsent);
        },
      );
    },
  );
}
