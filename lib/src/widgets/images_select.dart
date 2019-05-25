import 'package:flutter/material.dart';
import 'package:pomoblue/src/bloc/page_timers/page_timers_bloc.dart';
import 'package:pomoblue/src/bloc/page_timers/page_timers_provider.dart';
import 'package:pomoblue/src/bloc/page_timers/timer/timer_events.dart';
import 'package:pomoblue/src/bloc/page_timers/which_page/which_page_provider.dart';
import '../widgets/image_container.dart';

class ImagesAssets {
  final String ready;
  final String running;
  final String done;

  ImagesAssets({this.ready, this.running, this.done});
}

class ImagesSelect extends StatefulWidget {
  final ImagesAssets images;
  ImagesSelect({Key key, this.images}) : super(key: key);

  _ImagesSelectState createState() => _ImagesSelectState();
}

class _ImagesSelectState extends State<ImagesSelect> {
  PageTimersBloc pageTimersBloc;
  WhichPageBloc whichPageBloc;
  Pages myPage;

  @override
  Widget build(BuildContext context) {
    pageTimersBloc = PageTimersProvider.of(context);
    whichPageBloc = WhichPageProvider.of(context);
    myPage = whichPageBloc.myPage;
    TimerEvents timerEvents = pageTimersBloc.timers[myPage].timerEvents;

    return StreamBuilder<TimerState>(
      stream: timerEvents.currentState,
      builder: (
        BuildContext context,
        AsyncSnapshot<TimerState> snapshot,
      ) {
        String photo;
        if (!snapshot.hasData) {
          photo = widget.images.ready;
        } else if (snapshot.data == TimerState.running ||
            snapshot.data == TimerState.paused) {
          photo = widget.images.running;
        } else if (snapshot.data == TimerState.done) {
          photo = widget.images.done;
        } else if (snapshot.data == TimerState.reset) {
          photo = widget.images.ready;
        }

        return ImageContainer(imageAsset: photo);
      },
    );
  }
}
