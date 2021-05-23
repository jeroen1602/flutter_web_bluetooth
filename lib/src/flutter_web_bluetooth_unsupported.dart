/// @nodoc
library flutter_web_bluetooth;

import 'dart:async';
import 'dart:typed_data';

import 'package:flutter_web_bluetooth/js_web_bluetooth.dart';
import 'package:rxdart/rxdart.dart';

part 'bluetooth_characteristic.dart';

part 'bluetooth_characteristic_properties.dart';

part 'bluetooth_default_uuids.dart';

part 'bluetooth_descriptor.dart';

part 'bluetooth_device.dart';

part 'bluetooth_service.dart';

part 'errors/BluetoothAdapterNotAvailable.dart';

part 'errors/NetworkError.dart';

part 'errors/NotFoundError.dart';

part 'errors/NotSupportedError.dart';

part 'errors/SecurityError.dart';

part 'flutter_web_bluetooth_interface.dart';

part 'request_options_builder.dart';

/// @nodoc
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
