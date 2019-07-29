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
    disconnect();
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

  disconnect() {
    // Remove all value changed listeners
    valueChangedSubscriptions.forEach((uuid, sub) => sub.cancel());
    valueChangedSubscriptions.clear();
    deviceStateSubscription?.cancel();
    deviceStateSubscription = null;
    deviceConnection?.cancel();
    deviceConnection = null;
    device = null;
  }

  readCharacteristic(BluetoothCharacteristic c) async {
    await device.readCharacteristic(c);
  }

  readDescriptor(BluetoothDescriptor d) async {
    await device.readDescriptor(d);
  }

  writeDescriptor(BluetoothDescriptor d, int value) async {
    await device.writeDescriptor(d, [value]);
  }

  writeCharacteristic(BluetoothCharacteristic c, int value) async {
    await device.writeCharacteristic(c, [value],
        type: CharacteristicWriteType.withResponse);
  }

  setNotification(BluetoothCharacteristic charact, Function func) async {
    if (charact.isNotifying) {
      await device.setNotifyValue(charact, false);
      // Cancel subscription
      valueChangedSubscriptions[charact.uuid]?.cancel();
      valueChangedSubscriptions.remove(charact.uuid);
    } else {
      await device.setNotifyValue(charact, true);
      // ignore: cancel_subscriptions
      final sub = device.onValueChanged(charact).listen(
            (val) => func(val),
          );
      // Add to map
      valueChangedSubscriptions[charact.uuid] = sub;
    }
  }

  writeLedOn() async {
    BluetoothService ledButtonService = services.firstWhere(
      (s) => s.uuid.toString().contains(ledButtonServiceUuid),
    );
    BluetoothCharacteristic ledCharacteristic =
        ledButtonService.characteristics.firstWhere(
      (c) => c.uuid.toString().contains(ledCharacteristicUuid),
    );
    await toogleLed(ledCharacteristic);
  }

  toogleLed(BluetoothCharacteristic c) async {
    await writeCharacteristic(c, ledState ? 1 : 0);
    ledState = !ledState;
  }

  setNotificationButton(Function func) {
    BluetoothService ledButtonService = services.firstWhere(
      (s) => s.uuid.toString().contains(ledButtonServiceUuid),
    );
    BluetoothCharacteristic buttonCharacteristic =
        ledButtonService.characteristics.firstWhere(
      (c) => c.uuid.toString().contains(buttonCharacteristicUuid),
    );
    setNotification(buttonCharacteristic, func);
  }
}
