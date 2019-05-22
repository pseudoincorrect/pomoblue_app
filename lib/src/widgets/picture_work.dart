import 'package:flutter/material.dart';
import 'package:pomoblue/src/bloc/timer/timer_bloc.dart';
import '../bloc/timer/timer_provider.dart';

class PictureWork extends StatefulWidget {
  PictureWork({Key key}) : super(key: key);

  _PictureWorkState createState() => _PictureWorkState();
}

class _PictureWorkState extends State<PictureWork> {
  TimerBloc timerBloc;

  @override
  Widget build(BuildContext context) {
    timerBloc = TimerBlocProvider.of(context);

    return StreamBuilder<TimerState>(
      stream: timerBloc.currentState,
      builder: (
        BuildContext context,
        AsyncSnapshot<TimerState> snapshot,
      ) {
        String photo;
        if (!snapshot.hasData) {
          photo = 'assets/images/ready.jpg';
        } else if (snapshot.data == TimerState.running ||
            snapshot.data == TimerState.paused) {
          photo = 'assets/images/work_time.jpg';
        } else if (snapshot.data == TimerState.done) {
          photo = 'assets/images/relax_time.jpg';
        } else if (snapshot.data == TimerState.reset) {
          photo = 'assets/images/ready.jpg';
        }

        return Container(
          margin: EdgeInsets.only(left: 15.0, right: 15.0),
          child: Card(
            elevation: 5.0,
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(4.0),
              ),
              child: Image.asset(photo),
            ),
          ),
        );
      },
    );
  }
}
