@JS('window')
library native_web_bluetooth;

import 'package:flutter/foundation.dart';
import 'package:flutter_web_bluetooth/errors/NativeAPINotImplementedError.dart';

import 'native/JSUtils.dart';
import 'native/JSUtilsInterface.dart';
import 'native/js.dart';

part 'native/NativeBluetoothCharacteristicProperties.dart';

part 'native/NativeBluetoothDevice.dart';

part 'native/NativeBluetoothRemoteGATTCharacteristic.dart';

part 'native/NativeBluetoothRemoteGATTDescriptor.dart';

part 'native/NativeBluetoothRemoteGATTServer.dart';

part 'native/NativeBluetoothRemoteGATTService.dart';

part 'native/bluetooth.dart';

JSUtilsInterface _JSUtil = JSUtils();

@visibleForTesting
void setJSUtils(JSUtilsInterface utils) {
  _JSUtil = utils;
}
