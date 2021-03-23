import 'package:flutter_web_bluetooth/native_web_bluetooth.dart';

import 'flutter_web_bluetooth_interface.dart';

class FlutterWebBluetooth extends FlutterWebBluetoothInterface {
  FlutterWebBluetooth._() {
    print(
        'WARNING! initialized an instance of FlutterWebBluetooth on a non web platform!');
  }

  static FlutterWebBluetooth? _instance;

  static FlutterWebBluetoothInterface get instance {
    final instance = _instance ?? FlutterWebBluetooth._();
    if (_instance == null) {
      _instance = instance;
    }
    return instance;
  }

  @override
  Future<bool> get isAvailable => Future.value(false);

  @override
  bool get isBluetoothSupported => false;

  @override
  Future<NativeBluetoothDevice> requestDevice(RequestOptions options) {
    throw UnimplementedError();
  }
}
