library flutter_web_bluetooth;

import 'package:flutter/foundation.dart';
import 'package:flutter_web_bluetooth/native_web_bluetooth.dart';

part 'bluetooth_device.dart';

part 'errors/BluetoothAdapterNotAvailable.dart';

part 'flutter_web_bluetooth_interface.dart';

part 'request_options_builder.dart';

class FlutterWebBluetooth extends FlutterWebBluetoothInterface {
  FlutterWebBluetooth._() {
    print(
        'WARNING! initialized an instance of FlutterWebBluetooth on a non web platform!');
  }

  static FlutterWebBluetooth? _instance;

  static FlutterWebBluetoothInterface get instance {
    _instance ??= FlutterWebBluetooth._();
    return _instance!;
  }

  @override
  bool get isBluetoothApiSupported => false;

  @override
  Stream<bool> get isAvailable => Stream.value(false);

  @override
  Future<WebBluetoothDevice> requestDevice(RequestOptionsBuilder options) {
    throw StateError('Web Bluetooth is not available for this device!');
  }
}
