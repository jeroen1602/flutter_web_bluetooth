import 'dart:async';

// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:js' as js;

import 'flutter_web_bluetooth_interface.dart';
import 'native_web_bluetooth.dart';

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
    final result = js.context.hasProperty('Bluetooth');
    if (result is bool) {
      return result;
    }
    html.window.console.log('Bluetooth is not supported in this browser');
    return false;
  }

  @override
  Future<bool> get isAvailable async {
    if (!isBluetoothSupported) {
      return false;
    }

    final available = await Bluetooth.getAvailability();
    return available;
  }

  Future<NativeBluetoothDevice> requestDevice(RequestOptions options) {
    return Bluetooth.requestDevice(options);
  }
}
