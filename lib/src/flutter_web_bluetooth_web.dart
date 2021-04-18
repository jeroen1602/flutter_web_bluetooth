import 'dart:async';

import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import '../native_web_bluetooth.dart';
import 'flutter_web_bluetooth_interface.dart';

class FlutterWebBluetooth extends FlutterWebBluetoothInterface {
  FlutterWebBluetooth._();

  static FlutterWebBluetooth? _instance;

  static FlutterWebBluetoothInterface get instance {
    _instance ??= FlutterWebBluetooth._();
    return _instance!;
  }

  ///
  /// Get if the bluetooth api is available in this browser. This will only
  /// check if the api is in the `navigator`. Not if anything is available.
  ///
  @override
  bool get isBluetoothApiSupported => Bluetooth.isBluetoothAPISupported();

  ///
  /// Get a [Stream] for the availability of a Bluetooth adapter.
  /// If a user inserts or removes a bluetooth adapter from their devices this
  /// stream will update.
  /// It will not necicerly update if the user enables/ disables a bleutooth
  /// adapter.
  ///
  /// Will return `Stream.value(false)` if [isBluetoothApiSupported] is false.
  ///
  @override
  Stream<bool> get isAvailable {
    return Bluetooth.onAvailabilitychanged();
  }

  Future<WebBluetoothDevice> requestDevice(RequestOptions options) async {
    // return Bluetooth.requestDevice(options);
    return null as WebBluetoothDevice;
  }

  static void registerWith(Registrar registrar) {
    // Do nothing
  }
}
