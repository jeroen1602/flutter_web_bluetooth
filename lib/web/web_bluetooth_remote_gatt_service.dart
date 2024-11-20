part of "../js_web_bluetooth.dart";

///
/// A class for calling methods and values for [WebBluetoothRemoteGATTService].
///
/// You can get a [WebBluetoothRemoteGATTService] from
/// [NativeBluetoothRemoteGATTServer.getPrimaryService],
/// [NativeBluetoothRemoteGATTServer.getPrimaryServices],
/// [WebBluetoothRemoteGATTService.getIncludedService], and
/// ignore: deprecated_member_use_from_same_package
/// [WebBluetoothRemoteGATTService.getIncludedServices].
///
/// See:
///
/// - https://developer.mozilla.org/en-US/docs/Web/API/BluetoothRemoteGATTService
///
/// - https://webbluetoothcg.github.io/web-bluetooth/#bluetoothgattservice-interface
///
@JS()
extension type WebBluetoothRemoteGATTService._(JSObject _)
    implements EventTarget, JSObject {
  ///
  /// The device that this gatt server belongs too.
  ///
  /// See:
  ///
  /// - https://developer.mozilla.org/en-US/docs/Web/API/BluetoothRemoteGATTService/device
  ///
  /// - https://webbluetoothcg.github.io/web-bluetooth/#dom-bluetoothremotegattservice-device
  ///
  external WebBluetoothDevice get device;

  ///
  /// Check to see if the [isPrimary] exists on the js object.
  ///
  /// It may not exist on some browsers.
  ///
  /// See:
  ///
  /// - [isPrimary]
  ///
  bool hasIsPrimary() => has("isPrimary");

  @JS("isPrimary")
  external JSBoolean get _isPrimary;

  ///
  /// Check if the service is a primary service (top level).
  ///
  /// Not all browser versions support this call yet. Use [hasIsPrimary] to see
  /// if the call is supported.
  ///
  /// - May throw [NativeAPINotImplementedError] if the method does not exist.
  ///
  /// See:
  ///
  /// - [hasIsPrimary]
  ///
  /// - https://developer.mozilla.org/en-US/docs/Web/API/BluetoothRemoteGATTService/isPrimary
  ///
  /// - https://webbluetoothcg.github.io/web-bluetooth/#dom-bluetoothremotegattservice-isprimary
  ///
  bool get isPrimary {
    if (!hasIsPrimary()) {
      throw NativeAPINotImplementedError(
          "BluetoothRemoteGATTService.isPrimary");
    }

    return _isPrimary.isDefinedAndNotNull && _isPrimary.toDart;
  }

  @JS("uuid")
  external JSString _uuid;

  ///
  /// The uuid of the service.
  ///
  /// See:
  ///
  /// - https://developer.mozilla.org/en-US/docs/Web/API/BluetoothRemoteGATTService/uuid
  ///
  /// - https://webbluetoothcg.github.io/web-bluetooth/#dom-bluetoothremotegattservice-uuid
  ///
  String get uuid => _uuid.toDart;

  @JS("getCharacteristic")
  external JSPromise<WebBluetoothRemoteGATTCharacteristic> _getCharacteristic(
      final JSString characteristicUUID);

  ///
  /// Get a characteristic from this service.
  ///
  /// [characteristicUUID] is the UUID (lower case) of the characteristic to
  /// get.
  ///
  /// - May throw SecurityError if the characteristic's UUID is on a blocklist.
  ///
  /// - May throw NetworkError if the GATT server is not connected.
  ///
  /// - May throw InvalidStateError if service is `null`.
  ///
  /// - May throw NotFoundError if the characteristic was not found.
  ///
  /// **NOTE:** Some characteristics are on a block list, and are thus not available.
  /// The complete blocklist can be found here:
  /// https://github.com/WebBluetoothCG/registries/blob/master/gatt_blocklist.txt
  ///
  /// See:
  ///
  /// - [getCharacteristics]
  ///
  /// - https://developer.mozilla.org/en-US/docs/Web/API/BluetoothRemoteGATTService/getCharacteristic
  ///
  /// - https://webbluetoothcg.github.io/web-bluetooth/#dom-bluetoothremotegattservice-getcharacteristic
  ///
  Future<WebBluetoothRemoteGATTCharacteristic> getCharacteristic(
          final String characteristicUUID) async =>
      await _getCharacteristic(characteristicUUID.toLowerCase().toJS).toDart;

  ///
  /// Check to see if the [getCharacteristics] function exists on the js object.
  ///
  /// It may not exist on some browsers.
  ///
  /// See:
  ///
  /// - [getCharacteristics]
  ///
  bool hasGetCharacteristicsFunction() => has("getCharacteristics");

  @JS("getCharacteristics")
  external JSPromise<JSArray<WebBluetoothRemoteGATTCharacteristic>>
      _getCharacteristics([final JSString? characteristicUUID]);

  ///
  /// Get a characteristic from this service.
  ///
  /// Currently no browser supports this function yet.
  ///
  /// [characteristicUUID] according to the docs this value is optional, but I
  /// can't find what would it would do if you set it anyways.
  ///
  /// - May throw [NativeAPINotImplementedError] if the function does not exist.
  ///
  /// - May throw SecurityError if the characteristic's UUID is on a blocklist.
  ///
  /// - May throw NetworkError if the GATT server is not connected.
  ///
  /// - May throw InvalidStateError if service is `null`.
  ///
  /// - May throw NotFoundError if the characteristic was not found.
  ///
  /// **NOTE:** Some characteristics are on a block list, and are thus not available.
  /// The complete blocklist can be found here:
  /// https://github.com/WebBluetoothCG/registries/blob/master/gatt_blocklist.txt
  ///
  /// See:
  ///
  /// - [hasGetCharacteristicsFunction]
  ///
  /// - [getCharacteristic]
  ///
  /// - https://developer.mozilla.org/en-US/docs/Web/API/BluetoothRemoteGATTService/getCharacteristics
  ///
  /// - https://webbluetoothcg.github.io/web-bluetooth/#dom-bluetoothremotegattservice-getcharacteristics
  ///
  Future<List<WebBluetoothRemoteGATTCharacteristic>> getCharacteristics(
      [final String? characteristicUUID]) async {
    if (!hasGetCharacteristicsFunction()) {
      throw NativeAPINotImplementedError(
          "BluetoothRemoteGATTService.getCharacteristics");
    }
    final argument = characteristicUUID?.toLowerCase().toJS;
    if (argument == null) {
      return (await _getCharacteristics().toDart).toDart;
    } else {
      return (await _getCharacteristics(argument).toDart).toDart;
    }
  }

  ///
  /// Check to see if the [getIncludedService] function exists on the js object.
  ///
  /// The function will not exists if the current service doesn't have any
  /// included services.
  ///
  /// See:
  ///
  /// - [getIncludedService]
  ///
  bool hasGetIncludedServiceFunction() => has("getIncludedService");

  @JS("getIncludedService")
  external JSPromise<WebBluetoothRemoteGATTService> _getIncludedService(
      final JSString serviceUUID);

  ///
  /// Get an included service from this service.
  ///
  /// This function doesn't exist if the current service has no included services.
  /// Check [hasGetIncludedServiceFunction] to make sure.
  ///
  /// [serviceUUID] is the UUID (lower case) of the service to get.
  ///
  /// - May throw [NativeAPINotImplementedError] if the function does not exist.
  ///
  /// - May throw SecurityError if the service's UUID is on a blocklist.
  ///
  /// - May throw NetworkError if the GATT server is not connected.
  ///
  /// - May throw InvalidStateError if service is `null`.
  ///
  /// - May throw NotFoundError if the service was not found.
  ///
  /// **NOTE:** Some services are on a block list, and are thus not available.
  /// The complete blocklist can be found here:
  /// https://github.com/WebBluetoothCG/registries/blob/master/gatt_blocklist.txt
  ///
  /// See:
  ///
  /// - [hasGetIncludedServiceFunction]
  ///
  /// ignore: deprecated_member_use_from_same_package
  /// - [getIncludedServices]
  ///
  /// - https://webbluetoothcg.github.io/web-bluetooth/#dom-bluetoothremotegattservice-getincludedservice
  ///
  Future<WebBluetoothRemoteGATTService> getIncludedService(
      final String serviceUUID) async {
    if (!hasGetIncludedServiceFunction()) {
      throw NativeAPINotImplementedError("getIncludedService");
    }
    return await _getIncludedService(serviceUUID.toLowerCase().toJS).toDart;
  }

  ///
  /// ignore: deprecated_member_use_from_same_package
  /// Check to see if the [getIncludedServices] function exists on the js object.
  ///
  /// It may not exist on some browsers.
  ///
  /// The function will not exists if the current service doesn't have any
  /// included services.
  ///
  /// See:
  ///
  /// ignore: deprecated_member_use_from_same_package
  /// - [getIncludedServices]
  ///
  bool hasGetIncludedServicesFunction() => has("getIncludedServices");

  @JS("getIncludedServices")
  external JSPromise<JSArray<WebBluetoothRemoteGATTService>>
      _getIncludedServices([final JSString? serviceUUID]);

  ///
  /// Get all included services from this service.
  ///
  /// Currently no browser supports this function yet.
  ///
  /// This function doesn't exist if the current service has no included services.
  /// Check [hasGetIncludedServicesFunction] to make sure.
  ///
  ///
  /// [serviceUUID] according to the docs this value is optional, but I
  /// can't find what would it would do if you set it anyways.
  ///
  /// - May throw [NativeAPINotImplementedError] if the function does not exist.
  ///
  /// - May throw SecurityError if the service's UUID is on a blocklist.
  ///
  /// - May throw NetworkError if the GATT server is not connected.
  ///
  /// - May throw InvalidStateError if service is `null`.
  ///
  /// - May throw NotFoundError if the service was not found.
  ///
  /// **NOTE:** Some services are on a block list, and are thus not available.
  /// The complete blocklist can be found here:
  /// https://github.com/WebBluetoothCG/registries/blob/master/gatt_blocklist.txt
  ///
  /// See:
  ///
  /// - [hasGetIncludedServiceFunction]
  ///
  /// ignore: deprecated_member_use_from_same_package
  /// - [getIncludedServices]
  ///
  /// - https://webbluetoothcg.github.io/web-bluetooth/#dom-bluetoothremotegattservice-getincludedservice
  ///
  @Deprecated(
      "Not really deprecated, just not implemented in any browser (yet).")
  Future<List<WebBluetoothRemoteGATTService>> getIncludedServices(
      final String? serviceUUID) async {
    if (!hasGetIncludedServicesFunction()) {
      throw NativeAPINotImplementedError("getIncludedServices");
    }
    final argument = serviceUUID?.toLowerCase().toJS;
    if (argument == null) {
      return (await _getIncludedServices().toDart).toDart;
    } else {
      return (await _getIncludedServices(argument).toDart).toDart;
    }
  }
}
