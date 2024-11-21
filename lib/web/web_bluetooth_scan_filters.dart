part of "../js_web_bluetooth.dart";

///
/// The base type for a bluetooth data filter.
///
/// This filter contains an optional [dataPrefix] and an optional [mask].
///
/// See:
///
/// - https://webbluetoothcg.github.io/web-bluetooth/#dictdef-bluetoothdatafilterinit
///
@JS()
@anonymous
extension type BluetoothDataFilter._(JSObject _) implements JSObject {
  @JS("dataPrefix")
  external JSArrayBuffer? get _dataPrefix;

  ///
  /// is a uint8 (or byte) array of the first n bytes of the UUID
  /// that should exist for the service. For example if you have the UUID
  /// `D273346A-...` then the prefix of `D273` should match
  ///
  ByteBuffer? get dataPrefix {
    if (_dataPrefix == null || _dataPrefix.isUndefinedOrNull) {
      return null;
    }
    return _dataPrefix!.toDart;
  }

  @JS("mask")
  external JSArrayBuffer? get _mask;

  ///
  /// Is a uint8 (or byte) array of the bits that should be matched against.
  /// The original UUID will be bit wise and (&) as well as the [dataPrefix] to
  /// the same [mask]. These two will then be compared to be equal.
  ///
  ByteBuffer? get mask {
    if (_mask == null || _mask.isUndefinedOrNull) {
      return null;
    }
    return _mask!.toDart;
  }

  ///
  /// Fill the data needed for this init type. Will only set it if the values
  /// aren't `null`. (leaving the missing values as `undefined`)
  ///
  static void _fillDataFilter<T extends BluetoothDataFilter>(
      final T jsObject, final Uint8List? dataPrefix, final Uint8List? mask) {
    if (dataPrefix != null) {
      jsObject.setProperty("dataPrefix".toJS, dataPrefix.buffer.toJS);
    }
    if (mask != null) {
      jsObject.setProperty("mask".toJS, mask.buffer.toJS);
    }
  }
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
extension type BluetoothServiceDataFilter._(JSObject _)
    implements JSObject, BluetoothDataFilter {
  @JS("service")
  external JSString get _service;

  ///
  /// may be a UUID of the service that should exist.
  ///
  String get service => _service.toDart;

  ///
  /// The constructor of the request filter.
  ///
  /// Because of how the js conversion works setting a value to null is not
  /// the same as leaving it undefined. Use
  /// [BluetoothServiceDataFilter.create]
  /// to get around this problem.
  ///
  external factory BluetoothServiceDataFilter(
      {required final JSString? service,
      final JSArrayBuffer? dataPrefix,
      final JSArrayBuffer? mask});

  ///
  /// Create a [BluetoothServiceDataFilter] only setting the fields that
  /// are not `null` this exists because Dart isn't able to set items to
  /// `undefined`.
  ///
  factory BluetoothServiceDataFilter.create(
      {required final String service,
      final Uint8List? dataPrefix,
      final Uint8List? mask}) {
    final jsObject = BluetoothServiceDataFilter(service: service.toJS);
    BluetoothDataFilter._fillDataFilter(jsObject, dataPrefix, mask);
    return jsObject;
  }
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
extension type BluetoothManufacturerDataFilter._(JSObject _)
    implements JSObject, BluetoothDataFilter {
  @JS("companyIdentifier")
  external JSNumber get _companyIdentifier;

  ///
  /// is a 16 bit identifier of the company that either made
  /// the device, or made the bluetooth chip that the device uses.
  ///
  /// See the full list of company identifiers
  /// [here](https://www.bluetooth.com/specifications/assigned-numbers/company-identifiers/).
  ///
  int get companyIdentifier => _companyIdentifier.toDartInt;

  ///
  /// The constructor of the request filter.
  ///
  /// Because of how the js conversion works setting a value to null is not
  /// the same as leaving it undefined. Use
  /// [BluetoothManufacturerDataFilter.create]
  /// to get around this problem.
  ///
  external factory BluetoothManufacturerDataFilter(
      {required final JSNumber companyIdentifier,
      final JSArrayBuffer? dataPrefix,
      final JSArrayBuffer? mask});

  ///
  /// Create a [BluetoothManufacturerDataFilter] only setting the fields that
  /// are not `null` this exists because Dart isn't able to set items to
  /// `undefined`.
  ///
  factory BluetoothManufacturerDataFilter.create(
      {required final int companyIdentifier,
      final Uint8List? dataPrefix,
      final Uint8List? mask}) {
    final jsObject = BluetoothManufacturerDataFilter(
        companyIdentifier: companyIdentifier.toJS);
    BluetoothDataFilter._fillDataFilter(jsObject, dataPrefix, mask);
    return jsObject;
  }
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
extension type BluetoothScanFilter._(JSObject _) implements JSObject {
  @JS("name")
  external JSString get _name;

  ///
  /// The name of the device. The name must be the exact same for the device
  /// to be allowed.
  ///
  String? get name => _name.isDefinedAndNotNull ? _name.toDart : null;

  @JS("namePrefix")
  external JSString get _namePrefix;

  ///
  /// A name prefix. The name of the device must
  /// have the same prefix. For example: a device with the name "ABCDEF" will
  /// be allowed with the prefix "ABC" and not with the prefix "DEF".
  ///
  String? get namePrefix =>
      _namePrefix.isDefinedAndNotNull ? _namePrefix.toDart : null;

  @JS("services")
  external JSArray<JSString> get _services;

  ///
  /// A list of UUIDS (should be lower case) of the services that the device
  /// must have. A device is only allowed if it has all the services.
  ///
  /// **NOTE:** Some services are on a block list, and are thus not available.
  /// The complete blocklist can be found here:
  /// https://github.com/WebBluetoothCG/registries/blob/master/gatt_blocklist.txt
  ///
  List<String>? get services {
    if (_services.isUndefinedOrNull) {
      return null;
    }
    return List.unmodifiable(_services.toDart.map((final x) => x.toDart));
  }

  @JS("manufacturerData")
  external JSArray<BluetoothManufacturerDataFilter> get _manufacturerData;

  ///
  /// A [List] of [BluetoothManufacturerDataFilter]s
  /// for what the manufacture data of the device should match before it shows
  /// up in the available devices list. Note that if you set multiple manufacturer
  /// data filters then a single device must match all of them.
  ///
  /// **NOTE:** Some manufacturer data is on a block list, and is thus not available.
  /// The complete blocklist can be found here:
  /// https://github.com/WebBluetoothCG/registries/blob/master/manufacturer_data_blocklist.txt
  ///
  List<BluetoothManufacturerDataFilter>? get manufacturerData {
    if (_manufacturerData.isUndefinedOrNull) {
      return null;
    }
    return _manufacturerData.toDart;
  }

  @JS("serviceData")
  external JSArray<BluetoothServiceDataFilter> get _serviceData;

  ///
  /// A [List] of [BluetoothServiceDataFilter]s for the services that the
  /// device should support.
  ///
  /// **Note** this is not stable yet and my not be implemented.
  ///
  List<BluetoothServiceDataFilter>? get serviceData {
    if (_serviceData.isUndefinedOrNull) {
      return null;
    }
    return _serviceData.toDart;
  }

  ///
  /// The constructor of the request filter.
  ///
  /// Because of how the js conversion works setting a value to null is not
  /// the same as leaving it undefined. Use [BluetoothScanFilter.create]
  /// to get around this problem.
  ///
  external factory BluetoothScanFilter(
      {final JSArray<JSString>? services,
      final JSString? name,
      final JSString? namePrefix,
      final JSArray<BluetoothManufacturerDataFilter>? manufacturerData,
      final JSArray<BluetoothServiceDataFilter>? serviceData});

  ///
  /// Create a new JS object with the fields for [BluetoothScanFilter]. But
  /// instead of setting all the values to `null` it will just not add them
  /// keeping them `undefined`.
  ///
  /// No check is done here so you may end up with an empty object.
  ///
  factory BluetoothScanFilter.create(
      {final List<String>? services,
      final String? name,
      final String? namePrefix,
      final List<BluetoothManufacturerDataFilter>? manufacturerData,
      final List<BluetoothServiceDataFilter>? serviceData}) {
    final jsObject = BluetoothScanFilter();

    if (services != null) {
      jsObject.setProperty(
          "services".toJS,
          services
              .map((final x) => x.toLowerCase().toJS)
              .toList(growable: false)
              .toJS);
    }
    if (name != null) {
      jsObject.setProperty("name".toJS, name.toJS);
    }
    if (namePrefix != null) {
      jsObject.setProperty("namePrefix".toJS, namePrefix.toJS);
    }
    if (manufacturerData != null && manufacturerData.isNotEmpty) {
      jsObject.setProperty("manufacturerData".toJS, manufacturerData.toJS);
    }
    if (serviceData != null && serviceData.isNotEmpty) {
      jsObject.setProperty("serviceData".toJS, serviceData.toJS);
    }
    return jsObject;
  }
}

///
/// A class with a helper function to create the correct js object from a filter.
///
/// Because of how the JS translation works leaving an item blank in
/// [BluetoothScanFilter]'s constructor. Would set these values to null instead
/// of keeping them undefined. This would cause the API to complain. So to keep
/// it at peace this workaround is used.
///
@Deprecated("Use the classes create method instead. Since 1.0.0")
class BluetoothScanFilterHelper {
  @Deprecated("since 1.0.0")
  BluetoothScanFilterHelper._();

  ///
  /// Create a [BluetoothManufacturerDataFilter] only setting the fields that
  /// are not `null` this exists because Dart isn't able to set items to
  /// `undefined`.
  ///
  /// No check is done here so you may end up with an empty object.
  ///
  @Deprecated("Use BluetoothManufacturerDataFilter.create instead. Since 1.0.0")
  static BluetoothManufacturerDataFilter createManufacturerDataObject(
          final int companyIdentifier,
          final Uint8List? dataPrefix,
          final Uint8List? mask) =>
      BluetoothManufacturerDataFilter.create(
          companyIdentifier: companyIdentifier,
          dataPrefix: dataPrefix,
          mask: mask);

  ///
  /// Create a [BluetoothServiceDataFilter] only setting the fields that
  /// are not `null` this exists because Dart isn't able to set items to
  /// `undefined`.
  ///
  /// No check is done here so you may end up with an empty object.
  ///
  @Deprecated("Use BluetoothServiceDataFilter.create instead. Since 1.0.0")
  static BluetoothServiceDataFilter createServiceDataObject(
          final String service,
          final Uint8List? dataPrefix,
          final Uint8List? mask) =>
      BluetoothServiceDataFilter.create(
          service: service, dataPrefix: dataPrefix, mask: mask);

  ///
  /// Create a new JS object with the fields for [BluetoothScanFilter]. But
  /// instead of setting all the values to `null` it will just not add them
  /// keeping them `undefined`.
  ///
  /// No check is done here so you may end up with an empty object.
  ///
  @Deprecated("Use BluetoothScanFilter.create instead. Since 1.0.0")
  static BluetoothScanFilter createScanFilterObject(
          final List<String>? services,
          final String? name,
          final String? namePrefix,
          final List<BluetoothManufacturerDataFilter>? manufacturerData,
          final List<BluetoothServiceDataFilter>? serviceData) =>
      BluetoothScanFilter.create(
          services: services,
          name: name,
          namePrefix: namePrefix,
          manufacturerData: manufacturerData,
          serviceData: serviceData);
}
