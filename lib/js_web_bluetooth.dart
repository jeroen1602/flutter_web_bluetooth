///
/// A library to make the Javascript web bluetooth api available in Dart.
/// It's a direct conversion of the original API without any helpers.
/// It is recommended that you use [flutter_web_bluetooth] instead.
///
@JS('window')
library js_web_bluetooth;

import 'dart:collection';
import 'dart:typed_data';

import 'package:meta/meta.dart';

import 'shared/web_behavior_subject.dart';
import 'web/js/js.dart';
import 'web/js/js_utils.dart';
import 'web_bluetooth_logger.dart';

part 'web/bluetooth.dart';

part 'web/errors/browser_error.dart';

part 'web/errors/device_not_found_error.dart';

part 'web/errors/native_api_not_implemented_error.dart';

part 'web/errors/user_cancelled_dialog_error.dart';

part 'web/js/abort_controller.dart';

part 'web/native_bluetooth_remote_gatt_server.dart';

part 'web/web_advertisement_received_event.dart';

part 'web/web_bluetooth_characteristic_properties.dart';

part 'web/web_bluetooth_converters.dart';

part 'web/web_bluetooth_device.dart';

part 'web/web_bluetooth_remote_gatt_characteristic.dart';

part 'web/web_bluetooth_remote_gatt_descriptor.dart';

part 'web/web_bluetooth_remote_gatt_service.dart';

// ignore: non_constant_identifier_names
JSUtilsInterface _JSUtil = JSUtils();

///
/// Override the js utils implementation.
///
/// This is meant for testing to fake the browser context for a mock context.
///
/// If you are replacing the [JSUtils] used then you may also want to change
/// the [setNativeBluetooth].
///
@visibleForTesting
void testingSetJSUtils(JSUtilsInterface utils) {
  _JSUtil = utils;
}
