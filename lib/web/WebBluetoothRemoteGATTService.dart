part of js_web_bluetooth;

///
/// https://webbluetoothcg.github.io/web-bluetooth/#bluetoothgattservice-interface
/// https://developer.mozilla.org/en-US/docs/Web/API/BluetoothRemoteGATTService
class WebBluetoothRemoteGATTService {
  final Object _jsObject;
  final WebBluetoothDevice device;

  bool hasIsPrimary() {
    return _JSUtil.hasProperty(this._jsObject, 'isPrimary');
  }

  bool? _isPrimary;

  bool get isPrimary {
    var isPrimary = _isPrimary;
    if (isPrimary != null) {
      return isPrimary;
    }
    if (!this.hasIsPrimary()) {
      throw NativeAPINotImplementedError(
          'BluetoothRemoteGATTService.isPrimary');
    }

    isPrimary = _JSUtil.getProperty(this._jsObject, 'isPrimary');
    if (isPrimary != null && isPrimary is bool) {
      _isPrimary = isPrimary;
      return isPrimary;
    }
    return false;
  }

  String? _uuid;

  String /* UUID */ get uuid {
    var uuid = _uuid;
    if (uuid != null) {
      return uuid;
    }

    uuid = _JSUtil.getProperty(this._jsObject, 'uuid');
    if (uuid != null && uuid is String) {
      _uuid = uuid;
      return uuid;
    }
    return 'UNKNOWN';
  }

  Future<WebBluetoothRemoteGATTCharacteristic> getCharacteristic(
      String characteristicUUID) async {
    final promise = _JSUtil.callMethod(
        this._jsObject, 'getCharacteristic', [characteristicUUID]);
    final result = await _JSUtil.promiseToFuture(promise);
    return WebBluetoothRemoteGATTCharacteristic._fromJSObject(result, this);
  }

  bool hasGetCharacteristicsFunction() {
    return _JSUtil.hasProperty(this._jsObject, 'getCharacteristics');
  }

  @Deprecated(
      'Not really deprecated, just not implemented in any browser (yet).')
  Future<List<WebBluetoothRemoteGATTCharacteristic>> getCharacteristics(
      String characteristicUUID) async {
    if (!hasGetCharacteristicsFunction()) {
      throw NativeAPINotImplementedError(
          'BluetoothRemoteGATTService.getCharacteristics');
    }
    final promise = _JSUtil.callMethod(
        this._jsObject, 'getCharacteristics', [characteristicUUID]);
    final result = await _JSUtil.promiseToFuture(promise);
    if (result is List) {
      final items = <WebBluetoothRemoteGATTCharacteristic>[];
      for (final item in result) {
        try {
          items.add(
              WebBluetoothRemoteGATTCharacteristic._fromJSObject(item, this));
        } on UnsupportedError {
          debugPrint(
              'Could not convert known device to BluetoothRemoteGATTCharacteristic');
        }
      }
      return items;
    }
    return [];
  }

  bool hasGetIncludedServiceFunction() {
    return _JSUtil.hasProperty(this._jsObject, 'getIncludedService');
  }

  // Will not exist if there are no includedServices.
  Future<WebBluetoothRemoteGATTService> getIncludedService(
      Object serviceUUID) async {
    if (!hasGetIncludedServiceFunction()) {
      throw NativeAPINotImplementedError('getIncludedService');
    }
    final promise =
        _JSUtil.callMethod(this._jsObject, 'getIncludedService', [serviceUUID]);
    final result = await _JSUtil.promiseToFuture(promise);
    return WebBluetoothRemoteGATTService.fromJSObject(result, this.device);
  }

  bool hasGetIncludedServicesFunction() {
    return _JSUtil.hasProperty(this._jsObject, 'getIncludedServices');
  }

  @Deprecated(
      'Not really deprecated, just not implemented in any browser (yet).')
  Future<List<WebBluetoothRemoteGATTService>> getIncludedServices(
      Object? serviceUUID) async {
    if (!hasGetIncludedServicesFunction()) {
      throw NativeAPINotImplementedError('getIncludedServices');
    }
    final promise = _JSUtil.callMethod(
        this._jsObject, 'getIncludedServices', [serviceUUID]);
    final result = await _JSUtil.promiseToFuture(promise);
    if (result is List) {
      final items = <WebBluetoothRemoteGATTService>[];
      for (final item in result) {
        try {
          items.add(
              WebBluetoothRemoteGATTService.fromJSObject(item, this.device));
        } on UnsupportedError {
          debugPrint(
              'Could not convert known device to BluetoothRemoteGATTService');
        }
      }
      return items;
    }
    return [];
  }

  @visibleForTesting
  WebBluetoothRemoteGATTService.fromJSObject(this._jsObject, this.device) {
    if (!_JSUtil.hasProperty(_jsObject, 'uuid')) {
      throw UnsupportedError('JSObject does not have uuid');
    }
    if (!_JSUtil.hasProperty(_jsObject, 'getCharacteristic')) {
      throw UnsupportedError('JSObject does not have getCharacteristic');
    }
  }
}
