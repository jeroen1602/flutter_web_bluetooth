///
/// A wrapper around [js_web_bluetooth] to make it more Dart friendly.
/// Changes event listeners into [Stream]s and Javascript promises into
/// [Future]s.
///
// ignore: unnecessary_library_name
library flutter_web_bluetooth;

import "dart:async";
import "dart:collection";
import "dart:typed_data";

import "package:flutter_web_bluetooth/js_web_bluetooth.dart";
import "package:flutter_web_bluetooth/shared/web_behavior_subject.dart";
import "package:flutter_web_bluetooth/web/js/js.dart";
import "package:flutter_web_bluetooth/web_bluetooth_logger.dart";
import "package:meta/meta.dart";

part "advertisement_received_event.dart";
part "bluetooth_characteristic.dart";
part "bluetooth_characteristic_properties.dart";
part "bluetooth_default_uuids.dart";
part "bluetooth_default_manufacturer_identifiers.dart";
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
class FlutterWebBluetooth extends FlutterWebBluetoothInterface {
  FlutterWebBluetooth._();

  WebBehaviorSubject<AdvertisementReceivedEvent<AdvertisementBluetoothDevice>>?
      _advertisementSubject;

  void _startAdvertisementStream() {
    if (_advertisementSubject != null) {
      return;
    }

    _advertisementSubject = WebBehaviorSubject();
    Bluetooth.onAdvertisementReceived
        .listen((final BluetoothAdvertisementReceivedEvent event) {
      try {
        final device = AdvertisementBluetoothDevice(event.device);

        _advertisementSubject?.add(
            AdvertisementReceivedEvent<AdvertisementBluetoothDevice>(
                event, device));
      } catch (e, s) {
        if (e is Error) {
          _advertisementSubject?.controller.addError(e, s);
        } else {
          _advertisementSubject?.controller
              .addError(BrowserError(e.toString()), StackTrace.current);
        }
      }
    });
  }

  static FlutterWebBluetooth? _instance;

  ///
  /// Get an instance of the library. There will always only be one instance.
  ///
  static FlutterWebBluetoothInterface get instance =>
      _instance ??= FlutterWebBluetooth._();

  final WebBehaviorSubject<Set<BluetoothDevice>> _knownDevicesStream =
      WebBehaviorSubject.seeded(<BluetoothDevice>{});
  bool _checkedDevices = false;

  void _addKnownDevice(final BluetoothDevice device) {
    final set = _knownDevicesStream.value ?? <BluetoothDevice>{};
    set.add(device);
    _knownDevicesStream.add(set);
  }

  ///
  /// Get if the bluetooth api is available in this browser. This will only
  /// check if the api is in the `navigator`. Not if anything is available.
  /// This will return false if the website is not loaded in a
  /// [secure context](https://developer.mozilla.org/en-US/docs/Web/Security/Secure_Contexts).
  ///
  @override
  bool get isBluetoothApiSupported => Bluetooth.isBluetoothAPISupported();

  ///
  /// Get a [Stream] for the availability of a Bluetooth adapter.
  ///
  /// If a user inserts or removes a bluetooth adapter from their devices this
  /// stream will update.
  ///
  /// It will not necessarily update if the user enables/ disables a bluetooth
  /// adapter.
  ///
  /// Will return `Stream.value(false)` if [isBluetoothApiSupported] is false.
  ///
  @override
  Stream<bool> get isAvailable => Bluetooth.onAvailabilityChanged();

  ///
  /// Get a [Stream] with a [Set] of all devices paired in this browser session.
  /// If the browser supports [Bluetooth.getDevices], which none currently do
  /// unless a flag is used, then it will also return a list of all paired devices.
  ///
  /// Will return a [Stream] of an empty [Set] if [isAvailable] is false.
  ///
  /// A paired device is a device that the user has granted access to and the
  /// web app has once connected with.
  ///
  @override
  Stream<Set<BluetoothDevice>> get devices {
    if (!_checkedDevices) {
      //ignore: discarded_futures
      _getKnownDevices();
    }
    return _knownDevicesStream.stream;
  }

  ///
  /// Get the already known devices from the browser
  ///
  Future<void> _getKnownDevices({final bool shouldCheck = true}) async {
    _checkedDevices = true;
    if (shouldCheck && !(await Bluetooth.getAvailability())) {
      webBluetoothLogger.severe(
          "Could not get known devices because it's not available in this "
          "browser/ for this devices.",
          null,
          StackTrace.current);
      final set = _knownDevicesStream.value ?? <BluetoothDevice>{};
      set.clear();
      _knownDevicesStream.add(set);
      return;
    }
    final devices = await Bluetooth.getDevices();
    final devicesSet =
        Set<BluetoothDevice>.from(devices.map(BluetoothDevice.new));
    final set = _knownDevicesStream.value ?? <BluetoothDevice>{};
    set.addAll(devicesSet);
    _knownDevicesStream.add(set);
  }

  ///
  /// Request a [WebBluetoothDevice] from the browser (user). This will resolve
  /// into a single device even if the filter [options] (and environment) have
  /// multiple devices that fit that could be found.
  ///
  /// If you want multiple devices you will need to call this method multiple
  /// times, the user however can still click the already connected device twice.
  ///
  /// To bypass this library's adapter availability check, set [checkAvailability]
  /// to `false` (default is `true`). Errors from an unavailable adapter will then
  /// come directly from the underlying native `requestDevice` API call.
  ///
  /// - May throw [NativeAPINotImplementedError] if the native api is not
  /// implemented for this user agent (browser).
  ///
  /// - May throw [BluetoothAdapterNotAvailable] if there is no bluetooth adapter
  /// available.
  ///
  /// - May throw [UserCancelledDialogError] if the user cancels the pairing dialog.
  ///
  /// - May throw [DeviceNotFoundError] if the device could not be found with the
  /// current request filters.
  ///
  /// - May throw [MissingUserGestureError] if the method is not called from
  /// a user gesture.
  ///
  /// See: [RequestOptionsBuilder]
  ///
  @override
  Future<BluetoothDevice> requestDevice(
    final RequestOptionsBuilder options, {
    final bool checkAvailability = true,
  }) async {
    if (!isBluetoothApiSupported) {
      throw NativeAPINotImplementedError("requestDevice");
    }
    if (checkAvailability && !(await Bluetooth.getAvailability())) {
      throw BluetoothAdapterNotAvailable("requestDevice");
    }
    final convertedOptions = options.toRequestOptions();
    final device = await Bluetooth.requestDevice(convertedOptions);
    final webDevice = BluetoothDevice(device);
    _addKnownDevice(webDevice);
    return webDevice;
  }

  ///
  /// The [advertisements] stream emits an event with a
  /// [AdvertisementBluetoothDevice]. This device doesn't have a gatt server and
  /// can thus not do everything you may want.
  ///
  /// This method requests the user to pair to the device.
  ///
  /// All this method does is constructs a [RequestOptionsBuilder] using
  /// information from [device], [requiredServices], and [optionalServices] and
  /// then calls [requestDevice].
  ///
  /// There is no guarantee that the user only sees 1 option in their pair
  /// dialog and thus there is no guarantee that the user pairs the exact same
  /// device as the one given.
  ///
  /// May throw the same exceptions as [requestDevice].
  ///
  /// See: [requestDevice]
  ///
  @override
  Future<BluetoothDevice> requestAdvertisementDevice(
      final AdvertisementBluetoothDevice device,
      {final List<String> requiredServices = const [],
      final List<String> optionalServices = const []}) async {
    final RequestOptionsBuilder options =
        _createRequestOptionsFromAdvertisementDevice(
            device, requiredServices, optionalServices);
    return requestDevice(options);
  }

  ///
  /// Create request options for an advertisement device.
  ///
  RequestOptionsBuilder _createRequestOptionsFromAdvertisementDevice(
      final AdvertisementBluetoothDevice device,
      final List<String> requiredServices,
      final List<String> optionalServices) {
    if (device.name != null || requiredServices.isNotEmpty) {
      return RequestOptionsBuilder([
        RequestFilterBuilder(
            name: device.name,
            services: requiredServices.isEmpty ? null : requiredServices),
      ], optionalServices: optionalServices.isEmpty ? null : optionalServices);
    } else {
      webBluetoothLogger.warning(
          "Requesting access to an advertisement device (id: ${device.id}) "
          "without identifying information (either a name or required "
          "services), so `acceptAllDevices` is used.");
      return RequestOptionsBuilder.acceptAllDevices(
          optionalServices: optionalServices.isEmpty ? null : optionalServices);
    }
  }

  ///
  /// Check to see if the current browser has the [requestLEScan] method.
  ///
  /// Use this to avoid the [NativeAPINotImplementedError].
  ///
  @override
  bool get hasRequestLEScan => Bluetooth.hasRequestLEScan();

  ///
  /// Request the user to start scanning for Bluetooth LE devices in the
  /// area. Not every browser supports this method yet so check it using
  /// [hasRequestLEScan]. However even if the browser supports it, the [Future]
  /// may never complete on browsers. This has been the case for Chrome on linux
  /// and windows even with the correct flag enabled. Chrome on Android does
  /// seem to work. Add a [Future.timeout] to combat this.
  ///
  /// The devices found through this are emitted using the [advertisements]
  /// stream. The devices emitted through this stream aren't [BluetoothDevice]s
  /// but [AdvertisementBluetoothDevice]s instead as they don't have a
  /// gatt server.
  ///
  /// It will only emit devices that match the [options] so it could happen
  /// that there are no devices in range while the scan is running.
  /// See [LEScanOptionsBuilder] for details on the options.
  ///
  /// Once a scan is running (and there were no errors) it can be stopped by
  /// calling [BluetoothLEScan.stop] on the returned object from the [Future].
  /// If this object doesn't get saved then there is no way to stop the scan,
  /// it should be able to start multiple scans with different scan options.
  ///
  /// - May throw [UserCancelledDialogError] if the user cancelled the dialog.
  ///
  /// - May throw [NativeAPINotImplementedError] if the browser/ user agent
  /// doesn't support this method. This may still be thrown even if
  /// [hasRequestLEScan] is checked first.
  ///
  /// - May throw [StateError] for any state error that the method may throw.
  ///
  /// - May throw [PolicyError] if Bluetooth has been disabled by an
  /// administrator via a policy.
  ///
  /// - May throw [PermissionError] if the user has disallowed the permission.
  ///
  /// - May throw [BluetoothAdapterNotAvailable] if there is no Bluetooth
  /// adapter available.
  ///
  /// - May throw [MissingUserGestureError] if the method is not called from
  /// a user gesture.
  ///
  /// - May throw [BrowserError] for every other browser error.
  ///
  @override
  Future<BluetoothLEScan> requestLEScan(
      final LEScanOptionsBuilder options) async {
    if (!hasRequestLEScan) {
      throw NativeAPINotImplementedError("requestLEScan");
    }
    if (!(await Bluetooth.getAvailability())) {
      throw BluetoothAdapterNotAvailable("requestLEScan");
    }
    _startAdvertisementStream();
    try {
      final convertedOptions = options.toRequestOptions();
      return await Bluetooth.requestLEScan(convertedOptions);
    } on BrowserError catch (e) {
      if (e.message.startsWith("InvalidStateError") ||
          e.message.startsWith("NotFoundError")) {
        throw BluetoothAdapterNotAvailable("requestLEScan");
      }
      rethrow;
    }
  }

  ///
  /// the [advertisements] stream emits [AdvertisementReceivedEvent]s
  /// for devices found through [requestLEScan].
  ///
  /// The device that is in this event is a [AdvertisementBluetoothDevice] this
  /// bluetooth device lacks a gatt server and can thus not communicate with
  /// any [BluetoothCharacteristic]s. Use [requestAdvertisementDevice] to get
  /// a [BluetoothDevice] based on the [AdvertisementBluetoothDevice].
  ///
  /// Even if the browser doesn't support [requestLEScan] this stream will not
  /// throw an [Error]. It will just never emit any events since you can't start
  /// a scan.
  ///
  @override
  Stream<AdvertisementReceivedEvent<AdvertisementBluetoothDevice>>
      get advertisements {
    _startAdvertisementStream();
    return _advertisementSubject!.stream;
  }

  ///
  /// The [devices] stream has a [Set] of [BluetoothDevice]s. If the
  /// [BluetoothDevice.forget] method is used then it should also be removed
  /// from the [devices] stream. This method takes in a [BluetoothDevice] to
  /// be removed from this stream.
  ///
  @override
  Future<void> _forgetDevice(final BluetoothDevice device) async {
    final set = _knownDevicesStream.value ?? <BluetoothDevice>{};
    if (set.remove(device)) {
      _knownDevicesStream.add(set);
    }
  }
}
