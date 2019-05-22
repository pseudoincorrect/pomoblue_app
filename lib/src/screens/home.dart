import 'package:flutter/material.dart';
import '../screens/bluetooth_devices.dart';
import '../widgets/timer.dart';
import '../widgets/picture_work.dart';
import '../widgets/appBar_w_settings.dart';
import '../widgets/slide_select.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar('PomoBlue'),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(height: 20),
          PomoTimer(),
          SlideSelect(),
          PictureWork(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => toBluetoothDevices(context),
        child: Icon(Icons.add),
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
