part of js_web_bluetooth;

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
class WebBluetoothRemoteGATTService {
  final Object _jsObject;

  ///
  /// The device that this gatt server belongs too.
  ///
  /// See:
  ///
  /// - https://developer.mozilla.org/en-US/docs/Web/API/BluetoothRemoteGATTService/device
  ///
  /// - https://webbluetoothcg.github.io/web-bluetooth/#dom-bluetoothremotegattservice-device
  ///
  final WebBluetoothDevice device;

  ///
  /// Check to see if the [isPrimary] exists on the js object.
  ///
  /// It may not exist on some browsers.
  ///
  /// See:
  ///
  /// - [isPrimary]
  ///
  bool hasIsPrimary() => _JSUtil.hasProperty(_jsObject, "isPrimary");

  bool? _isPrimary;

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
    var isPrimary = _isPrimary;
    if (isPrimary != null) {
      return isPrimary;
    }
    if (!hasIsPrimary()) {
      throw NativeAPINotImplementedError(
          "BluetoothRemoteGATTService.isPrimary");
    }

    isPrimary = _JSUtil.getProperty(_jsObject, "isPrimary");
    if (isPrimary != null) {
      _isPrimary = isPrimary;
      return isPrimary;
    }
    return false;
  }

  String? _uuid;

  ///
  /// The uuid of the service.
  ///
  /// See:
  ///
  /// - https://developer.mozilla.org/en-US/docs/Web/API/BluetoothRemoteGATTService/uuid
  ///
  /// - https://webbluetoothcg.github.io/web-bluetooth/#dom-bluetoothremotegattservice-uuid
  ///
  String get uuid {
    var uuid = _uuid;
    if (uuid != null) {
      return uuid;
    }

    uuid = _JSUtil.getProperty(_jsObject, "uuid");
    if (uuid != null) {
      _uuid = uuid;
      return uuid;
    }
    return "UNKNOWN";
  }

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
  /// See:
  ///
  /// - [getCharacteristics]
  ///
  /// - https://developer.mozilla.org/en-US/docs/Web/API/BluetoothRemoteGATTService/getCharacteristic
  ///
  /// - https://webbluetoothcg.github.io/web-bluetooth/#dom-bluetoothremotegattservice-getcharacteristic
  ///
  Future<WebBluetoothRemoteGATTCharacteristic> getCharacteristic(
      final String characteristicUUID) async {
    final promise = _JSUtil.callMethod(
        _jsObject, "getCharacteristic", [characteristicUUID.toLowerCase()]);
    final result = await _JSUtil.promiseToFuture(promise);
    return WebBluetoothRemoteGATTCharacteristic.fromJSObject(result, this);
  }

  ///
  /// Check to see if the [getCharacteristics] function exists on the js object.
  ///
  /// It may not exist on some browsers.
  ///
  /// See:
  ///
  /// - [getCharacteristics]
  ///
  bool hasGetCharacteristicsFunction() =>
      _JSUtil.hasProperty(_jsObject, "getCharacteristics");

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
    final arguments =
        characteristicUUID == null ? [] : [characteristicUUID.toLowerCase()];
    final promise =
        _JSUtil.callMethod(_jsObject, "getCharacteristics", arguments);
    final result = await _JSUtil.promiseToFuture(promise);
    if (result is List) {
      final items = <WebBluetoothRemoteGATTCharacteristic>[];
      for (final item in result) {
        try {
          items.add(
              WebBluetoothRemoteGATTCharacteristic.fromJSObject(item, this));
        } catch (e, stack) {
          if (e is UnsupportedError) {
            webBluetoothLogger.severe(
                "Could not convert known device to BluetoothRemoteGATTCharacteristic",
                e,
                stack);
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
  /// Check to see if the [getIncludedService] function exists on the js object.
  ///
  /// The function will not exists if the current service doesn't have any
  /// included services.
  ///
  /// See:
  ///
  /// - [getIncludedService]
  ///
  bool hasGetIncludedServiceFunction() =>
      _JSUtil.hasProperty(_jsObject, "getIncludedService");

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
    final promise = _JSUtil.callMethod(
        _jsObject, "getIncludedService", [serviceUUID.toLowerCase()]);
    final result = await _JSUtil.promiseToFuture(promise);
    return WebBluetoothRemoteGATTService.fromJSObject(result, device);
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
  bool hasGetIncludedServicesFunction() =>
      _JSUtil.hasProperty(_jsObject, "getIncludedServices");

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
    final arguments = serviceUUID == null ? [] : [serviceUUID.toLowerCase()];
    final promise =
        _JSUtil.callMethod(_jsObject, "getIncludedServices", arguments);
    final result = await _JSUtil.promiseToFuture(promise);
    if (result is List) {
      final items = <WebBluetoothRemoteGATTService>[];
      for (final item in result) {
        try {
          items.add(WebBluetoothRemoteGATTService.fromJSObject(item, device));
        } catch (e, stack) {
          if (e is UnsupportedError) {
            webBluetoothLogger.severe(
                "Could not convert included service to BluetoothRemoteGATTService",
                e,
                stack);
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
  /// Create a new instance from a js object.
  ///
  /// **This should only be done by the library or if you're testing.**
  ///
  /// To get an instance use
  /// [NativeBluetoothRemoteGATTServer.getPrimaryService],
  /// [NativeBluetoothRemoteGATTServer.getPrimaryServices],
  /// [WebBluetoothRemoteGATTService.getIncludedService], and
  /// ignore: deprecated_member_use_from_same_package
  /// [WebBluetoothRemoteGATTService.getIncludedServices].
  ///
  WebBluetoothRemoteGATTService.fromJSObject(this._jsObject, this.device) {
    if (!_JSUtil.hasProperty(_jsObject, "uuid")) {
      throw UnsupportedError("JSObject does not have uuid");
    }
    if (!_JSUtil.hasProperty(_jsObject, "getCharacteristic")) {
      throw UnsupportedError("JSObject does not have getCharacteristic");
    }
  }
}
