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

  ByteData? get value {
    if (!_JSUtil.hasProperty(this._jsObject, 'value')) {
      return null;
    }
    final result = _JSUtil.getProperty(this._jsObject, 'value');
    final data = WebBluetoothConverters.convertJSDataViewToByteData(result);
    return data;
  }

  Future<ByteData> readValue() async {
    final promise = _JSUtil.callMethod(this._jsObject, 'readValue', []);
    final result = await _JSUtil.promiseToFuture(promise);
    final data = WebBluetoothConverters.convertJSDataViewToByteData(result);
    return data;
  }

  Future<void> writeValue(Uint8List value) async {
    final data = WebBluetoothConverters.convertUint8ListToJSArrayBuffer(value);
    final promise = _JSUtil.callMethod(this._jsObject, 'writeValue', [data]);
    await _JSUtil.promiseToFuture(promise);
  }

  @visibleForTesting
  WebBluetoothRemoteGATTDescriptor.fromJSObject(
      this._jsObject, this.characteristic) {
    if (!_JSUtil.hasProperty(_jsObject, 'characteristic')) {
      throw UnsupportedError('JSObject does not have characteristic');
    }
    if (!_JSUtil.hasProperty(_jsObject, 'uuid')) {
      throw UnsupportedError('JSObject does not have uuid');
    }
    if (!_JSUtil.hasProperty(_jsObject, 'value')) {
      throw UnsupportedError('JSObject does not have value');
    }
    if (!_JSUtil.hasProperty(_jsObject, 'readValue')) {
      throw UnsupportedError('JSObject does not have readValue');
    }
    if (!_JSUtil.hasProperty(_jsObject, 'writeValue')) {
      throw UnsupportedError('JSObject does not have writeValue');
    }
  }
}
