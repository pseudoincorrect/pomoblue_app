import 'package:flutter/material.dart';
import 'package:pomoblue/src/bloc/page_timers/page_timers_provider.dart';
import 'package:pomoblue/src/bloc/page_timers/timer/timer_events.dart';
import 'package:pomoblue/src/bloc/page_timers/which_page/which_page_provider.dart';

class SlideSelect extends StatefulWidget {
  final String hideText;

  SlideSelect({Key key, this.hideText}) : super(key: key);

  @override
  _SlideSelectState createState() => _SlideSelectState();
}

class _SlideSelectState extends State<SlideSelect> {
  PageTimersBloc pageTimersBloc;
  WhichPageBloc whichPageBloc;
  TimerState timerStates;
  Pages myPage;
  TimerEvents timerEvents;
  double _slideVal;

  @override
  Widget build(BuildContext context) {
    pageTimersBloc = PageTimersProvider.of(context);
    whichPageBloc = WhichPageProvider.of(context);
    myPage = whichPageBloc.myPage;
    timerEvents = pageTimersBloc.timers[myPage].timerEvents;
    // _slideVal = TimersResetVal[myPage].toDouble() / secondsInMinutes;

    if (_slideVal == null) {
      _slideVal = TimersResetVal[myPage].toDouble() / secondsInMinutes;
    }

    return StreamBuilder<TimerState>(
      stream: timerEvents.currentState,
      builder: (BuildContext context, AsyncSnapshot<TimerState> snapshot) {
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
                  timerEvents.updateCounterResetVal(getRoundSeconds(val));
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
    return val.toInt() * secondsInMinutes;
  }

  // void setDefaultResetVal(BuildContext context) {
  //   whichPageBloc = WhichPageProvider.of(context);
  //   if (whichPageBloc.myPage == Pages.work) {
  //     timerBloc.updateCounterResetVal(60 * 25);
  //   } else if (whichPageBloc.myPage == Pages.shortPause) {
  //     timerBloc.updateCounterResetVal(60 * 5);
  //   } else if (whichPageBloc.myPage == Pages.longPause) {
  //     timerBloc.updateCounterResetVal(60 * 45);
  //   }
  // }
}
