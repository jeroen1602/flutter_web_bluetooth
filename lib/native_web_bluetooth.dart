@JS('navigator')
library native_web_bluetooth;

import 'dart:js_util' as JSUtil;
import 'package:flutter_web_bluetooth/errors/NativeAPINotImplementedError.dart';

import 'package:flutter/foundation.dart';
import 'package:js/js.dart';

part 'native/NativeBluetoothDevice.dart';

part 'native/NativeBluetoothRemoteGATTServer.dart';

part 'native/NativeBluetoothRemoteGATTService.dart';

part 'native/NativeBluetoothRemoteGATTCharacteristic.dart';

part 'native/NativeBluetoothCharacteristicProperties.dart';

part 'native/NativeBluetoothRemoteGATTDescriptor.dart';

part 'native/bluetooth.dart';