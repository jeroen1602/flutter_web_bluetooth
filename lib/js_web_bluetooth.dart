@JS('window')
library js_web_bluetooth;

import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

import 'web/js/JSUtils.dart';
import 'web/js/js.dart';

part 'web/NativeBluetoothCharacteristicProperties.dart';

part 'web/NativeBluetoothDevice.dart';

part 'web/NativeBluetoothRemoteGATTCharacteristic.dart';

part 'web/NativeBluetoothRemoteGATTDescriptor.dart';

part 'web/NativeBluetoothRemoteGATTServer.dart';

part 'web/NativeBluetoothRemoteGATTService.dart';

part 'web/bluetooth.dart';

part 'web/errors/DeviceNotFoundError.dart';

part 'web/errors/NativeAPINotImplementedError.dart';

part 'web/errors/UserCancelledDialogError.dart';

JSUtilsInterface _JSUtil = JSUtils();

@visibleForTesting
void setJSUtils(JSUtilsInterface utils) {
  _JSUtil = utils;
}
