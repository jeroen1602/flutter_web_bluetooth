part of js_web_bluetooth;

///
/// An interface to the navigator.bluetooth interface.
///
/// See:
///
/// - https://developer.mozilla.org/en-US/docs/Web/API/Bluetooth
///
/// - https://webbluetoothcg.github.io/web-bluetooth/#bluetooth
///
@JS('navigator.bluetooth')
class _NativeBluetooth {
  ///
  /// Should return a promise (which will be converted to a future using
  /// [JSUtils.promiseToFuture]) with a [bool] if bluetooth is available on
  /// the current device.
  ///
  /// See:
  ///
  /// - https://developer.mozilla.org/en-US/docs/Web/API/Bluetooth/getAvailability
  ///
  /// - https://webbluetoothcg.github.io/web-bluetooth/#dom-bluetooth-getavailability
  ///
  external static Object getAvailability();

  ///
  /// should return a promise (which will be converted to a future using
  /// [JSUtils.promiseToFuture]) with a list of [Object]s. These objects
  /// should then be able to be converted to a [WebBluetoothDevice] using
  /// [WebBluetoothDevice.fromJSObject].
  ///
  /// **NOTE:** Currently no browser supports this without a flag needing
  /// to be set!
  ///
  /// See:
  ///
  /// - https://developer.mozilla.org/en-US/docs/Web/API/Bluetooth/getDevices
  ///
  /// - https://webbluetoothcg.github.io/web-bluetooth/#dom-bluetooth-getdevices
  ///
  external static Object getDevices();

  ///
  /// should return a promise (which will be converted to a future using
  /// [JSUtils.promiseToFuture]) with an [Object]. This object
  /// should then be able to be converted to a [WebBluetoothDevice] using
  /// [WebBluetoothDevice.fromJSObject].
  ///
  /// This method may throw a TypeError or a NotFoundError.
  ///
  /// See:
  ///
  /// - https://developer.mozilla.org/en-US/docs/Web/API/Bluetooth/requestDevice
  ///
  /// - https://webbluetoothcg.github.io/web-bluetooth/#dom-bluetooth-requestdevice
  ///
  external static Object requestDevice(RequestOptions? options);

  ///
  /// Add a new event listener to the navigation.
  ///
  /// Make sure to mark the listener as interoperable using [JSUtils.allowInterop].
  ///
  /// Events to be handled are:
  ///
  /// - onadvertisementreceived
  ///
  /// - ongattserverdisconnected
  ///
  /// - oncharacteristicvaluechanged
  ///
  /// - onserviceadded
  ///
  /// - onservicechanged
  ///
  /// - onserviceremoved
  ///
  /// See:
  ///
  /// - [removeEventListener]
  ///
  /// - https://webbluetoothcg.github.io/web-bluetooth/#bluetoothdeviceeventhandlers
  ///
  /// - https://webbluetoothcg.github.io/web-bluetooth/#characteristiceventhandlers
  ///
  /// - https://webbluetoothcg.github.io/web-bluetooth/#serviceeventhandlers
  ///
  external static void addEventListener(
      String type, void Function(dynamic) listener);

  ///
  /// Remove an event listener that had previously been added.
  ///
  /// Make sure to mark the listener as interoperable using [JSUtils.allowInterop].
  ///
  /// See: [addEventListener]
  ///
  external static void removeEventListener(
      String type, void Function(dynamic) listener);
}

///
/// The native interface to the browser's navigator.bluetooth object.
/// This allows for the replacement of this interface if needed for testing.
///
/// Because of the low level interface it doesn't have any type safety.
///
/// For testing you can replace the [JSUtils] used using [testingSetJSUtils]
/// this way you can keep everything as proper Dart objects and have the tests
/// run under Dart native.
///
@visibleForTesting
class NativeBluetooth {
  ///
  /// Create a new instance of [NativeBluetooth] with the default
  /// implementations for the methods that will call the actual methods
  /// on the navigator in the background.
  ///
  /// Using the constructor can be used if you want to rest the native bluetooth
  /// implementation for testing using [setNativeBluetooth].
  ///
  /// Otherwise the Fake library can be used to overwrite the methods for testing
  ///
  @visibleForTesting
  NativeBluetooth();

  ///
  /// Should return a promise (which will be converted to a future using
  /// [JSUtils.promiseToFuture]) with a [bool] if bluetooth is available on
  /// the current device.
  ///
  /// See:
  ///
  /// - https://developer.mozilla.org/en-US/docs/Web/API/Bluetooth/getAvailability
  ///
  /// - https://webbluetoothcg.github.io/web-bluetooth/#dom-bluetooth-getavailability
  ///
  Object getAvailability() {
    return _NativeBluetooth.getAvailability();
  }

  ///
  /// should return a promise (which will be converted to a future using
  /// [JSUtils.promiseToFuture]) with a list of [Object]s. These objects
  /// should then be able to be converted to a [WebBluetoothDevice] using
  /// [WebBluetoothDevice.fromJSObject].
  ///
  /// **NOTE:** Currently no browser supports this without a flag needing
  /// to be set!
  ///
  /// See:
  ///
  /// - https://developer.mozilla.org/en-US/docs/Web/API/Bluetooth/getDevices
  ///
  /// - https://webbluetoothcg.github.io/web-bluetooth/#dom-bluetooth-getdevices
  ///
  Object getDevices() {
    return _NativeBluetooth.getDevices();
  }

  ///
  /// should return a promise (which will be converted to a future using
  /// [JSUtils.promiseToFuture]) with an [Object]. This object
  /// should then be able to be converted to a [WebBluetoothDevice] using
  /// [WebBluetoothDevice.fromJSObject].
  ///
  /// This method may throw a TypeError or a NotFoundError.
  ///
  /// See:
  ///
  /// - https://developer.mozilla.org/en-US/docs/Web/API/Bluetooth/requestDevice
  ///
  /// - https://webbluetoothcg.github.io/web-bluetooth/#dom-bluetooth-requestdevice
  ///
  Object requestDevice(RequestOptions? options) {
    return _NativeBluetooth.requestDevice(options);
  }

  ///
  /// Add a new event listener to the navigation.
  ///
  /// Make sure to mark the listener as interoperable using [JSUtils.allowInterop].
  ///
  /// Events to be handled are:
  ///
  /// - onadvertisementreceived
  ///
  /// - ongattserverdisconnected
  ///
  /// - oncharacteristicvaluechanged
  ///
  /// - onserviceadded
  ///
  /// - onservicechanged
  ///
  /// - onserviceremoved
  ///
  /// See:
  ///
  /// - [removeEventListener]
  ///
  /// - https://webbluetoothcg.github.io/web-bluetooth/#bluetoothdeviceeventhandlers
  ///
  /// - https://webbluetoothcg.github.io/web-bluetooth/#characteristiceventhandlers
  ///
  /// - https://webbluetoothcg.github.io/web-bluetooth/#serviceeventhandlers
  ///
  void addEventListener(String type, void Function(dynamic) listener) {
    _NativeBluetooth.addEventListener(type, listener);
  }

  ///
  /// Remove an event listener that has previously been added.
  ///
  /// Make sure to mark the listener as interoperable using [JSUtils.allowInterop].
  ///
  /// See: [addEventListener]
  ///
  void removeEventListener(String type, void Function(dynamic) listener) {
    _NativeBluetooth.removeEventListener(type, listener);
  }
}

NativeBluetooth _nativeBluetooth = NativeBluetooth();

///
/// Replace the [NativeBluetooth] api interface to allow for testing.
/// This shouldn't be done for production code.
///
/// If you do replace the [NativeBluetooth] then you may also want to change
/// the [testingSetJSUtils].
///
@visibleForTesting
void setNativeBluetooth(NativeBluetooth nativeBluetooth) {
  _nativeBluetooth = nativeBluetooth;
}

///
/// The js object for Bluetooth scan filters.
/// At least one of the filter must be set, the rest can be left
/// `undefined`.
///
/// See:
///
/// - https://webbluetoothcg.github.io/web-bluetooth/#dictdef-bluetoothservicedatafilterinit
///
@JS()
@anonymous
class BluetoothServiceDataFilter {
  ///
  /// may be a UUID of the service that should exist.
  ///
  external String? get service;

  ///
  /// is a uint8 (or byte) array of the first n bytes of the UUID
  /// that should exist for the service. For example if you have the UUID
  /// `D273346A-...` then the prefix of `D273` should match
  ///
  external Object? get dataPrefix;

  ///
  /// Is a uint8 (or byte) array of the bits that should be matched against.
  /// The original UUID will be bit wise and (&) as well as the [dataPrefix] to
  /// the same [mask]. These two will then be compared to be equal.
  ///
  external Object? get mask;

  ///
  /// The constructor of the request filter.
  ///
  /// Because of how the js conversion works setting a value to null is not
  /// the same as leaving it undefined. Use
  /// [BluetoothScanFilterHelper.createServiceDataObject]
  /// to get around this problem.
  ///
  external factory BluetoothServiceDataFilter(
      {String? service, Object? dataPrefix, Object? mask});
}

///
/// The js object for Bluetooth scan filters.
/// At least one of the filter must be set, the rest can be left
/// `undefined`.
///
/// See:
///
/// - https://webbluetoothcg.github.io/web-bluetooth/#dictdef-bluetoothmanufacturerdatafilterinit
///
@JS()
@anonymous
class BluetoothManufacturerDataFilter {
  ///
  /// is a 16 bit identifier of the company that either made
  /// the device, or made the bluetooth chip that the device uses.
  ///
  /// See the full list of company identifiers
  /// [here](https://www.bluetooth.com/specifications/assigned-numbers/company-identifiers/).
  ///
  external int? get companyIdentifier;

  ///
  /// is a uint8 (or byte) array of the first n bytes of the
  /// manufacturer data of the device. For example if you have the UUID
  /// `D273346A-...` then the prefix of `D273` should match
  ///
  external Object? get dataPrefix;

  ///
  /// is a uint8 (or byte) array of the bits that should be matched against.
  /// The manufacturer data will be bit wise and (&) as well as the [dataPrefix] to
  /// the same [mask]. These two will then be compared to be equal.
  ///
  external Object? get mask;

  ///
  /// The constructor of the request filter.
  ///
  /// Because of how the js conversion works setting a value to null is not
  /// the same as leaving it undefined. Use
  /// [BluetoothScanFilterHelper.createManufacturerDataObject]
  /// to get around this problem.
  ///
  external factory BluetoothManufacturerDataFilter(
      {int? companyIdentifier, Object? dataPrefix, Object? mask});
}

///
/// The js object for Bluetooth scan filters.
/// At least one of the filter must be set, the rest can be left
/// `undefined`.
///
/// See:
///
/// - https://developer.mozilla.org/en-US/docs/Web/API/Bluetooth/requestDevice
///
/// - https://webbluetoothcg.github.io/web-bluetooth/#dictdef-bluetoothlescanfilterinit
///
@JS()
@anonymous
class BluetoothScanFilter {
  ///
  /// A list of UUIDS (should be lower case) of the services that the device
  /// must have. A device is only allowed if it has all the services.
  ///
  external List<String>? get services;

  ///
  /// The name of the device. The name must be the exact same for the device
  /// to be allowed.
  ///
  external String? get name;

  ///
  /// A name prefix. The name of the device must
  /// have the same prefix. For example: a device with the name "ABCDEF" will
  /// be allowed with the prefix "ABC" and not with the prefix "DEF".
  ///
  external String? get namePrefix;

  ///
  /// A [List] of [BluetoothManufacturerDataFilter]s
  /// for what the manufacture data of the device should match before it shows
  /// up in the available devices list. Note that if you set multiple manufacturer
  /// data filters then a single device must match all of them.
  ///
  external List<BluetoothManufacturerDataFilter>? get manufacturerData;

  ///
  /// A [List] of [BluetoothServiceDataFilter]s for the services that the
  /// device should support.
  ///
  /// **Note** this is not stable yet and my not be implemented.
  /// ignore: deprecated_member_use_from_same_package
  ///
  external List<BluetoothServiceDataFilter>? get serviceData;

  ///
  /// The constructor of the request filter.
  ///
  /// Because of how the js conversion works setting a value to null is not
  /// the same as leaving it undefined. Use [BluetoothScanFilterHelper.createScanFilterObject]
  /// to get around this problem.
  ///
  external factory BluetoothScanFilter(
      {List<String>? services,
      String? name,
      String? namePrefix,
      List<BluetoothManufacturerDataFilter>? manufacturerData,
      List<BluetoothServiceDataFilter>? serviceData});
}

///
/// A class with a helper function to create the correct js object from a filter.
///
/// Because of how the JS translation works leaving an item blank in
/// [BluetoothScanFilter]'s constructor. Would set these values to null instead
/// of keeping them undefined. This would cause the API to complain. So to keep
/// it at peace this workaround is used.
///
class BluetoothScanFilterHelper {
  BluetoothScanFilterHelper._();

  ///
  /// Create a [BluetoothManufacturerDataFilter] only setting the fields that
  /// are not `null` this exists because Dart isn't able to set items to
  /// `undefined`.
  ///
  /// No check is done here so you may end up with an empty object.
  ///
  static Object createManufacturerDataObject(int? companyIdentifier,
      final Uint8List? dataPrefix, final Uint8List? mask) {
    final jsObject = _JSUtil.newObject();
    if (companyIdentifier != null) {
      _JSUtil.setProperty(jsObject, 'companyIdentifier', companyIdentifier);
    }
    _fillDataFilter(jsObject, dataPrefix, mask);
    return jsObject;
  }

  ///
  /// Create a [BluetoothServiceDataFilter] only setting the fields that
  /// are not `null` this exists because Dart isn't able to set items to
  /// `undefined`.
  ///
  /// No check is done here so you may end up with an empty object.
  ///
  static Object createServiceDataObject(final String? service,
      final Uint8List? dataPrefix, final Uint8List? mask) {
    final jsObject = _JSUtil.newObject();
    if (service != null) {
      _JSUtil.setProperty(jsObject, 'service', service);
    }
    _fillDataFilter(jsObject, dataPrefix, mask);
    return jsObject;
  }

  ///
  /// Fill the data filter part of the [createManufacturerDataObject] or
  /// [createServiceDataObject] object.
  ///
  static void _fillDataFilter(
      dynamic jsObject, final Uint8List? dataPrefix, final Uint8List? mask) {
    if (dataPrefix != null) {
      var convertedDataPrefix =
          WebBluetoothConverters.convertUint8ListToJSArrayBuffer(dataPrefix);
      _JSUtil.setProperty(jsObject, 'dataPrefix', convertedDataPrefix);
    }
    if (mask != null) {
      var convertedMask =
          WebBluetoothConverters.convertUint8ListToJSArrayBuffer(mask);
      _JSUtil.setProperty(jsObject, 'mask', convertedMask);
    }
  }

  ///
  /// Create a new JS object with the fields for [BluetoothScanFilter]. But
  /// instead of setting all the values to `null` it will just not add them
  /// keeping them `undefined`.
  ///
  /// No check is done here so you may end up with an empty object.
  ///
  /// You may need to cast it to a [BluetoothScanFilter] but this is allowed
  /// without any complaints as long as the code is run in the browser.
  ///
  static Object createScanFilterObject(
      List<String>? services,
      String? name,
      String? namePrefix,
      List<BluetoothManufacturerDataFilter>? manufacturerData,
      List<BluetoothServiceDataFilter>? serviceData) {
    final jsObject = _JSUtil.newObject();
    if (services != null) {
      _JSUtil.setProperty(
          jsObject, 'services', services.map((e) => e.toLowerCase()).toList());
    }
    if (name != null) {
      _JSUtil.setProperty(jsObject, 'name', name);
    }
    if (namePrefix != null) {
      _JSUtil.setProperty(jsObject, 'namePrefix', namePrefix);
    }
    if (manufacturerData != null) {
      _JSUtil.setProperty(jsObject, 'manufacturerData', manufacturerData);
    }
    if (serviceData != null) {
      _JSUtil.setProperty(jsObject, 'serviceData', serviceData);
    }
    return jsObject;
  }
}

///
/// The js object for request options. This is used for [Bluetooth.requestDevice].
///
/// Either [filters] or [acceptAllDevices] must have something meaningful set
/// in them, they can't be at the same time.
/// If for example [acceptAllDevices] is `true` and [filters] is not an empty
/// list. Then an Error will be thrown when trying to request devices.
///
@JS()
@anonymous
class RequestOptions {
  ///
  /// A list of filters that the accepted device must meet.
  ///
  /// A device must meet at least one filter before the browser will show it
  /// as pairable.
  ///
  /// *NOTE:** You **NEED** to define a service in either the [filters]
  /// or [optionalServices] if you want to be able to communicate with a
  /// characteristic in it.
  ///
  external List<BluetoothScanFilter> get filters;

  ///
  /// A list of service UUIDS that a device may have or may not have.
  ///
  /// *NOTE:** You **NEED** to define a service in either the [filters]
  /// or [optionalServices] if you want to be able to communicate with a
  /// characteristic in it.
  ///
  external List<String> get optionalServices;

  ///
  /// If all device can are allowed to to connect.
  ///
  /// This cannot be true why a [filters] list is set.
  ///
  external bool get acceptAllDevices;

  ///
  /// A constructor for new request options.
  ///
  /// Because of how the conversion to JS works, there is a difference between
  /// leaving an item blank in this constructor and setting it to `null`.
  ///
  external factory RequestOptions(
      {List<BluetoothScanFilter> filters,
      List<dynamic> optionalServices,
      bool acceptAllDevices});
}

///
/// A reference to the navigator object of the browser.
///
@JS('navigator')
external Object _navigator;

///
/// An optional overwrite of [_navigator] for testing.
///
Object? _navigatorTesting;

///
/// Change the navigator object used.
/// This method is meant for testing!
///
/// Also check out [setNativeBluetooth] and [testingSetJSUtils].
///
@visibleForTesting
void testingSetNavigator(Object? navigatorObject) {
  _navigatorTesting = navigatorObject;
}

///
/// Get a reference to the navigator object.
///
/// Will return [_navigatorTesting] if it is not null.
///
Object _getNavigator() {
  return _navigatorTesting ?? _navigator;
}

///
/// The main Bluetooth class. This is the entrypoint to the library.
/// This is where you can get your devices and go further from there.
///
/// Make sure to check [isBluetoothAPISupported] and [getAvailability] to
/// make sure Bluetooth is actually available.
///
class Bluetooth {
  Bluetooth._();

  ///
  /// Check to see if the Bluetooth api is even support in the current
  /// browser.
  ///
  /// Will return false if bluetooth isn't part of the navigator object.
  /// This can happen if the site isn't viewed in a secure context or the api
  /// isn't available in the browser.
  ///
  static bool isBluetoothAPISupported() {
    final hasProperty = _JSUtil.hasProperty(_getNavigator(), 'bluetooth');
    return hasProperty;
  }

  ///
  /// Check if a bluetooth adapter is available for the browser (user agent)
  /// If no bluetooth adapters are available to the browser it will
  /// resolve into false. This may return true even if the adapter is disabled
  /// by the user.
  ///
  /// Will check if `bluetooth in navigator` if this is not the case then the
  /// api is not available in the browser.
  /// After this it will call `navigator.bluetooth.getAvailability()` to check
  /// if there is an adapter available.
  ///
  /// This will return false if the website is not run in a secure context.
  ///
  static Future<bool> getAvailability() async {
    if (!isBluetoothAPISupported()) {
      return false;
    }
    final promise = _nativeBluetooth.getAvailability();
    final result = await _JSUtil.promiseToFuture(promise);
    if (result is bool) {
      _availabilityStream?.add(result);
      return result;
    }
    return false;
  }

  static WebBehaviorSubject<bool>? _availabilityStream;

  ///
  /// Get a [Stream] for the availability of a Bluetooth adapter.
  /// If a user inserts or removes a bluetooth adapter from their devices this
  /// stream will update.
  /// It will not necessarily update if the user enables/ disables a bluetooth
  /// adapter.
  ///
  static Stream<bool> onAvailabilityChanged() {
    if (!isBluetoothAPISupported()) {
      return Stream.value(false);
    }
    if (_availabilityStream != null) {
      return _availabilityStream!.stream;
    }
    _availabilityStream = WebBehaviorSubject();
    _nativeBluetooth.addEventListener('availabilitychanged',
        _JSUtil.allowInterop((event) {
      final value = _JSUtil.getProperty(event, 'value');
      if (value is bool) {
        _availabilityStream?.add(value);
      }
    }));
    getAvailability();
    return _availabilityStream!.stream;
  }

  ///
  /// Check to see if the [getDevices] call is available in the current browser.
  ///
  /// See: [getDevices].
  ///
  static bool hasGetDevices() {
    if (!isBluetoothAPISupported()) {
      return false;
    }
    final bluetooth = _JSUtil.getProperty(_getNavigator(), 'bluetooth');
    return _JSUtil.hasProperty(bluetooth, 'getDevices');
  }

  ///
  /// Get a list back of already paired devices. A device becomes paired once a
  /// user clicks on it in the pair menu and the web app also connects to the
  /// device. If only a user pairs a device, but not connection attempt is made
  /// then it won't be marked as paired.
  ///
  /// No browser currently supports this without needing a browser flag.
  /// https://caniuse.com/mdn-api_bluetooth_getdevices
  ///
  /// Will return an empty list if [hasGetDevices] returns false.
  /// See [hasGetDevices].
  ///
  static Future<List<WebBluetoothDevice>> getDevices() async {
    if (!hasGetDevices()) {
      return [];
    }
    final promise = _nativeBluetooth.getDevices();
    final result = await _JSUtil.promiseToFuture(promise);
    if (result is List) {
      final items = <WebBluetoothDevice>[];
      for (final item in result) {
        try {
          items.add(WebBluetoothDevice.fromJSObject(item));
        } catch (e, stack) {
          if (e is UnsupportedError) {
            webBluetoothLogger.severe(
                'Could not convert known device to BluetoothDevice.', e, stack);
          } else {
            rethrow;
          }
        }
      }
      return items;
    }
    return [];
  }

  ///
  /// Request the use of a device from the user. Calling this will show the user
  /// a dialog in which they will be able to select a single device to pair with
  ///
  /// If you need to pair with more devices then you will need to request this
  /// for each device individually.
  ///
  /// Make sure to check [getAvailability], and [isBluetoothAPISupported] or
  /// else you may get an [Error].
  ///
  /// - May throw [UserCancelledDialogError] if the user canceled the dialog
  ///
  /// - May throw [DeviceNotFoundError] if no device could be found for the
  /// [RequestOptions].
  ///
  /// - May throw TypeError if the [RequestOptions] are malformed.
  ///
  /// See:
  ///
  /// - [RequestOptions]
  ///
  /// - https://developer.mozilla.org/en-US/docs/Web/API/Bluetooth/requestDevice
  ///
  /// - https://webbluetoothcg.github.io/web-bluetooth/#dom-bluetooth-requestdevice
  ///
  static Future<WebBluetoothDevice> requestDevice(
      RequestOptions? options) async {
    final promise = _nativeBluetooth.requestDevice(options);
    try {
      final result = await _JSUtil.promiseToFuture(promise);
      final device = WebBluetoothDevice.fromJSObject(result);
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
      rethrow;
    }
  }

  ///
  /// This is a setting for (new) devices if it should use memory for advertisements.
  ///
  /// Not every device sends a completely filled out advertisement packet for
  /// each advertisements. For example every other packet might have the name
  /// field missing. If this setting is set to `true` it will use the last received
  /// event to fill in the missing data on the current new event.
  ///
  /// You may want to disable this for certain projects in that case set this
  /// option to `false`.
  ///
  /// It can also be set on a per device level if that is desirable.
  /// [BluetoothDevice.advertisementsUseMemory].
  ///
  static bool defaultAdvertisementsMemory = true;
}
