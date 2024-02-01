part of "../js_web_bluetooth.dart";

///
/// The js object for request options. This is used for [Bluetooth.requestDevice].
///
/// Either [filters] or [acceptAllDevices] must have something meaningful set
/// in them, they can't be set at the same time.
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
  /// A device may not have enough distinct information. To solve this you may
  /// add [exclusionFilters]. These are the same as the [filters], if a
  /// device matches **ANY** of these filters then it will not be available.
  ///
  /// **NOTE:** [exclusionFilters] cannot be used together with
  /// [acceptAllDevices]. It may also not be an empty list.
  ///
  /// **NOTE:** [exclusionFilters] are only supported from Chrome 114 and above
  /// as well other browsers based on chromium.
  ///
  external List<BluetoothScanFilter> get exclusionFilters;

  ///
  /// A list of service UUIDS that a device may have or may not have.
  ///
  /// *NOTE:** You **NEED** to define a service in either the [filters]
  /// or [optionalServices] if you want to be able to communicate with a
  /// characteristic in it.
  ///
  external List<String> get optionalServices;

  ///
  /// A list of manufacturer codes that a device may or may not have.
  ///
  /// *NOTE:** You **NEED** to define a manufacturer's code in either the [filters]
  /// or [optionalManufacturerData] if you want to be able to get its data.
  ///
  external List<int> get optionalManufacturerData;

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
      {final List<BluetoothScanFilter> filters,
      final List<BluetoothScanFilter> exclusionFilters,
      final List<dynamic> optionalServices,
      final List<dynamic> optionalManufacturerData,
      final bool acceptAllDevices});
}
