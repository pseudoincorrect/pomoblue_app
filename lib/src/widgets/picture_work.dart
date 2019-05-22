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
          photo = 'assets/images/relax_time.jpg';
        } else if (snapshot.data == TimerState.running) {
          photo = 'assets/images/work_time.jpg';
        } else {
          photo = 'assets/images/relax_time.jpg';
        }
        return Container(
          margin: EdgeInsets.only(left: 15.0, right: 15.0),
          child: Card(
            child: Image.asset(photo),
          ),
        );
      },
    );
  }
}
