import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import '../widgets/bluetooth/characteristic_tile.dart';
import '../widgets/bluetooth/descriptor_tile.dart';
import '../widgets/bluetooth/scan_result_tile.dart';
import '../widgets/bluetooth/service_tile.dart';
import '../bloc/bluetooth/bluetooth_provider.dart';

class BluetoothDevicesList extends StatefulWidget {
  BluetoothDevicesList({Key key}) : super(key: key);

  _BluetoothDevicesListState createState() => _BluetoothDevicesListState();
}

class _BluetoothDevicesListState extends State<BluetoothDevicesList> {
  bool blocInitialised = false;
  BluetoothBloc _b;

  @override
  Widget build(BuildContext context) {
    _b = BluetoothProvider.of(context);

    if (!blocInitialised) {
      blocInitialiser();
      blocInitialised = true;
    }

    var tiles = List<Widget>();
    if (_b.bluetoothState != BluetoothState.on) {
      tiles.add(_buildAlertTile());
    }
    if (_b.isConnected) {
      tiles.add(_buildDeviceStateTile());
      tiles.addAll(_buildServiceTiles());
    } else {
      tiles.addAll(_buildScanResultTiles());
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('FlutterBlue', style: TextStyle(fontSize: 16)),
        actions: _buildActionButtons(),
      ),
      body: new Stack(
        children: <Widget>[
          (_b.isScanning) ? _buildProgressBarTile() : new Container(),
          new ListView(
            children: tiles,
          )
        ],
      ),
      floatingActionButton: _buildScanningButton(),
    );
  }

  void blocInitialiser() {
    // Immediately get the state of FlutterBlue
    _b.flutterBlue.state.then((s) {
      setState(() {
        _b.bluetoothState = s;
      });
    });
    // Subscribe to state changes
    _b.stateSubscription = _b.flutterBlue.onStateChanged().listen((s) {
      setState(() {
        _b.bluetoothState = s;
      });
    });
  }

  _buildActionButtons() {
    if (_b.isConnected) {
      return <Widget>[
        new IconButton(
          icon: const Icon(Icons.cancel),
          onPressed: () => _disconnect(),
        )
      ];
    }
  }

  Widget _buildAlertTile() {
    return new Container(
      color: Colors.redAccent,
      child: new ListTile(
        title: new Text(
          'Bluetooth adapter is ${_b.bluetoothState.toString().substring(15)}',
          style: Theme.of(context).primaryTextTheme.subhead,
        ),
        trailing: new Icon(
          Icons.error,
          color: Theme.of(context).primaryTextTheme.subhead.color,
        ),
      ),
    );
  }

  _buildScanResultTiles() {
    return _b.scanResults.values
        .map((r) => ScanResultTile(
            result: r,
            onTap: () {
              _connect(r.device);
            }))
        .toList();
  }

  _buildScanningButton() {
    if (_b.isConnected || _b.bluetoothState != BluetoothState.on) {
      return null;
    }
    if (_b.isScanning) {
      return new FloatingActionButton(
        child: new Icon(Icons.stop),
        onPressed: _stopScan,
        backgroundColor: Colors.red,
      );
    } else {
      return new FloatingActionButton(
          child: new Icon(Icons.search), onPressed: _startScan);
    }
  }

  _startScan() {
    _b.scanResults.clear();
    _b.scanSubscription = _b.flutterBlue
        .scan(timeout: const Duration(seconds: 5))
        .listen((scanResult) {
      setState(
        () {
          _b.scanResults[scanResult.device.id] = scanResult;
        },
      );
    }, onDone: _stopScan);

    setState(() {
      _b.isScanning = true;
    });
  }

  _stopScan() {
    _b.scanSubscription?.cancel();
    _b.scanSubscription = null;
    setState(() {
      _b.isScanning = false;
    });
  }

  _connect(BluetoothDevice d) async {
    _b.device = d;
    // Connect to _b.device
    _b.deviceConnection = _b.flutterBlue
        .connect(_b.device, timeout: const Duration(seconds: 4))
        .listen(
          null,
          onDone: _disconnect,
        );

    // Update the connection state immediately
    _b.device.state.then((s) {
      setState(() {
        _b.deviceState = s;
      });
    });

    // Subscribe to connection changes
    _b.deviceStateSubscription = _b.device.onStateChanged().listen((s) {
      setState(() {
        _b.deviceState = s;
      });
      if (s == BluetoothDeviceState.connected) {
        _b.device.discoverServices().then((s) {
          setState(() {
            _b.services = s;
          });
        });
      }
    });
  }

  _disconnect() {
    // Remove all value changed listeners
    _b.valueChangedSubscriptions.forEach((uuid, sub) => sub.cancel());
    _b.valueChangedSubscriptions.clear();
    _b.deviceStateSubscription?.cancel();
    _b.deviceStateSubscription = null;
    _b.deviceConnection?.cancel();
    _b.deviceConnection = null;
    setState(() {
      _b.device = null;
    });
  }

  _buildDeviceStateTile() {
    return new ListTile(
        leading: (_b.deviceState == BluetoothDeviceState.connected)
            ? const Icon(Icons.bluetooth_connected)
            : const Icon(Icons.bluetooth_disabled),
        title:
            new Text('Device is ${_b.deviceState.toString().split('.')[1]}.'),
        subtitle: new Text('${_b.device.id}'),
        trailing: new IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () => _refreshDeviceState(_b.device),
          color: Theme.of(context).iconTheme.color.withOpacity(0.5),
        ));
  }

  _refreshDeviceState(BluetoothDevice d) async {
    var state = await d.state;
    setState(() {
      _b.deviceState = state;
      print('State refreshed: $_b.deviceState');
    });
  }

  _buildProgressBarTile() {
    return new LinearProgressIndicator();
  }

  List<Widget> _buildServiceTiles() {
    return _b.services
        .map(
          (s) => new ServiceTile(
                service: s,
                characteristicTiles: s.characteristics
                    .map(
                      (c) => new CharacteristicTile(
                            characteristic: c,
                            onReadPressed: () => _readCharacteristic(c),
                            onWritePressed: () => _writeCharacteristic(c),
                            onNotificationPressed: () => _setNotification(c),
                            descriptorTiles: c.descriptors
                                .map(
                                  (d) => new DescriptorTile(
                                        descriptor: d,
                                        onReadPressed: () => _readDescriptor(d),
                                        onWritePressed: () =>
                                            _writeDescriptor(d),
                                      ),
                                )
                                .toList(),
                          ),
                    )
                    .toList(),
              ),
        )
        .toList();
  }

  _readCharacteristic(BluetoothCharacteristic c) async {
    await _b.readCharacteristic(c);
    setState(() {});
  }

  _writeCharacteristic(BluetoothCharacteristic c) async {
    await _b.writeCharacteristic(c);
    setState(() {});
  }

  _readDescriptor(BluetoothDescriptor d) async {
    await _b.readDescriptor(d);
    setState(() {});
  }

  _writeDescriptor(BluetoothDescriptor d) async {
    await _b.writeDescriptor(d);
    setState(() {});
  }

  _setNotification(BluetoothCharacteristic c) async {
    if (c.isNotifying) {
      await _b.device.setNotifyValue(c, false);
      // Cancel subscription
      _b.valueChangedSubscriptions[c.uuid]?.cancel();
      _b.valueChangedSubscriptions.remove(c.uuid);
    } else {
      await _b.device.setNotifyValue(c, true);
      // ignore: cancel_subscriptions
      final sub = _b.device.onValueChanged(c).listen((d) {
        setState(() {
          print('onValueChanged $d');
        });
      });
      // Add to map
      _b.valueChangedSubscriptions[c.uuid] = sub;
    }
    setState(() {});
  }
}
