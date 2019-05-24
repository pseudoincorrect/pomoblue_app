import 'package:flutter/material.dart';
import '../bloc/timer/timer_provider.dart';
import '../bloc/page_selector/active_page_provider.dart';
import '../bloc/which_page/which_page_provider.dart';

class PomoTimer extends StatefulWidget {
  PomoTimer({Key key}) : super(key: key);

  _PomoTimerState createState() => _PomoTimerState();
}

class _PomoTimerState extends State<PomoTimer> {
  TimerBloc timerBloc;
  ActivePageBloc activePageBloc;
  WhichPageBloc whichPageBloc;

  @override
  Widget build(BuildContext context) {
    timerBloc = TimerBlocProvider.of(context);
    activePageBloc = ActivePageProvider.of(context);
    whichPageBloc = WhichPageProvider.of(context);

    return Container(
      margin: EdgeInsets.only(left: 15.0, right: 15.0),
      height: 120,
      child: Container(
        margin: EdgeInsets.only(left: 15.0, right: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            timerView(),
            controls(),
          ],
        ),
      ),
    );
  }

  Widget controls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        controlButton(Icons.play_arrow, start),
        controlButton(Icons.pause, pause),
        controlButton(Icons.fast_rewind, reset),
      ],
    );
  }

  Widget controlButton(icon, callback) {
    return RaisedButton(
      child: Icon(icon, size: 40),
      onPressed: callback,
    );
  }

  void start() {
    timerBloc.updateControlEvent(TimerEvent.start);
    activePageBloc.updateactivePage(whichPageBloc.myPage);
  }

  void pause() {
    timerBloc.updateControlEvent(TimerEvent.pause);
  }

  void reset() {
    timerBloc.updateControlEvent(TimerEvent.reset);
  }

  Widget timerView() {
    return Center(
      child: StreamBuilder<int>(
        stream: timerBloc.counterVal, // a Stream<int> or null
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          int data = snapshot.data ?? 0;
          return clock(data);
        },
      ),
    );
  }

  Widget clock(int data) {
    int hours = data ~/ 3600;
    int minutes = (data % 3600) ~/ 60;
    int seconds = data % 60;
    String display;

    if (hours != 0) {
      display =
          '${hours.toString()}h ${minutes.toString()}m ${seconds.toString()}s';
    } else if (minutes != 0) {
      display = '${minutes.toString()}m ${seconds.toString()}s';
    } else {
      display = '${seconds.toString()}s';
    }
    return Text(
      display,
      style: TextStyle(
          fontSize: 50, fontFamily: 'Mozart', fontWeight: FontWeight.bold),
    );
  }
}
