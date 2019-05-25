import 'package:flutter/material.dart';
import '../bloc/page_selector/active_page_provider.dart';
import '../bloc/timer/timer_provider.dart';
import '../bloc/which_page/which_page_provider.dart';
import '../screens/bluetooth_devices.dart';
import '../widgets/timer.dart';
import '../widgets/images_select.dart';
import '../widgets/slide_select.dart';
import '../widgets/image_container.dart';
// import '../widgets/device_info.dart';

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
  TimerBloc timerBloc;
  ActivePageBloc activePageBloc;
  WhichPageBloc whichPageBloc;

  @override
  Widget build(BuildContext context) {
    timerBloc = TimerBlocProvider.of(context);
    activePageBloc = ActivePageProvider.of(context);
    whichPageBloc = WhichPageProvider.of(context);

    return StreamBuilder<Page>(
      stream: activePageBloc.activePage,
      builder: (BuildContext context, AsyncSnapshot<Page> snapshot) {
        if (!snapshot.hasData) return inactiveTimer();
        if (snapshot.data == Page.none ||
            snapshot.data == whichPageBloc.myPage) {
          return activeTimer();
        } else {
          return inactiveTimer();
        }
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
          // DeviceInfo(),
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
                timerBloc.updateControlEvent(TimerEvent.reset);
              });
            },
          ),
          ImageContainer(imageAsset: widget.imagesAssets.ready),
          // DeviceInfo(),
        ],
      ),
    );
  }

  toBluetoothDevices(context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BluetoothDevicesPage()),
    );
  }
}
