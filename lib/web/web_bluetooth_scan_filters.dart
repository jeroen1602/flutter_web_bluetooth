part of js_web_bluetooth;

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
