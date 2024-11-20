part of "../js_web_bluetooth.dart";

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
@JS()
extension type WebBluetoothRemoteGATTDescriptor._(JSObject _)
    implements JSObject {
  ///
  /// The characteristic that this descriptor belongs to.
  ///
  /// See:
  ///
  /// - https://developer.mozilla.org/en-US/docs/Web/API/BluetoothRemoteGATTDescriptor/characteristic
  ///
  /// - https://webbluetoothcg.github.io/web-bluetooth/#dom-bluetoothremotegattdescriptor-characteristic
  ///
  external WebBluetoothRemoteGATTCharacteristic get characteristic;

  @JS("uuid")
  external JSString get _uuid;

  ///
  /// The uuid of the descriptor.
  ///
  /// See:
  ///
  /// - https://developer.mozilla.org/en-US/docs/Web/API/BluetoothRemoteGATTDescriptor/uuid
  ///
  /// - https://webbluetoothcg.github.io/web-bluetooth/#dom-bluetoothremotegattdescriptor-uuid
  ///
  String get uuid => _uuid.toDart;

  @JS("value")
  external JSDataView? get _value;

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
    if (_value == null || _value.isUndefinedOrNull) {
      return null;
    }
    return _value!.toDart;
  }

  @JS("readValue")
  external JSPromise<JSDataView> _readValue();

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
  Future<ByteData> readValue() async => (await _readValue().toDart).toDart;

  @JS("writeValue")
  external JSPromise _writeValue(final JSArrayBuffer value);

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
    await _writeValue(value.buffer.toJS).toDart;
  }
}
