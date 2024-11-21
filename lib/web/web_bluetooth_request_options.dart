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
extension type RequestOptions._(JSObject _) implements JSObject {
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
  external JSArray<BluetoothScanFilter>? get filters;

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
  external JSArray<BluetoothScanFilter>? get exclusionFilters;

  ///
  /// A list of service UUIDS that a device may have or may not have.
  ///
  /// *NOTE:** You **NEED** to define a service in either the [filters]
  /// or [optionalServices] if you want to be able to communicate with a
  /// characteristic in it.
  ///
  /// **NOTE:** Some services are on a block list, and are thus not available.
  /// The complete blocklist can be found here:
  /// https://github.com/WebBluetoothCG/registries/blob/master/gatt_blocklist.txt
  ///
  external JSArray<JSString>? get optionalServices;

  ///
  /// A list of manufacturer codes that a device may or may not have.
  ///
  /// *NOTE:** You **NEED** to define a manufacturer's code in either the [filters]
  /// or [optionalManufacturerData] if you want to be able to get its data.
  ///
  /// **NOTE:** Some manufacturer data is on a block list, and is thus not available.
  /// The complete blocklist can be found here:
  /// https://github.com/WebBluetoothCG/registries/blob/master/manufacturer_data_blocklist.txt
  ///
  external JSArray<JSNumber>? get optionalManufacturerData;

  ///
  /// If all device can are allowed to to connect.
  ///
  /// This cannot be true why a [filters] list is set.
  ///
  external JSBoolean? get acceptAllDevices;

  ///
  /// A constructor for new request options.
  ///
  /// Because of how the conversion to JS works, there is a difference between
  /// leaving an item blank in this constructor and setting it to `null`.
  /// To solve this use [RequestOptions.create].
  ///
  external factory RequestOptions(
      {final JSArray<BluetoothScanFilter>? filters,
      final JSArray<BluetoothScanFilter>? exclusionFilters,
      final JSArray<JSString>? optionalServices,
      final JSArray<JSNumber>? optionalManufacturerData,
      final JSBoolean? acceptAllDevices});

  ///
  /// Create a new JS object with the fields for [RequestOptions]. But
  /// instead of setting all the values to `null` it will just not add them
  /// keeping them `undefined`.
  ///
  /// No check is done here so you may end up with an empty object.
  ///
  factory RequestOptions.create(
      {final List<BluetoothScanFilter>? filters,
      final List<BluetoothScanFilter>? exclusionFilters,
      final List<String>? optionalServices,
      final List<int>? optionalManufacturerData,
      final bool? acceptAllDevices}) {
    final requestOptions = RequestOptions();

    if (acceptAllDevices != null && acceptAllDevices) {
      requestOptions.setProperty(
          "acceptAllDevices".toJS, acceptAllDevices.toJS);
    }

    if (filters != null && filters.isNotEmpty) {
      requestOptions.setProperty("filters".toJS, filters.toJS);
    }

    if (exclusionFilters != null && exclusionFilters.isNotEmpty) {
      requestOptions.setProperty(
          "exclusionFilters".toJS, exclusionFilters.toJS);
    }

    if (optionalServices != null && optionalServices.isNotEmpty) {
      requestOptions.setProperty(
          "optionalServices".toJS,
          optionalServices
              .map((final x) => x.toJS)
              .toList(growable: false)
              .toJS);
    }

    if (optionalManufacturerData != null &&
        optionalManufacturerData.isNotEmpty) {
      requestOptions.setProperty(
          "optionalManufacturerData".toJS,
          optionalManufacturerData
              .map((final x) => x.toJS)
              .toList(growable: false)
              .toJS);
    }

    return requestOptions;
  }
}
