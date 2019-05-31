import 'package:flutter/material.dart';
import './bluetooth_bloc.dart';
export './bluetooth_bloc.dart';

const int secondsInMinutes = 60;

class BluetoothProvider extends InheritedWidget {
  final BluetoothBloc bloc;

  BluetoothProvider({Key key, Widget child, this.bloc})
      : super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static BluetoothBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(BluetoothProvider)
            as BluetoothProvider)
        .bloc;
  }
}
