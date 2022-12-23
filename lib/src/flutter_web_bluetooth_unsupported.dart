///
/// A wrapper around [js_web_bluetooth] to make it more Dart friendly.
/// Changes event listeners into [Stream]s and Javascript promises into
/// [Future]s.
///
/// See:
/// [flutter_web_bluetooth_web] file for the actual web implementation.
///
library flutter_web_bluetooth;

import "dart:async";
import "dart:collection";
import "dart:typed_data";

import "package:flutter_web_bluetooth/js_web_bluetooth.dart";
import "package:flutter_web_bluetooth/shared/web_behavior_subject.dart";
import "package:flutter_web_bluetooth/web_bluetooth_logger.dart";
import "package:meta/meta.dart";

part "advertisement_received_event.dart";
part "bluetooth_characteristic.dart";
part "bluetooth_characteristic_properties.dart";
part "bluetooth_default_uuids.dart";
part "bluetooth_descriptor.dart";
part "bluetooth_device.dart";
part "bluetooth_service.dart";
part "errors/bluetooth_adapter_not_available.dart";
part "errors/network_error.dart";
part "errors/not_found_error.dart";
part "errors/not_supported_error.dart";
part "errors/security_error.dart";
part "flutter_web_bluetooth_interface.dart";
part "le_scan_options_builder.dart";
part "request_options_builder.dart";

///
/// The main class to request devices from on the web.
///
/// Just get an instance using [instance] and request a device using [requestDevice].
///
/// **Note:** this is the unsupported variant that is exposed in io builds,
/// check the web version where the functions actually work!
///
class FlutterWebBluetooth extends FlutterWebBluetoothInterface {
  FlutterWebBluetooth._() {
    webBluetoothLogger.warning(
        "WARNING! initialized an instance of FlutterWebBluetooth on a non web platform!",
        null,
        StackTrace.current);
  }

  static FlutterWebBluetooth? _instance;

  ///
  /// Get an instance of the library. There will always only be one instance.
  ///
  /// **Note:** this is the unsupported variant that is exposed in io builds,
  /// check the web version where the functions actually work!
  ///
  static FlutterWebBluetoothInterface get instance =>
      _instance ??= FlutterWebBluetooth._();

  @override
  final bool isBluetoothApiSupported = false;

  @override
  Stream<bool> get isAvailable => Stream.value(false);

  @override
  Stream<Set<BluetoothDevice>> get devices => Stream.value(<BluetoothDevice>{});

  @override
  @alwaysThrows
  Future<BluetoothDevice> requestDevice(final RequestOptionsBuilder options) {
    throw NativeAPINotImplementedError("requestDevice");
  }

  @override
  @alwaysThrows
  Future<BluetoothDevice> requestAdvertisementDevice(
      final AdvertisementBluetoothDevice device,
      {final List<String> requiredServices = const [],
      final List<String> optionalServices = const []}) {
    throw NativeAPINotImplementedError("requestAdvertisementDevice");
  }

  @override
  final bool hasRequestLEScan = false;

  @override
  @alwaysThrows
  Future<BluetoothLEScan> requestLEScan(final LEScanOptionsBuilder options) {
    throw NativeAPINotImplementedError("requestLEScan");
  }

  @override
  Stream<AdvertisementReceivedEvent<AdvertisementBluetoothDevice>>
      get advertisements => const Stream.empty();

  @override
  Future<void> _forgetDevice(final BluetoothDevice device) async {
    // Do nothing
  }
}
