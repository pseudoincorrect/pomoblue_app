import 'dart:async';

class TimerController {
  Timer timer;

  TimerController() {
    timer = Timer.periodic(Duration(seconds: 1), handleTimeout);
  }

  void handleTimeout(timer) {
    print("hey");
  }
}
