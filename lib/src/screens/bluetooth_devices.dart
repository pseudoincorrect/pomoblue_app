import 'package:flutter/material.dart';
import '../widgets/appBar_w_settings.dart';

class BluetoothDevicesPage extends StatelessWidget {
  const BluetoothDevicesPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar('Select your Device'),
      body: Center(
        child: ListView(
          children: <Widget>[
            ListTile(title: Text('device 1')),
            ListTile(title: Text('device 2')),
            ListTile(title: Text('device 3')),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        child: Icon(Icons.add),
      ),
    );
  }
}
