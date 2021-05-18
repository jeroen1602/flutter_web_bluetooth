part of js_web_bluetooth;

///
/// https://webbluetoothcg.github.io/web-bluetooth/#bluetoothgattdescriptor-interface
/// https://developer.mozilla.org/en-US/docs/Web/API/BluetoothRemoteGATTDescriptor
class WebBluetoothRemoteGATTDescriptor {
  final Object _jsObject;
  final WebBluetoothRemoteGATTCharacteristic characteristic;

  String? _uuid;

  String get uuid {
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

  dynamic get value {
    if (!_JSUtil.hasProperty(this._jsObject, 'value')) {
      return null;
    }
    return _JSUtil.getProperty(this._jsObject, 'value');
  }

  Future<ByteData> readValue() async {
    final promise = _JSUtil.callMethod(this._jsObject, 'readValue', []);
    final result = await _JSUtil.promiseToFuture(promise);
    return WebBluetoothConverters.convertJSDataViewToByteData(result);
  }

  Future<void> writeValue(Object value) async {
    final promise = _JSUtil.callMethod(this._jsObject, 'writeValue', [value]);
    await _JSUtil.promiseToFuture(promise);
  }

  @visibleForTesting
  WebBluetoothRemoteGATTDescriptor.fromJSObject(
      this._jsObject, this.characteristic) {
    if (!_JSUtil.hasProperty(_jsObject, 'characteristic')) {
      throw UnsupportedError('JSObject does not have characteristic');
    }
  }
}
