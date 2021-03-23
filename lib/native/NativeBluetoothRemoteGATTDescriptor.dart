part of native_web_bluetooth;

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

    uuid = JSUtil.getProperty(this._jsObject, 'uuid');
    if (uuid != null && uuid is String) {
      _uuid = uuid;
      return uuid;
    }
    return 'UNKNOWN';
  }

  dynamic get value {
    if (!JSUtil.hasProperty(this._jsObject, 'value')) {
      return null;
    }
    return JSUtil.getProperty(this._jsObject, 'value');
  }

  Future<dynamic> readValue() async {
    final promise = JSUtil.callMethod(this._jsObject, 'readValue', []);
    final result = await JSUtil.promiseToFuture(promise);
    // TODO: convert result to a DataView.
    return result;
  }

  Future<void> writeValue(Object value) async {
    final promise = JSUtil.callMethod(this._jsObject, 'writeValue', [value]);
    await JSUtil.promiseToFuture(promise);
  }

  NativeBluetoothRemoteGATTDescriptor._fromJSObject(
      this._jsObject, this.characteristic) {
    if (!JSUtil.hasProperty(_jsObject, 'characteristic')) {
      throw UnsupportedError('JSObject does not have characteristic');
    }
  }
}