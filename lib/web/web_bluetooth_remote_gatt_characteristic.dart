part of "../js_web_bluetooth.dart";

///
/// A class for calling methods and values for a [WebBluetoothRemoteGATTCharacteristic].
/// This is where reading and writing values happens.
///
/// You can get a [WebBluetoothRemoteGATTCharacteristic] from
/// [WebBluetoothRemoteGATTService.getCharacteristic], and
/// [WebBluetoothRemoteGATTService.getCharacteristics].
///
/// See:
///
/// - https://developer.mozilla.org/en-US/docs/Web/API/BluetoothRemoteGATTCharacteristic
///
/// - https://webbluetoothcg.github.io/web-bluetooth/#bluetoothgattcharacteristic-interface
///
@JS()
extension type WebBluetoothRemoteGATTCharacteristic._(JSObject _)
    implements EventTarget, JSObject {
  ///
  /// The service that this characteristic belongs to.
  ///
  /// See:
  ///
  /// - https://developer.mozilla.org/en-US/docs/Web/API/BluetoothRemoteGATTCharacteristic/service
  ///
  /// - https://webbluetoothcg.github.io/web-bluetooth/#dom-bluetoothremotegattcharacteristic-service
  ///
  external WebBluetoothRemoteGATTService get service;

  @JS("uuid")
  external JSString get _uuid;

  ///
  /// The uuid of the characteristic.
  ///
  /// See:
  ///
  /// - https://developer.mozilla.org/en-US/docs/Web/API/BluetoothRemoteGATTCharacteristic/uuid
  ///
  /// - https://webbluetoothcg.github.io/web-bluetooth/#dom-bluetoothremotegattcharacteristic-uuid
  ///
  String get uuid => _uuid.toDart;

  ///
  /// Get the properties of the characteristic.
  ///
  /// The properties tell you what the characteristic is and isn't able to do.
  ///
  /// See:
  ///
  /// - [WebBluetoothCharacteristicProperties]
  ///
  /// - https://developer.mozilla.org/en-US/docs/Web/API/BluetoothRemoteGATTCharacteristic/properties
  ///
  /// - https://webbluetoothcg.github.io/web-bluetooth/#dom-bluetoothremotegattcharacteristic-properties
  ///
  external WebBluetoothCharacteristicProperties get properties;

  @JS("value")
  external JSDataView? _value;

  ///
  /// Get the last value retrieved from the [WebBluetoothRemoteGATTCharacteristic].
  ///
  /// Will return `null` if no value has been retrieved yet.
  ///
  /// See:
  ///
  /// - https://developer.mozilla.org/en-US/docs/Web/API/BluetoothRemoteGATTCharacteristic/value
  ///
  /// - https://webbluetoothcg.github.io/web-bluetooth/#dom-bluetoothremotegattcharacteristic-value
  ///
  ByteData? get value {
    if (_value == null || _value.isUndefinedOrNull) {
      return null;
    }
    return _value!.toDart;
  }

  @JS("getDescriptor")
  external JSPromise<WebBluetoothRemoteGATTDescriptor> _getDescriptor(
      final JSString descriptorUUID);

  ///
  /// Return a [WebBluetoothRemoteGATTDescriptor] for this characteristic.
  ///
  /// [descriptorUUID] the UUID (lower case) of the descriptor.
  ///
  /// The descriptor describes the values stored on the characteristic.
  ///
  /// - May throw SecurityError if the descriptor's UUID is on a blocklist.
  ///
  /// - May throw NetworkError if the GATT server is not connected.
  ///
  /// - May throw InvalidStateError if characteristic is `null`.
  ///
  /// - May throw NotFoundError if the descriptor was not found.
  ///
  /// See:
  ///
  /// - [WebBluetoothRemoteGATTDescriptor]
  ///
  /// - [getDescriptors]
  ///
  /// - https://developer.mozilla.org/en-US/docs/Web/API/BluetoothRemoteGATTCharacteristic/getDescriptor
  ///
  /// - https://webbluetoothcg.github.io/web-bluetooth/#dom-bluetoothremotegattcharacteristic-getdescriptor
  ///
  Future<WebBluetoothRemoteGATTDescriptor> getDescriptor(
          final String descriptorUUID) =>
      _getDescriptor(descriptorUUID.toLowerCase().toJS).toDart;

  @JS("getDescriptors")
  external JSPromise<JSArray<WebBluetoothRemoteGATTDescriptor>> _getDescriptors(
      [final JSString? descriptorUUID]);

  ///
  /// Return a list of [WebBluetoothRemoteGATTDescriptor] for this
  /// characteristic.
  ///
  /// [descriptorUUID] according to the docs this value is optional, but I
  /// can't find what would it would do if you set it anyways.
  ///
  /// The descriptor describes the values stored on the characteristic.
  ///
  /// - May throw SecurityError if the descriptor's UUID is on a blocklist.
  ///
  /// - May throw NetworkError if the GATT server is not connected.
  ///
  /// - May throw InvalidStateError if characteristic is `null`.
  ///
  /// - May throw NotFoundError if the descriptor was not found.
  ///
  /// See:
  ///
  /// - [WebBluetoothRemoteGATTDescriptor]
  ///
  /// - [getDescriptor]
  ///
  /// - https://developer.mozilla.org/en-US/docs/Web/API/BluetoothRemoteGATTCharacteristic/getDescriptors
  ///
  /// - https://webbluetoothcg.github.io/web-bluetooth/#dom-bluetoothremotegattcharacteristic-getdescriptors
  ///
  Future<List<WebBluetoothRemoteGATTDescriptor>> getDescriptors(
      [final String? descriptorUUID]) async {
    final argument = descriptorUUID?.toLowerCase().toJS;
    if (argument == null) {
      return (await _getDescriptors().toDart).toDart;
    } else {
      return (await _getDescriptors(argument).toDart).toDart;
    }
  }

  @JS("readValue")
  external JSPromise<JSDataView> _readValue();

  ///
  /// Will read the value of the characteristic.
  /// The value read will be returned and also set as the [value] property.
  ///
  /// - May throwNotSupportedError if the operation is not allowed.
  /// Check [properties] to see if it is supported.
  ///
  /// - May throw SecurityError if the characteristic is blocked form reading
  /// using a blocklist.
  ///
  /// - May throw NetworkError if the GATT server is not connected.
  ///
  /// - May throw InvalidStateError if characteristic is null
  ///
  /// See:
  ///
  /// - https://developer.mozilla.org/en-US/docs/Web/API/BluetoothRemoteGATTCharacteristic/readValue
  ///
  /// - https://webbluetoothcg.github.io/web-bluetooth/#dom-bluetoothremotegattcharacteristic-readvalue
  ///
  Future<ByteData> readValue() async => (await _readValue().toDart).toDart;

  external JSPromise _writeValue(final JSArrayBuffer value);

  ///
  /// Will write a new value to the characteristic.
  ///
  /// This will **not** update the [WebBluetoothRemoteGATTCharacteristic.value]
  /// property.
  ///
  /// This method is deprecated, but the replacements
  /// [writeValueWithoutResponse], and [writeValueWithResponse] may not be
  /// implemented the browser.
  ///
  /// - May throw NotSupportedError if the operation is not allowed.
  /// Check [properties] to see if it is supported.
  ///
  /// - May throw SecurityError if the characteristic is blocked form writing
  /// using a blocklist.
  ///
  /// - May throw NetworkError if the GATT server is not connected.
  ///
  /// - May throw InvalidStateError if characteristic is null
  ///
  /// See:
  ///
  /// - [hasWriteValueWithoutResponse]
  ///
  /// - [writeValueWithoutResponse]
  ///
  /// - [hasWriteValueWithResponse]
  ///
  /// - [writeValueWithResponse]
  ///
  /// - https://developer.mozilla.org/en-US/docs/Web/API/BluetoothRemoteGATTCharacteristic/writeValue
  ///
  /// - https://webbluetoothcg.github.io/web-bluetooth/#dom-bluetoothremotegattcharacteristic-writevalue
  ///
  @Deprecated(
      "This method is technically deprecated in the Web Bluetooth spec, "
      "but not every browser supports the new `writeValueWithResponse` "
      "and `writeValueWithoutResponse` yet.")
  Future<void> writeValue(final Uint8List value) async {
    await _writeValue(value.buffer.toJS).toDart;
  }

  ///
  /// Check to see if the [writeValueWithResponse] function exists.
  ///
  /// See:
  ///
  /// - [hasWriteValueWithoutResponse]
  ///
  /// - [writeValueWithoutResponse]
  ///
  /// ignore: deprecated_member_use_from_same_package
  /// - [writeValue]
  ///
  /// - [writeValueWithResponse]
  ///
  bool hasWriteValueWithResponse() => has("writeValueWithResponse");

  ///
  /// Check to see if the [writeValueWithoutResponse] function exists.
  ///
  /// See:
  ///
  /// ignore: deprecated_member_use_from_same_package
  /// - [writeValue]
  ///
  /// - [writeValueWithoutResponse]
  ///
  /// - [hasWriteValueWithResponse]
  ///
  /// - [writeValueWithResponse]
  ///
  bool hasWriteValueWithoutResponse() => has("writeValueWithoutResponse");

  @JS("writeValueWithResponse")
  external JSPromise _writeValueWithResponse(final JSArrayBuffer value);

  ///
  /// Will write a new value to the characteristic.
  ///
  /// This will **not** update the [WebBluetoothRemoteGATTCharacteristic.value]
  /// property.
  ///
  /// Write a value and wait for the response of the device before continuing.
  ///
  /// This method may not be implemented in the current browser version.
  /// Check this by calling [hasWriteValueWithResponse].
  /// ignore: deprecated_member_use_from_same_package
  /// Otherwise use [writeValue].
  ///
  /// - May throw [NativeAPINotImplementedError] if the method does not exist.
  ///
  /// - May throw NotSupportedError if the operation is not allowed.
  /// Check [properties] to see if it is supported.
  ///
  /// - May throw SecurityError if the characteristic is blocked form writing
  /// using a blocklist.
  ///
  /// - May throw NetworkError if the GATT server is not connected.
  ///
  /// - May throw InvalidStateError if characteristic is null
  ///
  /// See:
  ///
  /// - [hasWriteValueWithoutResponse]
  ///
  /// - [writeValueWithoutResponse]
  ///
  /// - [hasWriteValueWithResponse]
  ///
  /// ignore: deprecated_member_use_from_same_package
  /// - [writeValue]
  ///
  /// - https://developer.mozilla.org/en-US/docs/Web/API/BluetoothRemoteGATTCharacteristic/writeValueWithResponse
  ///
  /// - https://webbluetoothcg.github.io/web-bluetooth/#dom-bluetoothremotegattcharacteristic-writevaluewithresponse
  ///
  Future<void> writeValueWithResponse(final Uint8List value) async {
    if (!hasWriteValueWithResponse()) {
      throw NativeAPINotImplementedError("writeValueWithResponse");
    }
    await _writeValueWithResponse(value.buffer.toJS).toDart;
  }

  @JS("writeValueWithoutResponse")
  external JSPromise _writeValueWithoutResponse(final JSArrayBuffer value);

  /// Will write a new value to the characteristic.
  ///
  /// This will **not** update the [WebBluetoothRemoteGATTCharacteristic.value]
  /// property.
  ///
  /// Write a value without waiting for the response of the device before
  /// continuing.
  ///
  /// This method may not be implemented in the current browser version.
  /// Check this by calling [hasWriteValueWithoutResponse].
  /// ignore: deprecated_member_use_from_same_package
  /// Otherwise use [writeValue].
  ///
  /// - May throw [NativeAPINotImplementedError] if the method does not exist.
  ///
  /// - May throw NotSupportedError if the operation is not allowed.
  /// Check [properties] to see if it is supported.
  ///
  /// - May throw SecurityError if the characteristic is blocked form writing
  /// using a blocklist.
  ///
  /// - May throw NetworkError if the GATT server is not connected.
  ///
  /// - May throw InvalidStateError if characteristic is null
  ///
  /// See:
  ///
  /// - [hasWriteValueWithoutResponse]
  ///
  /// ignore: deprecated_member_use_from_same_package
  /// - [writeValue]
  ///
  /// - [hasWriteValueWithResponse]
  ///
  /// - [writeValueWithResponse]
  ///
  /// - https://developer.mozilla.org/en-US/docs/Web/API/BluetoothRemoteGATTCharacteristic/writeValueWithoutResponse
  ///
  /// - https://webbluetoothcg.github.io/web-bluetooth/#dom-bluetoothremotegattcharacteristic-writevaluewithoutresponse
  ///
  Future<void> writeValueWithoutResponse(final Uint8List value) async {
    if (!hasWriteValueWithoutResponse()) {
      throw NativeAPINotImplementedError("writeValueWithoutResponse");
    }
    await _writeValueWithoutResponse(value.buffer.toJS).toDart;
  }

  @JS("startNotifications")
  external JSPromise<WebBluetoothRemoteGATTCharacteristic>
      _startNotifications();

  ///
  /// Request the device to send notifications each time the value changes.
  ///
  /// The new value will be notified using the `oncharacteristicvaluechanged`
  /// event.
  /// You may need to use [JSArrayBufferToByteBuffer.toDart]
  /// to get useful data.
  ///
  /// - May throw NotSupportedError if the operation is not allowed.
  /// Check [properties] to see if it is supported.
  ///
  /// - May throw SecurityError if the characteristic is blocked form notifying
  /// using a blocklist.
  ///
  /// - May throw NetworkError if the GATT server is not connected.
  ///
  /// - May throw InvalidStateError if characteristic is null
  ///
  /// See:
  ///
  /// - [stopNotifications]
  ///
  /// - [addEventListener]
  ///
  /// - [JSArrayBufferToByteBuffer.toDart]
  ///
  /// - [value]
  ///
  /// - https://developer.mozilla.org/en-US/docs/Web/API/BluetoothRemoteGATTCharacteristic/startNotifications
  ///
  /// - https://webbluetoothcg.github.io/web-bluetooth/#dom-bluetoothremotegattcharacteristic-startnotifications
  ///
  Future<void> startNotifications() async {
    await _startNotifications().toDart;
  }

  @JS("stopNotifications")
  external JSPromise<WebBluetoothRemoteGATTCharacteristic> _stopNotifications();

  ///
  /// Stop listening for notifications.
  ///
  /// - May throw InvalidStateError if characteristic is null
  ///
  /// See:
  ///
  /// - [startNotifications]
  ///
  /// - [addEventListener]
  ///
  /// - [JSArrayBufferToByteBuffer.toDart]
  ///
  /// - [value]
  ///
  /// - https://developer.mozilla.org/en-US/docs/Web/API/BluetoothRemoteGATTCharacteristic/stopNotifications
  ///
  /// - https://webbluetoothcg.github.io/web-bluetooth/#dom-bluetoothremotegattcharacteristic-stopnotifications
  ///
  Future<void> stopNotifications() async {
    await _stopNotifications().toDart;
  }

  ///
  /// Add a new event listener to the device.
  ///
  /// Marking the method with [JSUtils.allowInterop] will be done automatically
  /// for you.
  ///
  /// Events to be handled are:
  ///
  /// - oncharacteristicvaluechanged
  ///
  /// See:
  ///
  /// - [startNotifications]
  ///
  /// - https://webbluetoothcg.github.io/web-bluetooth/#characteristiceventhandlers
  ///
  JSFunction addEventListenerDart<T extends JSAny?>(
      final String type, final void Function(T) listener,
      [final AddEventListenerOptions? options]) {
    final callback = listener.toJS;
    if (options?.isDefinedAndNotNull ?? false) {
      addEventListener(type, callback, options!);
    } else {
      addEventListener(type, callback);
    }
    return callback;
  }
}
