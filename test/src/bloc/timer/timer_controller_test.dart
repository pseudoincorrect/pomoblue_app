import 'package:flutter_test/flutter_test.dart';
import 'package:pomoblue/src/bloc/timer/timer_controller.dart';
import 'package:pomoblue/src/bloc/timer/timer_bloc.dart';
import 'dart:async';

void main() {
  group(
    'TimerController Class Tests',
    () {
      // SETUP
      final timerBloc = TimerBloc();
      final timerController = TimerController();
      timerController.setup(timerBloc);

      test(
        'setup should emit a updateCounterVal and updateCurrentState event',
        () async {
          // TEST
          await expectLater(
              timerBloc.counterVal, emits(TimerController.defaultWorkTime));
          await expectLater(timerBloc.currentState, emits(TimerState.reset));
        },
      );
      test(
        'onPeriodicEvent should emit a TimerEvent event',
        () async {
          // RUN TIME
          timerBloc.updateControlEvent(TimerEvent.start);
          timerController.onPeriodicEvent(Timer(Duration(), () {}));
          // TEST
          await expectLater(
              timerBloc.counterVal, emits(TimerController.defaultWorkTime - 1));
        },
      );
      test(
        'onControlEvent should start and stop the timer',
        () {
          // TEST START EVENT
          timerController.onControlEvent(TimerEvent.start);
          expect(timerController.timer.isActive, true);
          // TEST PAUSE EVENT
          timerController.onControlEvent(TimerEvent.pause);
          expect(timerController.timer.isActive, false);
          // TEST PAUSE EVENT
          timerController.resetVal = 2;
          timerController.counter = 3;
          timerController.onControlEvent(TimerEvent.reset);
          expect(timerController.counter, timerController.resetVal);
        },
      );

      test(
        'onResetValData should reset the count if in reset mode',
        () {
          // TEST START EVENT
          timerController.counter = 2;
          timerController.timerState = TimerState.paused;
          timerController.onResetValData(3);
          expect(timerController.counter, 2);
          // TEST PAUSE EVENT
          timerController.timerState = TimerState.reset;
          timerController.onResetValData(3);
          expect(timerController.counter, 3);
        },
      );
      test(
        'cancelTimer should reset the count if in reset mode',
        () {
          // TEST CANCEL TIMER
          const Duration period = Duration(milliseconds: 100);
          timerController.timer = Timer.periodic(period, (timer) {});
          expect(timerController.timer.isActive, true);
          timerController.cancelTimer();
          expect(timerController.timer.isActive, false);
        },
      );
      test(
        'updateTimerFSM should reset the count if in reset mode',
        () {
          // RESET
          timerController.timerState = TimerState.reset;
          expect(timerController.timerState, TimerState.reset);
          // RUNNING
          timerController.updateTimerFSM(TimerEvent.start);
          expect(timerController.timerState, TimerState.running);
          // DONE
          timerController.updateTimerFSM(TimerEvent.timeOut);
          expect(timerController.timerState, TimerState.done);
          // RUNNING
          timerController.updateTimerFSM(TimerEvent.start);
          expect(timerController.timerState, TimerState.running);
          // RUNNING
          timerController.updateTimerFSM(TimerEvent.pause);
          expect(timerController.timerState, TimerState.paused);
        },
      );
    },
  );
}
