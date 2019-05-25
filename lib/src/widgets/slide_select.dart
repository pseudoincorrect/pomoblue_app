import 'package:flutter/material.dart';
import 'package:pomoblue/src/bloc/timer/timer_bloc.dart';
import 'package:pomoblue/src/bloc/timer/timer_provider.dart';
import 'package:pomoblue/src/bloc/which_page/which_page_provider.dart';
import 'package:pomoblue/src/bloc/page_selector/active_page_provider.dart';

class SlideSelect extends StatefulWidget {
  final String hideText;

  SlideSelect({Key key, this.hideText}) : super(key: key);

  @override
  _SlideSelectState createState() => _SlideSelectState();
}

class _SlideSelectState extends State<SlideSelect> {
  TimerBloc timerBloc;
  WhichPageBloc whichPageBloc;

  double _slideVal = 25.0;
  @override
  Widget build(BuildContext context) {
    timerBloc = TimerBlocProvider.of(context);

    int ind = DefaultTabController.of(context).index;
    print("index " + ind.toString());

    return StreamBuilder<TimerState>(
      stream: timerBloc.currentState,
      builder: (BuildContext context, AsyncSnapshot<TimerState> snapshot) {
        setDefaultResetVal(context);
        if (!snapshot.hasData) {
          return Container(
            child: sliderWidget(),
            height: 50,
          );
        } else if (snapshot.data == TimerState.reset ||
            snapshot.data == TimerState.done) {
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

  void setDefaultResetVal(BuildContext context) {
    whichPageBloc = WhichPageProvider.of(context);
    if (whichPageBloc.myPage == Page.work) {
      timerBloc.updateCounterResetVal(60 * 25);
    } else if (whichPageBloc.myPage == Page.shortPause) {
      timerBloc.updateCounterResetVal(60 * 5);
    } else if (whichPageBloc.myPage == Page.longPause) {
      timerBloc.updateCounterResetVal(60 * 45);
    }
  }
}
