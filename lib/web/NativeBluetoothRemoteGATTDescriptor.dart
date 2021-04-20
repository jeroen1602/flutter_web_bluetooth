part of js_web_bluetooth;

///
/// https://webbluetoothcg.github.io/web-bluetooth/#bluetoothgattdescriptor-interface
/// https://developer.mozilla.org/en-US/docs/Web/API/BluetoothRemoteGATTDescriptor
class NativeBluetoothRemoteGATTDescriptor {
  final Object _jsObject;
  final NativeBluetoothRemoteGATTCharacteristic characteristic;

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

  Future<dynamic> readValue() async {
    final promise = _JSUtil.callMethod(this._jsObject, 'readValue', []);
    final result = await _JSUtil.promiseToFuture(promise);
    // TODO: convert result to a DataView.
    return result;
  }

  Future<void> writeValue(Object value) async {
    final promise = _JSUtil.callMethod(this._jsObject, 'writeValue', [value]);
    await _JSUtil.promiseToFuture(promise);
  }

  NativeBluetoothRemoteGATTDescriptor._fromJSObject(
      this._jsObject, this.characteristic) {
    if (!_JSUtil.hasProperty(_jsObject, 'characteristic')) {
      throw UnsupportedError('JSObject does not have characteristic');
    }
  }
}
