import 'dart:async';
import 'package:flutter_blue/flutter_blue.dart';

class BluetoothBloc {
  FlutterBlue _flutterBlue = FlutterBlue.instance;

  /// State
  StreamSubscription _stateSubscription;
  BluetoothState bluetoothState = BluetoothState.unknown;

  /// Scanning
  StreamSubscription _scanSubscription;
  Map<DeviceIdentifier, ScanResult> scanResults = new Map();
  bool isScanning = false;

  /// Device
  BluetoothDevice device;
  bool get isConnected => (device != null);
  StreamSubscription deviceConnection;
  StreamSubscription deviceStateSubscription;
  List<BluetoothService> services = new List();
  Map<Guid, StreamSubscription> valueChangedSubscriptions = {};
  BluetoothDeviceState deviceState = BluetoothDeviceState.disconnected;
}
