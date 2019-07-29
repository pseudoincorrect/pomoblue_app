import 'package:flutter/material.dart';
import 'package:pomoblue/src/bloc/bluetooth/bluetooth_provider.dart';

class DeviceInfo extends StatefulWidget {
  DeviceInfo({Key key}) : super(key: key);

  _DeviceInfoState createState() => _DeviceInfoState();
}

class _DeviceInfoState extends State<DeviceInfo> {
  BluetoothBloc bluetoothBloc;

  @override
  Widget build(BuildContext context) {
    bluetoothBloc = BluetoothProvider.of(context);
    // if (bluetoothBloc.isConnected) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        RaisedButton(
          child: Text("LED"),
          onPressed: () => changeLed(),
        ),
        RaisedButton(
          child: Text("BUTTON"),
          onPressed: () => listenButton(),
        ),
        Container(
          width: 40,
        )
      ],
    );
    // } else {
    //   return Container();
    // }
  }

  void changeLed() {
    bluetoothBloc.writeLedOn();
  }

  void listenButton() {
    print(bluetoothBloc.services[2].characteristics[0].uuid.toString());
    bluetoothBloc.setNotificationButton(onButton);
    print("listen button");
  }

  void onButton(List<int> vals) {
    for (var val in vals) {
      print('val $val');
    }
  }
}
