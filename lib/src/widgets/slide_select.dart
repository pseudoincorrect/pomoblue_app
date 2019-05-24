import 'package:flutter/material.dart';
import 'package:pomoblue/src/bloc/timer/timer_bloc.dart';
import 'package:pomoblue/src/bloc/timer/timer_provider.dart';

class SlideSelect extends StatefulWidget {
  final String hideText;

  SlideSelect({Key key, this.hideText}) : super(key: key);

  @override
  _SlideSelectState createState() => _SlideSelectState();
}

class _SlideSelectState extends State<SlideSelect> {
  TimerBloc timerBloc;

  double _slideVal = 25.0;
  @override
  Widget build(BuildContext context) {
    timerBloc = TimerBlocProvider.of(context);
    return StreamBuilder<TimerState>(
      stream: timerBloc.currentState,
      builder: (BuildContext context, AsyncSnapshot<TimerState> snapshot) {
        if (!snapshot.hasData) {
          return Container(
            child: sliderWidget(),
            height: 50,
          );
        } else if (snapshot.data == TimerState.reset) {
          return Container(
            child: sliderWidget(),
            height: 50,
          );
        } else {
          return Container(
            height: 50,
            child: Center(child: Text(widget.hideText)),
          );
        }
      },
    );
  }

  Widget sliderWidget() {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 30),
      child: Row(
        children: <Widget>[
          Container(
            width: 120,
            child: Text(
              'Duration',
              textAlign: TextAlign.center,
            ),
          ),
          Flexible(
            child: Slider(
              value: _slideVal,
              min: 1.0,
              max: 60.0,
              onChanged: (double val) {
                setState(() {
                  _slideVal = val;
                  timerBloc.updateCounterResetVal(getRoundSeconds(val));
                });
              },
            ),
          ),
          Container(
            width: 50,
            child: Text(
              _slideVal.toInt().toString() + 'm',
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }

  int getRoundSeconds(double val) {
    return val.toInt() * 60;
  }
}
