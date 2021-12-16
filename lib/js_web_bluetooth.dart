///
/// A library to make the Javascript web bluetooth api available in Dart.
/// It's a direct conversion of the original API without any helpers.
///
@JS('window')
library js_web_bluetooth;

import 'dart:typed_data';

import 'package:rxdart/rxdart.dart';

import 'web/js/js_utils.dart';
import 'web/js/js.dart';

part 'web/native_bluetooth_remote_gatt_server.dart';

part 'web/web_bluetooth_characteristic_properties.dart';

part 'web/web_bluetooth_converters.dart';

part 'web/web_bluetooth_device.dart';

part 'web/web_bluetooth_remote_gatt_characteristic.dart';

part 'web/web_bluetooth_remote_gatt_descriptor.dart';

part 'web/web_bluetooth_remote_gatt_service.dart';

part 'web/bluetooth.dart';

part 'web/errors/device_not_found_error.dart';

part 'web/errors/native_api_not_implemented_error.dart';

part 'web/errors/user_cancelled_dialog_error.dart';

// ignore: non_constant_identifier_names
JSUtilsInterface _JSUtil = JSUtils();

///
/// This method is meant for testing!
///
void testingSetJSUtils(JSUtilsInterface utils) {
  _JSUtil = utils;
}
