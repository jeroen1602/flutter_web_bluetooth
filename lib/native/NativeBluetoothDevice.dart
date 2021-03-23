part of native_web_bluetooth;

///
/// https://webbluetoothcg.github.io/web-bluetooth/#bluetoothdevice-interface
/// https://developer.mozilla.org/en-US/docs/Web/API/BluetoothDevice
class NativeBluetoothDevice {
  final Object _jsObject;

  String? _id;

  String get id {
    var id = _id;
    if (id != null) {
      return id;
    }
    id = JSUtil.getProperty(this._jsObject, 'id') as String;
    _id = id;
    return id;
  }

  String? _name;

  String? get name {
    var name = _name;
    if (name != null) {
      return name;
    }
    if (!JSUtil.hasProperty(this._jsObject, 'name')) {
      return null;
    }
    name = JSUtil.getProperty(this._jsObject, 'name') as String;
    _name = name;
    return name;
  }

  NativeBluetoothRemoteGATTServer? _gatt;

  NativeBluetoothRemoteGATTServer? get gatt {
    final gatt = _gatt;
    if (gatt != null) {
      return gatt;
    }
    if (!JSUtil.hasProperty(this._jsObject, 'gatt')) {
      return null;
    }
    final newGatt = JSUtil.getProperty(this._jsObject, 'gatt');
    if (newGatt != null) {
      try {
        _gatt = NativeBluetoothRemoteGATTServer._fromJSObject(newGatt, this);
      } on UnsupportedError {
        debugPrint('Could not convert JSObject to BluetoothRemoteGattServer');
      }
    }
    return _gatt;
  }

  @deprecated
  List<dynamic> get uuid {
    return JSUtil.getProperty(this._jsObject, 'uuid');
  }

  @deprecated
  Object connectGATT() {
    return Object();
  }

  // external static void addEventListener(
  //     String type, void Function(dynamic) listener);
  //
  // external static void removeEventListener(
  //     String type, void Function(dynamic) listener);

  // external factory BluetoothDevice(
  //     {String id, String? name, Object? gatt, @deprecated List<dynamic> uuid});

  NativeBluetoothDevice._fromJSObject(this._jsObject) {
    if (!JSUtil.hasProperty(_jsObject, 'id')) {
      throw UnsupportedError('JSObject does not have an id.');
    }
  }
}
