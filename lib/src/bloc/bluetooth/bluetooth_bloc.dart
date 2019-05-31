import 'dart:async';
import 'package:flutter_blue/flutter_blue.dart';
import '../../app_constants.dart';

class BluetoothBloc {
  // flutter_blue
  FlutterBlue flutterBlue;
  // State
  StreamSubscription stateSubscription;
  BluetoothState bluetoothState;
  // Scanning
  StreamSubscription scanSubscription;
  Map<DeviceIdentifier, ScanResult> scanResults;
  bool isScanning = false;
  // Device
  BluetoothDevice device;
  bool get isConnected => (device != null);
  StreamSubscription deviceConnection;
  StreamSubscription deviceStateSubscription;
  List<BluetoothService> services;
  Map<Guid, StreamSubscription> valueChangedSubscriptions;
  BluetoothDeviceState deviceState;
  // characteristic states
  bool ledState = false;

  BluetoothBloc() {
    flutterBlue = FlutterBlue.instance;
    bluetoothState = BluetoothState.unknown;
    scanResults = new Map();
    services = new List();
    valueChangedSubscriptions = {};
    deviceState = BluetoothDeviceState.disconnected;
  }

  dispose() {
    stateSubscription?.cancel();
    stateSubscription = null;
    scanSubscription?.cancel();
    scanSubscription = null;
    deviceConnection?.cancel();
    deviceConnection = null;
    deviceStateSubscription?.cancel();
    deviceStateSubscription = null;
  }

  readCharacteristic(BluetoothCharacteristic c) async {
    await device.readCharacteristic(c);
  }

  readDescriptor(BluetoothDescriptor d) async {
    await device.readDescriptor(d);
  }

  writeDescriptor(BluetoothDescriptor d) async {
    await device.writeDescriptor(d, [0x12, 0x34]);
  }

  writeLedOn() async {
    BluetoothService ledButtonService = services.firstWhere(
      (s) => s.uuid.toString().contains(ledButtonServiceUuid),
    );
    BluetoothCharacteristic ledCharacteristic =
        ledButtonService.characteristics.firstWhere(
      (c) => c.uuid.toString().contains(ledCharacteristicUuid),
    );
    await writeCharacteristic(ledCharacteristic);
  }

  writeCharacteristic(BluetoothCharacteristic c) async {
    await device.writeCharacteristic(c, [ledState ? 1 : 0],
        type: CharacteristicWriteType.withResponse);
    ledState = !ledState;
  }
}
