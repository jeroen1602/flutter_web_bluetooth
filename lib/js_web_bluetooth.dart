@JS('window')
library js_web_bluetooth;

import 'dart:typed_data';

import 'package:rxdart/rxdart.dart';

import 'web/js/JSUtils.dart';
import 'web/js/js.dart';

part 'web/NativeBluetoothRemoteGATTServer.dart';

part 'web/WebBluetoothCharacteristicProperties.dart';

part 'web/WebBluetoothConverters.dart';

part 'web/WebBluetoothDevice.dart';

part 'web/WebBluetoothRemoteGATTCharacteristic.dart';

part 'web/WebBluetoothRemoteGATTDescriptor.dart';

part 'web/WebBluetoothRemoteGATTService.dart';

part 'web/bluetooth.dart';

part 'web/errors/DeviceNotFoundError.dart';

part 'web/errors/NativeAPINotImplementedError.dart';

part 'web/errors/UserCancelledDialogError.dart';

JSUtilsInterface _JSUtil = JSUtils();

///
/// This method is meant for testing!
///
void testingSetJSUtils(JSUtilsInterface utils) {
  _JSUtil = utils;
}
