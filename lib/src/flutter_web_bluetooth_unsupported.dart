library flutter_web_bluetooth;

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_web_bluetooth/js_web_bluetooth.dart';
import 'package:rxdart/rxdart.dart';

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

  ///
  /// Will always return a [Stream] with an empty [Set].
  ///
  @override
  Stream<Set<BluetoothDevice>> get devices => Stream.value(Set());

  ///
  /// Will always throw a [NativeAPINotImplementedError].
  ///
  @override
  Future<BluetoothDevice> requestDevice(RequestOptionsBuilder options) {
    throw NativeAPINotImplementedError('requestDevice');
  }
}
