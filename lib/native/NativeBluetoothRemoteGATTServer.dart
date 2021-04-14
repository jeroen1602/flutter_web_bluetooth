part of native_web_bluetooth;

///
/// https://webbluetoothcg.github.io/web-bluetooth/#bluetoothgattremoteserver-interface
/// https://developer.mozilla.org/en-US/docs/Web/API/BluetoothRemoteGATTServer
class NativeBluetoothRemoteGATTServer {
  final Object _jsObject;
  final NativeBluetoothDevice device;

  bool get connected {
    final value = _JSUtil.getProperty(this._jsObject, 'connected');
    if (value is bool) {
      return value;
    }
    return false;
  }

  Future<NativeBluetoothRemoteGATTServer> connect() async {
    final promise = _JSUtil.callMethod(this._jsObject, 'connect', []);
    await _JSUtil.promiseToFuture(promise);
    return this;
  }

  void disconnect() {
    _JSUtil.callMethod(this._jsObject, 'disconnect', []);
  }

  Future<NativeBluetoothRemoteGATTService> getPrimaryService(
      Object serviceUUID) async {
    final promise =
        _JSUtil.callMethod(this._jsObject, 'getPrimaryService', [serviceUUID]);
    final result = await _JSUtil.promiseToFuture(promise);
    return NativeBluetoothRemoteGATTService._fromJSObject(result, this.device);
  }

  Future<List<NativeBluetoothRemoteGATTService>> getPrimaryServices(
      Object? serviceUUID) async {
    final promise =
        _JSUtil.callMethod(this._jsObject, 'getPrimaryServices', [serviceUUID]);
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

  NativeBluetoothRemoteGATTServer._fromJSObject(this._jsObject, this.device) {
    if (!_JSUtil.hasProperty(_jsObject, 'connected')) {
      throw UnsupportedError('JSObject does not have connected');
    }
    if (!_JSUtil.hasProperty(_jsObject, 'device')) {
      throw UnsupportedError('JSObject does not have device');
    }
    if (!_JSUtil.hasProperty(_jsObject, 'connect')) {
      throw UnsupportedError('JSObject does not have connect');
    }
    if (!_JSUtil.hasProperty(_jsObject, 'disconnect')) {
      throw UnsupportedError('JSObject does not have disconnect');
    }
    if (!_JSUtil.hasProperty(_jsObject, 'getPrimaryService')) {
      throw UnsupportedError('JSObject does not have getPrimaryService');
    }
    if (!_JSUtil.hasProperty(_jsObject, 'getPrimaryServices')) {
      throw UnsupportedError('JSObject does not have getPrimaryServices');
    }
  }
}
