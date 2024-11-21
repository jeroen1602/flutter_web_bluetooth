part of "../js_web_bluetooth.dart";

///
/// An interface to the navigator.bluetooth interface.
///
/// See:
///
/// - https://developer.mozilla.org/en-US/docs/Web/API/Bluetooth
///
/// - https://webbluetoothcg.github.io/web-bluetooth/#bluetooth
///
@JS()
extension type _NativeBluetooth._(JSObject _) implements JSObject, EventTarget {
  ///
  /// Returns a [JSPromise] with a [JSBoolean] if bluetooth is available on
  /// the current device.
  ///
  /// See:
  ///
  /// - https://developer.mozilla.org/en-US/docs/Web/API/Bluetooth/getAvailability
  ///
  /// - https://webbluetoothcg.github.io/web-bluetooth/#dom-bluetooth-getavailability
  ///
  external JSPromise<JSBoolean> getAvailability();

  ///
  /// Returns a [JSPromise] with an [JSArray] of [WebBluetoothDevice]s.
  ///
  /// This method returns all the allowed devices that the user has granted
  /// access to. Even if the devices are not in range.
  ///
  /// Devices can be removed from this list using [WebBluetoothDevice.forget].
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
  external JSPromise<JSArray<WebBluetoothDevice>> getDevices();

  ///
  /// Returns a [JSPromise] with a [WebBluetoothDevice].
  ///
  /// This method may throw a TypeError or a NotFoundError.
  ///
  /// See:
  ///
  /// - https://developer.mozilla.org/en-US/docs/Web/API/Bluetooth/requestDevice
  ///
  /// - https://webbluetoothcg.github.io/web-bluetooth/#dom-bluetooth-requestdevice
  ///
  external JSPromise<WebBluetoothDevice> requestDevice(
      final RequestOptions options);

  ///
  /// Request the user to start scanning for Bluetooth LE devices in the area
  ///
  /// https://webbluetoothcg.github.io/web-bluetooth/scanning.html#dom-bluetooth-requestlescan
  ///
  external JSPromise<BluetoothLEScan> requestLEScan(
      final BluetoothLEScanOptions options);
}

_NativeBluetooth get _nativeBluetoothInstance => _navigator._bluetooth;

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
  /// Returns a [JSPromise] with a [JSBoolean] if bluetooth is available on
  /// the current device.
  ///
  /// See:
  ///
  /// - https://developer.mozilla.org/en-US/docs/Web/API/Bluetooth/getAvailability
  ///
  /// - https://webbluetoothcg.github.io/web-bluetooth/#dom-bluetooth-getavailability
  ///
  JSPromise<JSBoolean> getAvailability() =>
      _nativeBluetoothInstance.getAvailability();

  ///
  /// Returns a [JSPromise] with an [JSArray] of [WebBluetoothDevice]s.
  ///
  /// This method returns all the allowed devices that the user has granted
  /// access to. Even if the devices are not in range.
  ///
  /// Devices can be removed from this list using [WebBluetoothDevice.forget].
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
  JSPromise<JSArray<WebBluetoothDevice>> getDevices() =>
      _nativeBluetoothInstance.getDevices();

  ///
  /// Check to see if current [NativeBluetooth] implementation has the [getDevices]
  /// method.
  ///
  bool hasGetDevices() => _nativeBluetoothInstance.has("getDevices");

  ///
  /// Returns a [JSPromise] with a [WebBluetoothDevice].
  ///
  /// This method may throw a TypeError or a NotFoundError.
  ///
  /// See:
  ///
  /// - https://developer.mozilla.org/en-US/docs/Web/API/Bluetooth/requestDevice
  ///
  /// - https://webbluetoothcg.github.io/web-bluetooth/#dom-bluetooth-requestdevice
  ///
  JSPromise<WebBluetoothDevice> requestDevice(final RequestOptions options) =>
      _nativeBluetoothInstance.requestDevice(options);

  ///
  /// Request the user to start scanning for Bluetooth LE devices in the
  /// area.
  ///
  /// See [BluetoothLEScanOptions] for the options available.
  ///
  /// https://webbluetoothcg.github.io/web-bluetooth/scanning.html#dom-bluetooth-requestlescan
  ///
  JSPromise<BluetoothLEScan> requestLEScan(
          final BluetoothLEScanOptions options) =>
      _nativeBluetoothInstance.requestLEScan(options);

  ///
  /// Check to see if current [NativeBluetooth] implementation has the [hasRequestLEScan]
  /// method.
  ///
  bool hasRequestLEScan() => _nativeBluetoothInstance.has("requestLEScan");

  ///
  /// Add a new event listener to the navigation.
  ///
  /// Make sure to mark the listener as interoperable using [JSUtils.allowInterop].
  ///
  /// Events to be handled are:
  ///
  /// - onadvertisementreceived
  ///
  /// See:
  ///
  /// - [removeEventListener]
  ///
  /// https://webbluetoothcg.github.io/web-bluetooth/#fire-an-advertisementreceived-event
  ///
  void addEventListener(
    final String type,
    final EventListener? callback, [
    final AddEventListenerOptions? options,
  ]) {
    if (options?.isDefinedAndNotNull ?? false) {
      _nativeBluetoothInstance.addEventListener(type, callback, options!);
    } else {
      _nativeBluetoothInstance.addEventListener(type, callback);
    }
  }

  ///
  /// Remove an event listener that has previously been added.
  ///
  /// Make sure to mark the listener as interoperable using [JSUtils.allowInterop].
  ///
  /// See: [addEventListener]
  ///
  void removeEventListener(
    final String type,
    final EventListener? callback, [
    final EventListenerOptions? options,
  ]) {
    if (options?.isDefinedAndNotNull ?? false) {
      _nativeBluetoothInstance.removeEventListener(type, callback, options!);
    } else {
      _nativeBluetoothInstance.removeEventListener(type, callback);
    }
  }

  // region NavigatorBluetoothEventHandlers

  ///
  /// An event fired when the bluetooth adapter becomes available or unavailable.
  ///
  /// this is fired either on [Bluetooth.getAvailability] or when the adapter
  /// becomes available.
  ///
  Stream<WebBluetoothValueEvent<JSBoolean>> get availabilityChanged =>
      _nativeBluetoothInstance.availabilityChanged;

  // endregion

  // region: BluetoothDeviceEventHandlers

  ///
  /// An event fired when the gatt server disconnects. Either the
  /// [NativeBluetoothRemoteGATTServer.disconnect] method was called. Or the
  /// device is out of range/ turned off.
  ///
  /// This event will bubble through the [WebBluetoothDevice] to the root
  /// [Bluetooth] instance.
  ///
  Stream<Event> get onGattServerDisconnected =>
      _nativeBluetoothInstance.onGattServerDisconnected;

  ///
  /// An event fired when an advertisement packet is received.
  ///
  /// These events are fired after calling [WebBluetoothDevice.watchAdvertisements].
  ///
  /// This event will bubble through the [WebBluetoothDevice] to the root
  /// [Bluetooth] instance.
  ///
  Stream<BluetoothAdvertisementReceivedEvent> get onAdvertisementReceived =>
      _nativeBluetoothInstance.onAdvertisementReceived;

  // endregion

  // region: CharacteristicEventHandlers
  ///
  /// An event fired on an characteristic when the characteristic value has changed.
  ///
  /// This event is fired after calling [WebBluetoothRemoteGATTCharacteristic.readValue]
  /// or [WebBluetoothRemoteGATTCharacteristic.startNotifications] is used to
  /// start receiving these events.
  ///
  /// This event will bubble through the [WebBluetoothRemoteGATTCharacteristic],
  /// then [WebBluetoothRemoteGATTService], then the [WebBluetoothDevice],
  /// and finally the root [Bluetooth] instance.
  ///
  Stream<Event> get onCharacteristicValueChanged =>
      _nativeBluetoothInstance.onCharacteristicValueChanged;

  // endregion

  // region: ServiceEventHandlers
  ///
  /// An event fired on a device when a service has been added.
  ///
  /// This event will bubble through the [WebBluetoothRemoteGATTService], then
  /// the [WebBluetoothDevice] and finally the root [Bluetooth] instance.
  ///
  Stream<Event> get onServiceAdded => _nativeBluetoothInstance.onServiceAdded;

  ///
  /// An event fired on a device when a service has changed.
  ///
  /// This event will bubble through the [WebBluetoothRemoteGATTService] to
  /// the [WebBluetoothDevice] and finally root [Bluetooth] instance.
  ///
  Stream<Event> get onServiceChanged =>
      _nativeBluetoothInstance.onServiceChanged;

  ///
  /// An event fired on a device when a service has been removed.
  ///
  /// This event will bubble through the [WebBluetoothRemoteGATTService] to
  /// the [WebBluetoothDevice] and finally root [Bluetooth] instance.
  ///
  Stream<Event> get onServiceRemoved =>
      _nativeBluetoothInstance.onServiceRemoved;
// endregion
}

NativeBluetooth _nativeBluetooth = NativeBluetooth();

///
/// Replace the [NativeBluetooth] api interface to allow for testing.
/// This shouldn't be done for production code.
///
@visibleForTesting
void setNativeBluetooth(final NativeBluetooth nativeBluetooth) {
  _nativeBluetooth = nativeBluetooth;
}

///
/// A reference to the navigator object of the browser.
///
Navigator get _navigator => window.navigator;

///
/// An optional overwrite of [_navigator] for testing.
///
Navigator? _navigatorTesting;

///
/// Change the navigator object used.
/// This method is meant for testing!
///
/// Also check out [setNativeBluetooth].
///
@visibleForTesting
void testingSetNavigator(final Navigator? navigatorObject) {
  _navigatorTesting = navigatorObject;
}

///
/// Get a reference to the navigator object.
///
/// Will return [_navigatorTesting] if it is not null.
///
Navigator _getNavigator() => _navigatorTesting ?? _navigator;

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
  static bool isBluetoothAPISupported() => _getNavigator().has("bluetooth");

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
    final result = (await _nativeBluetooth.getAvailability().toDart).toDart;
    if (result) {
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
    _nativeBluetooth.availabilityChanged.listen((final event) {
      final value = event.value.toDart;
      _availabilityStream?.add(value);
    });
    unawaited(getAvailability());
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
    return _nativeBluetooth.hasGetDevices();
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
  /// Devices can be removed from this list by calling [WebBluetoothDevice.forget] on the device.
  ///
  static Future<List<WebBluetoothDevice>> getDevices() async {
    if (!hasGetDevices()) {
      return [];
    }
    return (await _nativeBluetooth.getDevices().toDart).toDart;
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
  /// - May throw [MissingUserGestureError] if the method is not called from
  /// a user gesture.
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
      final RequestOptions options) async {
    try {
      return await _nativeBluetooth.requestDevice(options).toDart;
    } catch (e) {
      final error = e.toString();
      if (error.startsWith("NotFoundError")) {
        // No devices found or cancelled by the user.
        if (error.toLowerCase().contains("user cancel")) {
          // TODO: check if this is also the message on other browsers!
          throw UserCancelledDialogError(
              error.replaceFirst("NotFoundError", "").replaceFirst(": ", ""));
        }
        throw DeviceNotFoundError(
            error.replaceFirst("NotFoundError", "").replaceFirst(": ", ""));
      } else if (error.startsWith("SecurityError") &&
          error.toLowerCase().contains("gesture")) {
        throw MissingUserGestureError("requestDevice");
      }
      if (e is Error) {
        rethrow;
      }
      throw BrowserError(error);
    }
  }

  ///
  /// Check to see if the current browser has the [requestLEScan] method.
  ///
  /// Use this to avoid the [NativeAPINotImplementedError].
  ///
  static bool hasRequestLEScan() {
    if (!isBluetoothAPISupported()) {
      return false;
    }
    return _nativeBluetooth.hasRequestLEScan();
  }

  ///
  /// Request the user to start scanning for Bluetooth LE devices in the
  /// area. Not every browser supports this method yet so check it using
  /// [hasRequestLEScan]. However even if the browser supports it, the [Future]
  /// may never complete on browsers. This has been the case for Chrome on linux
  /// and windows even with the correct flag enabled. Chrome on Android does
  /// seem to work. Add a [Future.timeout] to combat this.
  ///
  /// The devices found through this are emitted using the
  /// 'advertisementreceived' event on [addEventListener].
  ///
  /// It will only emit devices that match the [options] so it could happen
  /// that there are no devices in range while the scan is running.
  /// See [BluetoothLEScanOptions] for details on the options.
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
  /// - May throw [MissingUserGestureError] if the method is not called from
  /// a user gesture.
  ///
  /// - May throw [BrowserError] for every other browser error.
  ///
  static Future<BluetoothLEScan> requestLEScan(
      final BluetoothLEScanOptions options) async {
    if (!hasRequestLEScan()) {
      throw NativeAPINotImplementedError("requestLEScan");
    }
    try {
      return await _nativeBluetooth.requestLEScan(options).toDart;
    } catch (e) {
      final error = e.toString();
      if (error.startsWith("InvalidStateError")) {
        // The user probably canceled the permission dialog
        if (error.toLowerCase().contains("user cancel")) {
          // TODO: check if this is also the message on other browsers!
          throw UserCancelledDialogError(error
              .replaceFirst("InvalidStateError", "")
              .replaceFirst(": ", ""));
        }
        throw StateError(
            error.replaceFirst("InvalidStateError", "").replaceFirst(": ", ""));
      } else if (error.startsWith("NotSupportedError")) {
        throw NativeAPINotImplementedError("requestLEScan");
      } else if (error.startsWith("NotAllowedError")) {
        throw PermissionError("requestLEScan");
      } else if (error.startsWith("SecurityError")) {
        if (error.toLowerCase().contains("gesture")) {
          throw MissingUserGestureError("requestLEScan");
        }
        throw PolicyError("requestLEScan");
      }

      if (e is Error) {
        rethrow;
      }
      throw BrowserError(error);
    }
  }

  ///
  /// Add a new event listener to the device.
  ///
  /// Converting the method to a [JSFunction] will be done automatically for you.
  /// This function is then returned so that you can later call [removeEventListener].
  ///
  /// Events to be handled are:
  ///
  /// - onadvertisementreceived
  ///
  ///
  /// See:
  ///
  /// - [removeEventListener]
  ///
  static JSFunction addEventListener<T extends JSAny?>(
      final String type, final void Function(T) listener,
      [final AddEventListenerOptions? options]) {
    final function = listener.toJS;
    _nativeBluetooth.addEventListener(type, function, options);
    return function;
  }

  ///
  /// Remove an event listener that has previously been added.
  ///
  /// See: [addEventListener].
  ///
  static void removeEventListener(final String type, final JSFunction listener,
      [final EventListenerOptions? options]) {
    _nativeBluetooth.removeEventListener(type, listener, options);
  }

  // region NavigatorBluetoothEventHandlers

  ///
  /// An event fired when the bluetooth adapter becomes available or unavailable.
  ///
  /// this is fired either on [Bluetooth.getAvailability] or when the adapter
  /// becomes available.
  ///
  Stream<WebBluetoothValueEvent<JSBoolean>> get availabilityChanged =>
      _nativeBluetooth.availabilityChanged;

  // endregion

  // region: BluetoothDeviceEventHandlers

  ///
  /// An event fired when the gatt server disconnects. Either the
  /// [NativeBluetoothRemoteGATTServer.disconnect] method was called. Or the
  /// device is out of range/ turned off.
  ///
  /// This event will bubble through the [WebBluetoothDevice] to the root
  /// [Bluetooth] instance.
  ///
  static Stream<Event> get onGattServerDisconnected =>
      _nativeBluetooth.onGattServerDisconnected;

  ///
  /// An event fired when an advertisement packet is received.
  ///
  /// These events are fired after calling [WebBluetoothDevice.watchAdvertisements].
  ///
  /// This event will bubble through the [WebBluetoothDevice] to the root
  /// [Bluetooth] instance.
  ///
  static Stream<BluetoothAdvertisementReceivedEvent>
      get onAdvertisementReceived => _nativeBluetooth.onAdvertisementReceived;

  // endregion

  // region: CharacteristicEventHandlers
  ///
  /// An event fired on an characteristic when the characteristic value has changed.
  ///
  /// This event is fired after calling [WebBluetoothRemoteGATTCharacteristic.readValue]
  /// or [WebBluetoothRemoteGATTCharacteristic.startNotifications] is used to
  /// start receiving these events.
  ///
  /// This event will bubble through the [WebBluetoothRemoteGATTCharacteristic],
  /// then [WebBluetoothRemoteGATTService], then the [WebBluetoothDevice],
  /// and finally the root [Bluetooth] instance.
  ///
  static Stream<Event> get onCharacteristicValueChanged =>
      _nativeBluetooth.onCharacteristicValueChanged;

  // endregion

  // region: ServiceEventHandlers
  ///
  /// An event fired on a device when a service has been added.
  ///
  /// This event will bubble through the [WebBluetoothRemoteGATTService], then
  /// the [WebBluetoothDevice] and finally the root [Bluetooth] instance.
  ///
  static Stream<Event> get onServiceAdded => _nativeBluetooth.onServiceAdded;

  ///
  /// An event fired on a device when a service has changed.
  ///
  /// This event will bubble through the [WebBluetoothRemoteGATTService] to
  /// the [WebBluetoothDevice] and finally root [Bluetooth] instance.
  ///
  static Stream<Event> get onServiceChanged =>
      _nativeBluetooth.onServiceChanged;

  ///
  /// An event fired on a device when a service has been removed.
  ///
  /// This event will bubble through the [WebBluetoothRemoteGATTService] to
  /// the [WebBluetoothDevice] and finally root [Bluetooth] instance.
  ///
  static Stream<Event> get onServiceRemoved =>
      _nativeBluetooth.onServiceRemoved;
// endregion
}
