part of js_web_bluetooth;

///
/// https://webbluetoothcg.github.io/web-bluetooth/#bluetoothgattremoteserver-interface
/// https://developer.mozilla.org/en-US/docs/Web/API/BluetoothRemoteGATTServer
class NativeBluetoothRemoteGATTServer {
  final Object _jsObject;
  final WebBluetoothDevice device;

  bool get connected {
    final value = _JSUtil.getProperty(_jsObject, 'connected');
    if (value is bool) {
      return value;
    }
    return false;
  }

  Future<NativeBluetoothRemoteGATTServer> connect() async {
    final promise = _JSUtil.callMethod(_jsObject, 'connect', []);
    await _JSUtil.promiseToFuture(promise);
    return this;
  }

  void disconnect() {
    _JSUtil.callMethod(_jsObject, 'disconnect', []);
  }

  Future<WebBluetoothRemoteGATTService> getPrimaryService(
      String serviceUUID) async {
    final promise = _JSUtil.callMethod(
        _jsObject, 'getPrimaryService', [serviceUUID.toLowerCase()]);
    final result = await _JSUtil.promiseToFuture(promise);
    return WebBluetoothRemoteGATTService.fromJSObject(result, device);
  }

  Future<List<WebBluetoothRemoteGATTService>> getPrimaryServices(
      String? serviceUUID) async {
    final arguments = serviceUUID == null ? [] : [serviceUUID.toLowerCase()];
    final promise =
        _JSUtil.callMethod(_jsObject, 'getPrimaryServices', arguments);
    final result = await _JSUtil.promiseToFuture(promise);
    if (result is List) {
      final items = <WebBluetoothRemoteGATTService>[];
      for (final item in result) {
        try {
          items.add(WebBluetoothRemoteGATTService.fromJSObject(item, device));
        } catch (e) {
          if (e is UnsupportedError) {
            print(
                'flutter_web_bluetooth: Could not convert known device to BluetoothRemoteGATTService. Error: "${e.message}"');
          } else {
            rethrow;
          }
        }
      }
      return items;
    }
    return [];
  }

  NativeBluetoothRemoteGATTServer.fromJSObject(this._jsObject, this.device) {
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
