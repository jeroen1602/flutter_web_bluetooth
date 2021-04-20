part of js_web_bluetooth;

///
/// https://webbluetoothcg.github.io/web-bluetooth/#bluetoothgattservice-interface
/// https://developer.mozilla.org/en-US/docs/Web/API/BluetoothRemoteGATTService
class NativeBluetoothRemoteGATTService {
  final Object _jsObject;
  final NativeBluetoothDevice device;

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

  Future<NativeBluetoothRemoteGATTCharacteristic> getCharacteristic(
      String characteristicUUID) async {
    final promise = _JSUtil.callMethod(
        this._jsObject, 'getCharacteristic', [characteristicUUID]);
    final result = await _JSUtil.promiseToFuture(promise);
    return NativeBluetoothRemoteGATTCharacteristic._fromJSObject(result, this);
  }

  bool hasGetCharacteristicsFunction() {
    return _JSUtil.hasProperty(this._jsObject, 'getCharacteristics');
  }

  Future<List<NativeBluetoothRemoteGATTCharacteristic>> getCharacteristics(
      String characteristicUUID) async {
    if (!hasGetCharacteristicsFunction()) {
      throw NativeAPINotImplementedError(
          'BluetoothRemoteGATTService.getCharacteristics');
    }
    final promise = _JSUtil.callMethod(
        this._jsObject, 'getCharacteristics', [characteristicUUID]);
    final result = await _JSUtil.promiseToFuture(promise);
    if (result is List) {
      final items = <NativeBluetoothRemoteGATTCharacteristic>[];
      for (final item in result) {
        try {
          items.add(NativeBluetoothRemoteGATTCharacteristic._fromJSObject(
              item, this));
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

  Future<NativeBluetoothRemoteGATTService> getIncludedService(
      Object serviceUUID) async {
    if (!hasGetIncludedServiceFunction()) {
      throw NativeAPINotImplementedError('getIncludedService');
    }
    final promise =
        _JSUtil.callMethod(this._jsObject, 'getIncludedService', [serviceUUID]);
    final result = await _JSUtil.promiseToFuture(promise);
    return NativeBluetoothRemoteGATTService._fromJSObject(result, this.device);
  }

  Future<List<NativeBluetoothRemoteGATTService>> getIncludedServices(
      Object? serviceUUID) async {
    final promise = _JSUtil.callMethod(
        this._jsObject, 'getIncludedServices', [serviceUUID]);
    final result = await _JSUtil.promiseToFuture(promise);
    if (result is List) {
      final items = <NativeBluetoothRemoteGATTService>[];
      for (final item in result) {
        try {
          items.add(NativeBluetoothRemoteGATTService._fromJSObject(
              item, this.device));
        } on UnsupportedError {
          debugPrint(
              'Could not convert known device to BluetoothRemoteGATTService');
        }
      }
      return items;
    }
    return [];
  }

  NativeBluetoothRemoteGATTService._fromJSObject(this._jsObject, this.device) {
    if (!_JSUtil.hasProperty(_jsObject, 'uuid')) {
      throw UnsupportedError('JSObject does not have uuid');
    }
    if (!_JSUtil.hasProperty(_jsObject, 'getCharacteristic')) {
      throw UnsupportedError('JSObject does not have getCharacteristic');
    }
    if (!_JSUtil.hasProperty(_jsObject, 'getIncludedServices')) {
      throw UnsupportedError('JSObject does not have getIncludedServices');
    }
  }
}
