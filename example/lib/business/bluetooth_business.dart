import "dart:async";
import "dart:collection";

import "package:flutter/foundation.dart";
import "package:flutter_web_bluetooth/flutter_web_bluetooth.dart";
import "package:flutter_web_bluetooth/js_web_bluetooth.dart";
import "package:flutter_web_bluetooth_example/model/main_page_device.dart";
import "package:rxdart/rxdart.dart";

enum RequestDeviceState {
  ok,
  notSupported,
  adapterNotAvailable,
  userCancelled,
  deviceNotFound,
  other,
}

enum RequestLEState {
  ok,
  notSupported,
  apiNotSupported,
  adapterNotAvailable,
  userCancelled,
  deviceNotFound,
  permissionError,
  timeoutException,
  other,
  stopped,
}

class RequestAdvertisementDeviceState {
  RequestAdvertisementDeviceState(this.state, {this.device});

  final RequestDeviceState state;
  final BluetoothDevice? device;
}

class BluetoothBusiness {
  BluetoothBusiness._();

  static BluetoothLEScan? _currentScan;

  static Future<RequestDeviceState> requestDevice() async {
    if (!FlutterWebBluetooth.instance.isBluetoothApiSupported) {
      return RequestDeviceState.notSupported;
    }
    try {
      final device = await FlutterWebBluetooth.instance.requestDevice(
        RequestOptionsBuilder.acceptAllDevices(
          optionalServices: BluetoothDefaultServiceUUIDS.services
              .map((final e) => e.uuid)
              .toList(),
          optionalManufacturerData: BluetoothDefaultManufacturerIdentifiers
              .manufacturerIdentifiers
              .map((final e) => e.identifier)
              .toList(growable: false),
        ),
      );
      debugPrint("Device got! ${device.name}, ${device.id}");
      return RequestDeviceState.ok;
    } on BluetoothAdapterNotAvailable {
      return RequestDeviceState.adapterNotAvailable;
    } on UserCancelledDialogError {
      return RequestDeviceState.userCancelled;
    } on DeviceNotFoundError {
      return RequestDeviceState.deviceNotFound;
    } catch (e, s) {
      debugPrint("$e\n$s");
      return RequestDeviceState.other;
    }
  }

  static Future<RequestAdvertisementDeviceState> requestAdvertisementDevice(
    final AdvertisementBluetoothDevice device,
  ) async {
    if (!FlutterWebBluetooth.instance.isBluetoothApiSupported) {
      return RequestAdvertisementDeviceState(RequestDeviceState.notSupported);
    }
    try {
      final newDevice = await FlutterWebBluetooth.instance
          .requestAdvertisementDevice(
            device,
            optionalServices: BluetoothDefaultServiceUUIDS.services
                .map((final e) => e.uuid)
                .toList(),
          );
      debugPrint("Device got! ${newDevice.name}, ${newDevice.id}");
      return RequestAdvertisementDeviceState(
        RequestDeviceState.ok,
        device: newDevice,
      );
    } on BluetoothAdapterNotAvailable {
      return RequestAdvertisementDeviceState(
        RequestDeviceState.adapterNotAvailable,
      );
    } on UserCancelledDialogError {
      return RequestAdvertisementDeviceState(RequestDeviceState.userCancelled);
    } on DeviceNotFoundError {
      return RequestAdvertisementDeviceState(RequestDeviceState.deviceNotFound);
    } catch (e, s) {
      debugPrint("$e\n$s");
      return RequestAdvertisementDeviceState(RequestDeviceState.other);
    }
  }

  static Future<RequestLEState> requestLEScan() async {
    if (_currentScan?.active ?? false) {
      debugPrint("Stopping the LE scan");
      _currentScan!.stop();
      _currentScan = null;
      return RequestLEState.stopped;
    }
    if (!FlutterWebBluetooth.instance.isBluetoothApiSupported) {
      return RequestLEState.notSupported;
    }
    try {
      final options = LEScanOptionsBuilder.acceptAllAdvertisements();

      final scan = await FlutterWebBluetooth.instance
          .requestLEScan(options)
          .timeout(const Duration(seconds: 10));
      debugPrint("Started the LE scan ${scan.active}");
      _currentScan = scan;
      return RequestLEState.ok;
    } on NativeAPINotImplementedError {
      return RequestLEState.apiNotSupported;
    } on BluetoothAdapterNotAvailable {
      return RequestLEState.adapterNotAvailable;
    } on UserCancelledDialogError {
      return RequestLEState.userCancelled;
    } on DeviceNotFoundError {
      return RequestLEState.deviceNotFound;
    } on PermissionError {
      return RequestLEState.permissionError;
    } on TimeoutException {
      return RequestLEState.timeoutException;
    } catch (e, s) {
      debugPrint("$e\n$s");
      return RequestLEState.other;
    }
  }

  ///
  /// Create a stream that combines the device returned from advertisements and
  /// from normal device requests.
  ///
  /// Will return `null` if bluetooth web is not supported.
  ///
  static Stream<Set<MainPageDevice>>? createDeviceStream() {
    if (!Bluetooth.isBluetoothAPISupported()) {
      return null;
    }
    final List<AdvertisementReceivedEvent<AdvertisementBluetoothDevice>>
    advertisementDevices = [];

    int sortMethod(
      final AdvertisementReceivedEvent<AdvertisementBluetoothDevice> a,
      final AdvertisementReceivedEvent<AdvertisementBluetoothDevice> b,
    ) {
      final nameA = a.name;
      final nameB = b.name;
      int compare = 0;
      if (nameA != null && nameB != null) {
        compare = nameA.compareTo(nameB);
      }
      if (compare == 0) {
        compare = a.device.id.compareTo(b.device.id);
      }
      return compare;
    }

    final Set<BluetoothDevice> pairedDevice = SplayTreeSet.from({}, (
      final a,
      final b,
    ) {
      final nameA = a.name;
      final nameB = b.name;
      int compare = 0;
      if (nameA != null && nameB != null) {
        compare = nameA.compareTo(nameB);
      }
      if (compare == 0) {
        compare = a.id.compareTo(b.id);
      }
      return compare;
    });

    return MergeStream([
      FlutterWebBluetooth.instance.devices.map((final event) {
        pairedDevice.clear();
        pairedDevice.addAll(event);
        return 0;
      }),
      FlutterWebBluetooth.instance.advertisements.map((final event) {
        final index = advertisementDevices.indexWhere(
          (final element) => element.device == event.device,
        );
        if (index > 0) {
          advertisementDevices.removeAt(index);
        }

        advertisementDevices.add(event);
        advertisementDevices.sort(sortMethod);
        return 1;
      }),
    ]).map((final event) {
      final Set<MainPageDevice> devices = SplayTreeSet<MainPageDevice>.from(
        pairedDevice.map(
          (final e) => MainPageDevice(
            device: e,
            event: advertisementDevices
                .cast<
                  AdvertisementReceivedEvent<AdvertisementBluetoothDevice>?
                >()
                .firstWhere(
                  (final element) => element?.device.id == e.id,
                  orElse: () => null,
                ),
          ),
        ),
        (final a, final b) {
          final nameA = a.device.name;
          final nameB = b.device.name;
          int compare = 0;
          if (nameA != null && nameB != null) {
            compare = nameA.compareTo(nameB);
          }
          if (compare == 0) {
            compare = a.device.id.compareTo(b.device.id);
          }
          return compare;
        },
      );

      devices.addAll(
        advertisementDevices.map(
          (final e) => MainPageDevice.fromEvent(event: e),
        ),
      );
      return devices;
    });
  }
}
