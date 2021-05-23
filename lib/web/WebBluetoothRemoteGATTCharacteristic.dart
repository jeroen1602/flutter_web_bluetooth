part of js_web_bluetooth;

///
/// Does not support "WebView Android"
/// https://webbluetoothcg.github.io/web-bluetooth/#bluetoothgattcharacteristic-interface
/// https://developer.mozilla.org/en-US/docs/Web/API/BluetoothRemoteGATTCharacteristic
class WebBluetoothRemoteGATTCharacteristic {
  final Object _jsObject;
  final WebBluetoothRemoteGATTService service;

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

  WebBluetoothCharacteristicProperties? _properties;

  WebBluetoothCharacteristicProperties get properties {
    final properties = _properties;
    if (properties != null) {
      return properties;
    }

    final newProperties = _JSUtil.getProperty(this._jsObject, 'properties');
    _properties =
        WebBluetoothCharacteristicProperties.fromJSObject(newProperties);
    return _properties!;
  }

  ByteData? get value {
    if (!_JSUtil.hasProperty(this._jsObject, 'value')) {
      return null;
    }
    final data = _JSUtil.getProperty(this._jsObject, 'value');
    if (data == null) {
      return null;
    }
    return WebBluetoothConverters.convertJSDataViewToByteData(data);
  }

  Future<WebBluetoothRemoteGATTDescriptor> getDescriptor(
      String descriptorUUID) async {
    final promise =
        _JSUtil.callMethod(this._jsObject, 'getDescriptor', [descriptorUUID]);
    final result = await _JSUtil.promiseToFuture(promise);
    return WebBluetoothRemoteGATTDescriptor.fromJSObject(result, this);
  }

  Future<List<WebBluetoothRemoteGATTDescriptor>> getDescriptors(
      String? descriptorUUID) async {
    final arguments = descriptorUUID == null ? [] : [descriptorUUID];
    final promise =
        _JSUtil.callMethod(this._jsObject, 'getDescriptors', arguments);
    final result = await _JSUtil.promiseToFuture(promise);
    if (result is List) {
      final items = <WebBluetoothRemoteGATTDescriptor>[];
      for (final item in result) {
        try {
          items.add(WebBluetoothRemoteGATTDescriptor.fromJSObject(item, this));
        } catch (e) {
          if (e is UnsupportedError) {
            print(
                'flutter_web_bluetooth: Could not convert known device to BluetoothRemoteGATTDescriptor. Error: "${e.message}"');
          } else {
            throw e;
          }
        }
      }
      return items;
    }
    return [];
  }

  Future<ByteData> readValue() async {
    final promise = _JSUtil.callMethod(this._jsObject, 'readValue', []);
    final result = await _JSUtil.promiseToFuture(promise);
    final data = WebBluetoothConverters.convertJSDataViewToByteData(result);
    return data;
  }

  @Deprecated(
      'This method is technically deprecated in the Web Bluetooth spec, '
      'but not every browser supports the new `writeValueWithResponse` '
      'and `writeValueWithoutResponse` yet.')
  Future<void> writeValue(Uint8List value) async {
    final data = WebBluetoothConverters.convertUint8ListToJSArrayBuffer(value);
    final promise = _JSUtil.callMethod(this._jsObject, 'writeValue', [data]);
    await _JSUtil.promiseToFuture(promise);
  }

  bool hasWriteValueWithResponse() {
    return _JSUtil.hasProperty(this._jsObject, 'writeValueWithResponse');
  }

  bool hasWriteValueWithoutResponse() {
    return _JSUtil.hasProperty(this._jsObject, 'writeValueWithoutResponse');
  }

  Future<void> writeValueWithResponse(Uint8List value) async {
    if (!hasWriteValueWithResponse()) {
      throw NativeAPINotImplementedError('writeValueWithResponse');
    }
    final data = WebBluetoothConverters.convertUint8ListToJSArrayBuffer(value);
    final promise =
        _JSUtil.callMethod(this._jsObject, 'writeValueWithResponse', [data]);
    await _JSUtil.promiseToFuture(promise);
  }

  Future<void> writeValueWithoutResponse(Uint8List value) async {
    if (!hasWriteValueWithoutResponse()) {
      throw NativeAPINotImplementedError('writeValueWithoutResponse');
    }
    final data = WebBluetoothConverters.convertUint8ListToJSArrayBuffer(value);
    final promise =
        _JSUtil.callMethod(this._jsObject, 'writeValueWithoutResponse', [data]);
    await _JSUtil.promiseToFuture(promise);
  }

  Future<void> startNotifications() async {
    final promise =
        _JSUtil.callMethod(this._jsObject, 'startNotifications', []);
    await _JSUtil.promiseToFuture(promise);
  }

  Future<void> stopNotifications() async {
    final promise = _JSUtil.callMethod(this._jsObject, 'stopNotifications', []);
    await _JSUtil.promiseToFuture(promise);
  }

  void addEventListener(String type, void Function(dynamic) listener) {
    _JSUtil.callMethod(
        _jsObject, 'addEventListener', [type, _JSUtil.allowInterop(listener)]);
  }

  WebBluetoothRemoteGATTCharacteristic.fromJSObject(
      this._jsObject, this.service) {
    if (!_JSUtil.hasProperty(_jsObject, 'service')) {
      throw UnsupportedError('JSObject does not have service');
    }
    if (!_JSUtil.hasProperty(_jsObject, 'uuid')) {
      throw UnsupportedError('JSObject does not have uuid');
    }
    if (!_JSUtil.hasProperty(_jsObject, 'properties')) {
      throw UnsupportedError('JSObject does not have properties');
    }
    if (!_JSUtil.hasProperty(_jsObject, 'getDescriptor')) {
      throw UnsupportedError('JSObject does not have getDescriptor');
    }
    if (!_JSUtil.hasProperty(_jsObject, 'getDescriptors')) {
      throw UnsupportedError('JSObject does not have getDescriptors');
    }
    if (!_JSUtil.hasProperty(_jsObject, 'readValue')) {
      throw UnsupportedError('JSObject does not have readValue');
    }
    if (!_JSUtil.hasProperty(_jsObject, 'writeValue')) {
      throw UnsupportedError('JSObject does not have writeValue');
    }
    if (!_JSUtil.hasProperty(_jsObject, 'startNotifications')) {
      throw UnsupportedError('JSObject does not have startNotifications');
    }
    if (!_JSUtil.hasProperty(_jsObject, 'stopNotifications')) {
      throw UnsupportedError('JSObject does not have stopNotifications');
    }
    if (!_JSUtil.hasProperty(_jsObject, 'addEventListener')) {
      throw UnsupportedError('JSObject does not have addEventListener');
    }
  }
}
