import './timer_controller.dart';
import './timer_events.dart';

class TimerInterface {
  TimerController timerController;
  TimerEvents timerEvents;

  TimerInterface(TimerEvents timerEvents) {
    timerController = TimerController();
    this.timerEvents = timerEvents;
    timerController.setup(timerEvents);
  }
}
