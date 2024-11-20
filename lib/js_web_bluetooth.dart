///
/// A library to make the Javascript web bluetooth api available in Dart.
/// It's a direct conversion of the original API without any helpers.
/// It is recommended that you use [flutter_web_bluetooth] instead.
///
library;

import "dart:async";
import "dart:collection";
import "dart:typed_data";

import "package:flutter_web_bluetooth/flutter_web_bluetooth.dart";
import "package:flutter_web_bluetooth/shared/web_behavior_subject.dart";
import "package:flutter_web_bluetooth/web/js/js.dart";
import "package:flutter_web_bluetooth/web/js/js_map.dart";
import "package:meta/meta.dart";

part "web/bluetooth.dart";
part "web/errors/browser_error.dart";
part "web/errors/device_not_found_error.dart";
part "web/errors/missing_user_gesture_error.dart";
part "web/errors/native_api_not_implemented_error.dart";
part "web/errors/permission_error.dart";
part "web/errors/policy_error.dart";
part "web/errors/user_cancelled_dialog_error.dart";
part "web/events/events.dart";
part "web/events/providers.dart";
part "web/native_bluetooth_remote_gatt_server.dart";
part "web/events/web_advertisement_received_event.dart";
part "web/events/web_bluetooth_value_event.dart";
part "web/web_bluetooth_characteristic_properties.dart";
part "web/web_bluetooth_device.dart";
part "web/web_bluetooth_le_scan.dart";
part "web/web_bluetooth_le_scan_options.dart";
part "web/web_bluetooth_navigator.dart";
part "web/web_bluetooth_remote_gatt_characteristic.dart";
part "web/web_bluetooth_remote_gatt_descriptor.dart";
part "web/web_bluetooth_remote_gatt_service.dart";
part "web/web_bluetooth_request_options.dart";
part "web/web_bluetooth_scan_filters.dart";
