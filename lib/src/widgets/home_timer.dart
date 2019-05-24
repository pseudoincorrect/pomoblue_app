import 'package:flutter/material.dart';
import '../screens/bluetooth_devices.dart';
import '../widgets/timer.dart';
import '../widgets/images_select.dart';
import '../widgets/slide_select.dart';
import '../widgets/device_info.dart';

class HomeTimer extends StatelessWidget {
  final String hideText;
  final ImagesAssets imagesAssets;
  final Color backGroundColor;

  const HomeTimer({
    Key key,
    this.imagesAssets,
    this.hideText,
    this.backGroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(color: backGroundColor),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          PomoTimer(),
          SlideSelect(hideText: hideText),
          ImagesSelect(
            images: ImagesAssets(
              ready: imagesAssets.ready,
              done: imagesAssets.done,
              running: imagesAssets.running,
            ),
          ),
          // DeviceInfo(),
          // Container(height: 20),
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
