import 'dart:async';

import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'native_web_bluetooth.dart';
import 'src/flutter_web_bluetooth_interface.dart';

class FlutterWebBluetooth extends FlutterWebBluetoothInterface {
  FlutterWebBluetooth._();

  static FlutterWebBluetooth? _instance;

  static FlutterWebBluetoothInterface get instance {
    final instance = _instance ?? FlutterWebBluetooth._();
    if (_instance == null) {
      _instance = instance;
    }
    return instance;
  }

  @override
  bool get isBluetoothSupported {
    return Bluetooth.isBluetoothSupported();
  }

  @override
  Future<bool> get isAvailable {
    return Bluetooth.getAvailability();
  }

  Future<NativeBluetoothDevice> requestDevice(RequestOptions options) {
    return Bluetooth.requestDevice(options);
  }

  static void registerWith(Registrar registrar) {
    // Do nothing
  }
}
