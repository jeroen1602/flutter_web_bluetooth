part of js_web_bluetooth;

///
/// https://developer.mozilla.org/en-US/docs/Web/API/Bluetooth
///
@JS('navigator.bluetooth')
class _NativeBluetooth {
  external static Object getAvailability();

  external static Object getDevices();

  external static Object requestDevice(RequestOptions? options);

  external static void addEventListener(
      String type, void Function(dynamic) listener);

  external static void removeEventListener(
      String type, void Function(dynamic) listener);
}

@visibleForTesting
class NativeBluetooth {
  Object getAvailability() {
    return _NativeBluetooth.getAvailability();
  }

  Object getDevices() {
    return _NativeBluetooth.getDevices();
  }

  Object requestDevice(RequestOptions? options) {
    return _NativeBluetooth.requestDevice(options);
  }

  void addEventListener(String type, void Function(dynamic) listener) {
    _NativeBluetooth.addEventListener(type, listener);
  }

  void removeEventListener(String type, void Function(dynamic) listener) {
    _NativeBluetooth.removeEventListener(type, listener);
  }
}

NativeBluetooth _nativeBluetooth = NativeBluetooth();

@visibleForTesting
void setNativeBluetooth(NativeBluetooth nativeBluetooth) {
  _nativeBluetooth = nativeBluetooth;
}

@JS()
@anonymous
class BluetoothScanFilter {
  external List<dynamic>? get services;

  external String? get name;

  external String? get namePrefix;

  external factory BluetoothScanFilter(
      {List<dynamic>? services, String? name, String? namePrefix});
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

@JS('navigator')
external Object _navigator;

Object? _navigatorTesting;

@visibleForTesting
void setNavigator(Object navigatorObject) {
  _navigatorTesting = navigatorObject;
}

Object _getNavigator() {
  return _navigatorTesting ?? _navigator;
}

class Bluetooth {
  Bluetooth._();

  static bool isBluetoothAPISupported() {
    final hasProperty = _JSUtil.hasProperty(_getNavigator(), 'bluetooth');
    return hasProperty;
  }

  ///
  /// Check if a bluetooth adapter is available for the borwser (user agent)
  /// If no bluetooth adapters are available to the browser it will
  /// resolve into false. This may return true even if the acapter is disabled
  /// by the user.
  ///
  /// Will check if `bluetooth in navigator` if this is not the case then the
  /// api is not available in the browser.
  /// After this it will call `navigator.bluetooth.getAvailability()` to check
  /// if there is an adapter available.
  ///
  /// This will return false if the website is not run in a secure context.
  static Future<bool> getAvailability() async {
    if (!isBluetoothAPISupported()) {
      return false;
    }
    final promise = _nativeBluetooth.getAvailability();
    final result = await _JSUtil.promiseToFuture(promise);
    if (!kReleaseMode) {
      debugPrint('flutter_web_bluetooth: Result getAvailability $result');
    }
    if (result is bool) {
      availabilityStream?.add(result);
      return result;
    }
    return false;
  }

  @visibleForTesting
  static BehaviorSubject<bool>? availabilityStream;

  ///
  /// Get a [Stream] for the availability of a Bluetooth adapter.
  /// If a user inserts or removes a bluetooth adapter from their devices this
  /// stream will update.
  /// It will not necicerly update if the user enables/ disables a bleutooth
  /// adapter.
  ///
  static Stream<bool> onAvailabilitychanged() {
    if (!isBluetoothAPISupported()) {
      if (!kReleaseMode) {
        debugPrint('flutter_web_bluetooth: Bluetooth api not supported');
      }
      return Stream.value(false);
    }
    if (availabilityStream != null) {
      return availabilityStream!.stream;
    }
    availabilityStream = BehaviorSubject();
    _nativeBluetooth.addEventListener('availabilitychanged',
        _JSUtil.allowInterop((event) {
      final value = _JSUtil.getProperty(event, 'value');
      if (!kReleaseMode) {
        debugPrint('flutter_web_bluetooth: Availability changed $value');
      }
      if (value is bool) {
        availabilityStream?.add(value);
      }
    }));
    return MergeStream(
        [Stream.fromFuture(getAvailability()), availabilityStream!.stream]);
  }

  static Future<List<NativeBluetoothDevice>> getDevices() async {
    final promise = _nativeBluetooth.getDevices();
    final result = await _JSUtil.promiseToFuture(promise);
    if (result is List) {
      final items = <NativeBluetoothDevice>[];
      for (final item in result) {
        try {
          items.add(NativeBluetoothDevice.fromJSObject(item));
        } on UnsupportedError {
          debugPrint(
              'flutter_web_bluetooth: Could not convert known device to BluetoothDevice');
        }
      }
      return items;
    }
    return [];
  }

  static Future<NativeBluetoothDevice> requestDevice(
      RequestOptions? options) async {
    final promise = _nativeBluetooth.requestDevice(options);
    try {
      final result = await _JSUtil.promiseToFuture(promise);
      final device = NativeBluetoothDevice.fromJSObject(result);
      return device;
    } catch (e) {
      final error = e.toString();
      if (error.startsWith('NotFoundError')) {
        // No devices found or cancelled by the user.
        if (error.toLowerCase().contains('user cancelled')) {
          // TODO: check if this is also the message on other browsers!
          throw UserCancelledDialogError(
              error.replaceFirst('NotFoundError', '').replaceFirst(': ', ''));
        }
        throw DeviceNotFoundError(
            error.replaceFirst('NotFoundError', '').replaceFirst(': ', ''));
      }
      throw e;
    }
  }
}
