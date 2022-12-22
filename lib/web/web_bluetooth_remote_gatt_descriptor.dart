part of js_web_bluetooth;

///
/// A class for calling methods and values for a [WebBluetoothRemoteGATTDescriptor].
///
/// This is where you can find out what a characteristic's value means.
///
/// You can get a [WebBluetoothRemoteGATTDescriptor] from
/// [WebBluetoothRemoteGATTCharacteristic.getDescriptor], and
/// [WebBluetoothRemoteGATTCharacteristic.getDescriptors].
///
/// See:
///
/// - https://developer.mozilla.org/en-US/docs/Web/API/BluetoothRemoteGATTDescriptor
///
/// - https://webbluetoothcg.github.io/web-bluetooth/#bluetoothgattdescriptor-interface
///
class WebBluetoothRemoteGATTDescriptor {
  final Object _jsObject;

  ///
  /// The characteristic that this descriptor belongs to.
  ///
  /// See:
  ///
  /// - https://developer.mozilla.org/en-US/docs/Web/API/BluetoothRemoteGATTDescriptor/characteristic
  ///
  /// - https://webbluetoothcg.github.io/web-bluetooth/#dom-bluetoothremotegattdescriptor-characteristic
  ///
  final WebBluetoothRemoteGATTCharacteristic characteristic;

  String? _uuid;

  ///
  /// The uuid of the descriptor.
  ///
  /// See:
  ///
  /// - https://developer.mozilla.org/en-US/docs/Web/API/BluetoothRemoteGATTDescriptor/uuid
  ///
  /// - https://webbluetoothcg.github.io/web-bluetooth/#dom-bluetoothremotegattdescriptor-uuid
  ///
  String get uuid {
    var uuid = _uuid;
    if (uuid != null) {
      return uuid;
    }

    uuid = _JSUtil.getProperty(_jsObject, "uuid");
    if (uuid != null) {
      _uuid = uuid;
      return uuid;
    }
    return "UNKNOWN";
  }

  ///
  /// Get the last value retrieved from the [WebBluetoothRemoteGATTDescriptor].
  ///
  /// Will return `null` if no value has been retrieved yet.
  ///
  /// See:
  ///
  /// - https://developer.mozilla.org/en-US/docs/Web/API/BluetoothRemoteGATTDescriptor/value
  ///
  /// - https://webbluetoothcg.github.io/web-bluetooth/#dom-bluetoothremotegattdescriptor-value
  ///
  ByteData? get value {
    if (!_JSUtil.hasProperty(_jsObject, "value")) {
      return null;
    }
    final result = _JSUtil.getProperty(_jsObject, "value");
    if (result == null) {
      return null;
    }
    final data = WebBluetoothConverters.convertJSDataViewToByteData(result);
    return data;
  }

  ///
  /// Will read the value of the descriptor.
  /// The value read will be returned and also set as the [value] property.
  ///
  /// - May throw SecurityError if the descriptor is blocked form reading
  /// using a blocklist.
  ///
  /// - May throw NetworkError if the GATT server is not connected.
  ///
  /// - May throw InvalidStateError if descriptor is null
  ///
  /// See:
  ///
  /// - https://developer.mozilla.org/en-US/docs/Web/API/BluetoothRemoteGATTDescriptor/readValue
  ///
  /// - https://webbluetoothcg.github.io/web-bluetooth/#dom-bluetoothremotegattdescriptor-readvalue
  ///
  Future<ByteData> readValue() async {
    final promise = _JSUtil.callMethod(_jsObject, "readValue", []);
    final result = await _JSUtil.promiseToFuture(promise);
    final data = WebBluetoothConverters.convertJSDataViewToByteData(result);
    return data;
  }

  ///
  /// Will write a new value to the characteristic.
  ///
  /// This will **not** update the [WebBluetoothRemoteGATTCharacteristic.value]
  /// property.
  ///
  /// - May throw SecurityError if the characteristic is blocked form writing
  /// using a blocklist.
  ///
  /// - May throw InvalidModificationError if [value] is more than 512 bytes long.
  ///
  /// - May throw NetworkError if the GATT server is not connected.
  ///
  /// - May throw InvalidStateError if descriptor is null
  ///
  /// See:
  ///
  /// - https://developer.mozilla.org/en-US/docs/Web/API/BluetoothRemoteGATTDescriptor/writeValue
  ///
  /// - https://webbluetoothcg.github.io/web-bluetooth/#dom-bluetoothremotegattdescriptor-writevalue
  ///
  Future<void> writeValue(final Uint8List value) async {
    final data = WebBluetoothConverters.convertUint8ListToJSArrayBuffer(value);
    final promise = _JSUtil.callMethod(_jsObject, "writeValue", [data]);
    await _JSUtil.promiseToFuture(promise);
  }

  ///
  /// Create a new instance from a js object.
  ///
  /// **This should only be done by the library or if you're testing.**
  ///
  /// To get an instance use
  /// [WebBluetoothRemoteGATTCharacteristic.getDescriptor], and
  /// [WebBluetoothRemoteGATTCharacteristic.getDescriptors].
  ///
  WebBluetoothRemoteGATTDescriptor.fromJSObject(
      this._jsObject, this.characteristic) {
    if (!_JSUtil.hasProperty(_jsObject, "characteristic")) {
      throw UnsupportedError("JSObject does not have characteristic");
    }
    if (!_JSUtil.hasProperty(_jsObject, "uuid")) {
      throw UnsupportedError("JSObject does not have uuid");
    }
    if (!_JSUtil.hasProperty(_jsObject, "value")) {
      throw UnsupportedError("JSObject does not have value");
    }
    if (!_JSUtil.hasProperty(_jsObject, "readValue")) {
      throw UnsupportedError("JSObject does not have readValue");
    }
    if (!_JSUtil.hasProperty(_jsObject, "writeValue")) {
      throw UnsupportedError("JSObject does not have writeValue");
    }
  }
}
