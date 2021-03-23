part of native_web_bluetooth;

///
/// https://developer.mozilla.org/en-US/docs/Web/API/Bluetooth
///
@JS('bluetooth')
class _NativeBluetooth {
  external static Object getAvailability();

  external static Object getDevices();

  external static Object requestDevice(RequestOptions? options);

  external static void addEventListener(
      String type, void Function(dynamic) listener);

  external static void removeEventListener(
      String type, void Function(dynamic) listener);
}

@JS()
@anonymous
class BluetoothScanFilter {
  external List<dynamic> get services;

  external String get name;

  external String get namePrefix;

  external factory BluetoothScanFilter(
      {List<dynamic> services, String name, String namePrefix});
}

@JS()
@anonymous
class RequestOptions {
  external List<BluetoothScanFilter> get filters;

  external List<dynamic> get optionalServices;

  external bool get acceptAllDevices;

  external factory RequestOptions(
      {List<BluetoothScanFilter> filters,
      List<dynamic> optionalServices,
      bool acceptAllDevices});
}

class Bluetooth {
  static Future<bool> getAvailability() async {
    final promise = _NativeBluetooth.getAvailability();
    final result = await JSUtil.promiseToFuture(promise);
    if (result is bool) {
      return result;
    }
    return false;
  }

  static Future<List<NativeBluetoothDevice>> getDevices() async {
    final promise = _NativeBluetooth.getDevices();
    final result = await JSUtil.promiseToFuture(promise);
    if (result is List) {
      final items = <NativeBluetoothDevice>[];
      for (final item in result) {
        try {
          items.add(NativeBluetoothDevice._fromJSObject(item));
        } on UnsupportedError {
          debugPrint('Could not convert known device to BluetoothDevice');
        }
      }
      return items;
    }
    return [];
  }

  static Future<NativeBluetoothDevice> requestDevice(
      RequestOptions? options) async {
    final promise = _NativeBluetooth.requestDevice(options);
    final result = await JSUtil.promiseToFuture(promise);
    final device = NativeBluetoothDevice._fromJSObject(result);
    return device;
  }
}
