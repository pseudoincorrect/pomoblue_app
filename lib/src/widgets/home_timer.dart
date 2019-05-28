import 'package:flutter/material.dart';
import '../bloc/page_timers/page_timers_provider.dart';
import '../bloc/page_timers/which_page/which_page_provider.dart';
import '../widgets/timer.dart';
import '../widgets/images_select.dart';
import '../widgets/slide_select.dart';
import '../widgets/image_container.dart';
import '../widgets/device_info.dart';

class HomeTimer extends StatefulWidget {
  final String hideText;
  final ImagesAssets imagesAssets;
  final Color backGroundColor;

  const HomeTimer({
    Key key,
    this.imagesAssets,
    this.hideText,
    this.backGroundColor,
  }) : super(key: key);

  _HomeTimerState createState() => _HomeTimerState();
}

class _HomeTimerState extends State<HomeTimer> {
  bool isActive = true;
  PageTimersBloc pageTimersBloc;
  WhichPageBloc whichPageBloc;
  Pages myPage;

  @override
  Widget build(BuildContext context) {
    pageTimersBloc = PageTimersProvider.of(context);
    whichPageBloc = WhichPageProvider.of(context);
    myPage = whichPageBloc.myPage;

    return StreamBuilder<Pages>(
      stream: pageTimersBloc.activePage,
      builder: (BuildContext context, AsyncSnapshot<Pages> snapshot) {
        if (!snapshot.hasData) {
          return inactiveTimer();
        }
        if (snapshot.data == Pages.none || snapshot.data == myPage) {
          return activeTimer();
        }
        return inactiveTimer();
      },
    );
  }

  Widget activeTimer() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          PomoTimer(),
          SlideSelect(hideText: widget.hideText),
          ImagesSelect(
            images: ImagesAssets(
              ready: widget.imagesAssets.ready,
              done: widget.imagesAssets.done,
              running: widget.imagesAssets.running,
            ),
          ),
          DeviceInfo(),
        ],
      ),
    );
  }

  Widget inactiveTimer() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text("Other Pomodoro \n\nalready running"),
          RaisedButton(
            child: Text("restart Here"),
            onPressed: () {
              setState(() {
                pageTimersBloc.resetAll();
              });
            },
          ),
          ImageContainer(imageAsset: widget.imagesAssets.ready),
          DeviceInfo(),
        ],
      ),
    );
  }
}
