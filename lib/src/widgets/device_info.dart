import 'package:flutter/material.dart';
import 'package:pomoblue/src/bloc/bluetooth/bluetooth_provider.dart';

class DeviceInfo extends StatelessWidget {
  const DeviceInfo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BluetoothBloc bluetoothBloc = BluetoothProvider.of(context);

    if (bluetoothBloc.isConnected) {
      return Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            RaisedButton(
              child: Text("LED"),
              onPressed: () => changeLed(bluetoothBloc),
            ),
            RaisedButton(
              child: Text("LED"),
              onPressed: () => listenButton(bluetoothBloc),
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  void changeLed(BluetoothBloc bluetoothBloc) {
    bluetoothBloc.writeLedOn();
  }

  void listenButton(BluetoothBloc bluetoothBloc) {
    print(bluetoothBloc.services[2].characteristics[0].uuid.toString());
    print("listen button");
  }
}
