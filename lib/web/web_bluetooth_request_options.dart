part of js_web_bluetooth;

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
