part of native_web_bluetooth;

///
/// Does not support "WebView Android"
/// https://webbluetoothcg.github.io/web-bluetooth/#bluetoothgattcharacteristic-interface
/// https://developer.mozilla.org/en-US/docs/Web/API/BluetoothRemoteGATTCharacteristic
class NativeBluetoothRemoteGATTCharacteristic {
  final Object _jsObject;
  final NativeBluetoothRemoteGATTService service;

  String? _uuid;

  String /* UUID */ get uuid {
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

  NativeBluetoothCharacteristicProperties? _properties;

  NativeBluetoothCharacteristicProperties get properties {
    final properties = _properties;
    if (properties != null) {
      return properties;
    }

    final newProperties = JSUtil.getProperty(this._jsObject, 'gatt');
    _properties =
        NativeBluetoothCharacteristicProperties._fromJSObject(newProperties);
    return _properties!;
  }

  dynamic get value {
    if (!JSUtil.hasProperty(this._jsObject, 'value')) {
      return null;
    }
    return JSUtil.getProperty(this._jsObject, 'value');
  }

  Future<NativeBluetoothRemoteGATTDescriptor> getDescriptor(
      String descriptorUUID) async {
    final promise =
        JSUtil.callMethod(this._jsObject, 'getDescriptor', [descriptorUUID]);
    final result = await JSUtil.promiseToFuture(promise);
    return NativeBluetoothRemoteGATTDescriptor._fromJSObject(result, this);
  }

  Future<List<NativeBluetoothRemoteGATTDescriptor>> getDescriptors(
      String? descriptorUUID) async {
    final promise =
        JSUtil.callMethod(this._jsObject, 'getDescriptors', [descriptorUUID]);
    final result = await JSUtil.promiseToFuture(promise);
    if (result is List) {
      final items = <NativeBluetoothRemoteGATTDescriptor>[];
      for (final item in result) {
        try {
          items.add(NativeBluetoothRemoteGATTDescriptor._fromJSObject(item, this));
        } on UnsupportedError {
          debugPrint(
              'Could not convert known device to BluetoothRemoteGATTDescriptor');
        }
      }
      return items;
    }
    return [];
  }

  Future<dynamic> readValue() async {
    final promise = JSUtil.callMethod(this._jsObject, 'readValue', []);
    final result = await JSUtil.promiseToFuture(promise);
    // TODO: convert result to a DataView.
    return result;
  }

  @Deprecated(
      'This method is technically deprecated in the Web Bluetooth spec, but not every browser supports the new `writeValueWithResponse` and `writeValueWithoutResponse` yet.')
  Future<void> writeValue(dynamic value) async {
    final promise = JSUtil.callMethod(this._jsObject, 'writeValue', [value]);
    await JSUtil.promiseToFuture(promise);
  }

  bool hasWriteValueWithResponse() {
    return JSUtil.hasProperty(this._jsObject, 'writeValueWithResponse');
  }

  bool hasWriteValueWithoutResponse() {
    return JSUtil.hasProperty(this._jsObject, 'writeValueWithoutResponse');
  }

  Future<void> writeValueWithResponse(dynamic value) async {
    if (!hasWriteValueWithResponse()) {
      throw NativeAPINotImplementedError('writeValueWithResponse');
    }
    final promise =
        JSUtil.callMethod(this._jsObject, 'writeValueWithResponse', [value]);
    await JSUtil.promiseToFuture(promise);
  }

  Future<void> writeValueWithoutResponse(dynamic value) async {
    if (!hasWriteValueWithoutResponse()) {
      throw NativeAPINotImplementedError('writeValueWithoutResponse');
    }
    final promise =
        JSUtil.callMethod(this._jsObject, 'writeValueWithoutResponse', [value]);
    await JSUtil.promiseToFuture(promise);
  }

  Future<void> startNotifications() async {
    final promise = JSUtil.callMethod(this._jsObject, 'startNotifications', []);
    await JSUtil.promiseToFuture(promise);
  }

  Future<void> stopNotifications() async {
    final promise = JSUtil.callMethod(this._jsObject, 'stopNotifications', []);
    await JSUtil.promiseToFuture(promise);
  }

  NativeBluetoothRemoteGATTCharacteristic._fromJSObject(
      this._jsObject, this.service) {
    if (!JSUtil.hasProperty(_jsObject, 'service')) {
      throw UnsupportedError('JSObject does not have service');
    }
    if (!JSUtil.hasProperty(_jsObject, 'uuid')) {
      throw UnsupportedError('JSObject does not have uuid');
    }
    if (!JSUtil.hasProperty(_jsObject, 'properties')) {
      throw UnsupportedError('JSObject does not have properties');
    }
    if (!JSUtil.hasProperty(_jsObject, 'getDescriptor')) {
      throw UnsupportedError('JSObject does not have getDescriptor');
    }
    if (!JSUtil.hasProperty(_jsObject, 'getDescriptors')) {
      throw UnsupportedError('JSObject does not have getDescriptors');
    }
    if (!JSUtil.hasProperty(_jsObject, 'readValue')) {
      throw UnsupportedError('JSObject does not have readValue');
    }
    if (!JSUtil.hasProperty(_jsObject, 'writeValue')) {
      throw UnsupportedError('JSObject does not have writeValue');
    }
    if (!JSUtil.hasProperty(_jsObject, 'startNotifications')) {
      throw UnsupportedError('JSObject does not have startNotifications');
    }
    if (!JSUtil.hasProperty(_jsObject, 'stopNotifications')) {
      throw UnsupportedError('JSObject does not have stopNotifications');
    }
  }
}
