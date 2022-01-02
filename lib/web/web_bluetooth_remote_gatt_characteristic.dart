part of js_web_bluetooth;

///
/// A class for calling methods and values for a [WebBluetoothRemoteGATTCharacteristic].
/// This is where reading and writing values happens.
///
/// You can get a [WebBluetoothRemoteGATTCharacteristic] from
/// [WebBluetoothRemoteGATTService.getCharacteristic], and
/// ignore: deprecated_member_use_from_same_package
/// [WebBluetoothRemoteGATTService.getCharacteristics].
///
/// See:
///
/// - https://developer.mozilla.org/en-US/docs/Web/API/BluetoothRemoteGATTCharacteristic
///
/// - https://webbluetoothcg.github.io/web-bluetooth/#bluetoothgattcharacteristic-interface
///
class WebBluetoothRemoteGATTCharacteristic {
  final Object _jsObject;

  ///
  /// The service that this characteristic belongs to.
  ///
  /// See:
  ///
  /// - https://developer.mozilla.org/en-US/docs/Web/API/BluetoothRemoteGATTCharacteristic/service
  ///
  /// - https://webbluetoothcg.github.io/web-bluetooth/#dom-bluetoothremotegattcharacteristic-service
  ///
  final WebBluetoothRemoteGATTService service;

  String? _uuid;

  ///
  /// The uuid of the characteristic.
  ///
  /// See:
  ///
  /// - https://developer.mozilla.org/en-US/docs/Web/API/BluetoothRemoteGATTCharacteristic/uuid
  ///
  /// - https://webbluetoothcg.github.io/web-bluetooth/#dom-bluetoothremotegattcharacteristic-uuid
  ///
  String get uuid {
    var uuid = _uuid;
    if (uuid != null) {
      return uuid;
    }

    uuid = _JSUtil.getProperty(_jsObject, 'uuid');
    if (uuid != null) {
      _uuid = uuid;
      return uuid;
    }
    return 'UNKNOWN';
  }

  WebBluetoothCharacteristicProperties? _properties;

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
  WebBluetoothCharacteristicProperties get properties {
    final properties = _properties;
    if (properties != null) {
      return properties;
    }

    final newProperties = _JSUtil.getProperty(_jsObject, 'properties');
    _properties =
        WebBluetoothCharacteristicProperties.fromJSObject(newProperties);
    return _properties!;
  }

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
    if (!_JSUtil.hasProperty(_jsObject, 'value')) {
      return null;
    }
    final data = _JSUtil.getProperty(_jsObject, 'value');
    if (data == null) {
      return null;
    }
    return WebBluetoothConverters.convertJSDataViewToByteData(data);
  }

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
      String descriptorUUID) async {
    final promise =
        _JSUtil.callMethod(_jsObject, 'getDescriptor', [descriptorUUID]);
    final result = await _JSUtil.promiseToFuture(promise);
    return WebBluetoothRemoteGATTDescriptor.fromJSObject(result, this);
  }

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
      [String? descriptorUUID]) async {
    final arguments = descriptorUUID == null ? [] : [descriptorUUID];
    final promise = _JSUtil.callMethod(_jsObject, 'getDescriptors', arguments);
    final result = await _JSUtil.promiseToFuture(promise);
    if (result is List) {
      final items = <WebBluetoothRemoteGATTDescriptor>[];
      for (final item in result) {
        try {
          items.add(WebBluetoothRemoteGATTDescriptor.fromJSObject(item, this));
        } catch (e, stack) {
          if (e is UnsupportedError) {
            webBluetoothLogger.severe(
                'Could not convert descriptor to BluetoothRemoteGATTDescriptor',
                e,
                stack);
          } else {
            rethrow;
          }
        }
      }
      return items;
    }
    return [];
  }

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
  Future<ByteData> readValue() async {
    final promise = _JSUtil.callMethod(_jsObject, 'readValue', []);
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
      'This method is technically deprecated in the Web Bluetooth spec, '
      'but not every browser supports the new `writeValueWithResponse` '
      'and `writeValueWithoutResponse` yet.')
  Future<void> writeValue(Uint8List value) async {
    final data = WebBluetoothConverters.convertUint8ListToJSArrayBuffer(value);
    final promise = _JSUtil.callMethod(_jsObject, 'writeValue', [data]);
    await _JSUtil.promiseToFuture(promise);
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
  bool hasWriteValueWithResponse() {
    return _JSUtil.hasProperty(_jsObject, 'writeValueWithResponse');
  }

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
  bool hasWriteValueWithoutResponse() {
    return _JSUtil.hasProperty(_jsObject, 'writeValueWithoutResponse');
  }

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
  Future<void> writeValueWithResponse(Uint8List value) async {
    if (!hasWriteValueWithResponse()) {
      throw NativeAPINotImplementedError('writeValueWithResponse');
    }
    final data = WebBluetoothConverters.convertUint8ListToJSArrayBuffer(value);
    final promise =
        _JSUtil.callMethod(_jsObject, 'writeValueWithResponse', [data]);
    await _JSUtil.promiseToFuture(promise);
  }

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
  Future<void> writeValueWithoutResponse(Uint8List value) async {
    if (!hasWriteValueWithoutResponse()) {
      throw NativeAPINotImplementedError('writeValueWithoutResponse');
    }
    final data = WebBluetoothConverters.convertUint8ListToJSArrayBuffer(value);
    final promise =
        _JSUtil.callMethod(_jsObject, 'writeValueWithoutResponse', [data]);
    await _JSUtil.promiseToFuture(promise);
  }

  ///
  /// Request the device to send notifications each time the value changes.
  ///
  /// The new value will be notified using the `oncharacteristicvaluechanged`
  /// event.
  /// You may need to use [WebBluetoothConverters.convertJSDataViewToByteData]
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
  /// - [WebBluetoothConverters.convertJSDataViewToByteData]
  ///
  /// - [value]
  ///
  /// - https://developer.mozilla.org/en-US/docs/Web/API/BluetoothRemoteGATTCharacteristic/startNotifications
  ///
  /// - https://webbluetoothcg.github.io/web-bluetooth/#dom-bluetoothremotegattcharacteristic-startnotifications
  ///
  Future<void> startNotifications() async {
    final promise = _JSUtil.callMethod(_jsObject, 'startNotifications', []);
    await _JSUtil.promiseToFuture(promise);
  }

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
  /// - [WebBluetoothConverters.convertJSDataViewToByteData]
  ///
  /// - [value]
  ///
  /// - https://developer.mozilla.org/en-US/docs/Web/API/BluetoothRemoteGATTCharacteristic/stopNotifications
  ///
  /// - https://webbluetoothcg.github.io/web-bluetooth/#dom-bluetoothremotegattcharacteristic-stopnotifications
  ///
  Future<void> stopNotifications() async {
    final promise = _JSUtil.callMethod(_jsObject, 'stopNotifications', []);
    await _JSUtil.promiseToFuture(promise);
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
  void addEventListener(String type, void Function(dynamic) listener) {
    _JSUtil.callMethod(
        _jsObject, 'addEventListener', [type, _JSUtil.allowInterop(listener)]);
  }

  ///
  /// Create a new instance from a js object.
  ///
  /// **This should only be done by the library or if you're testing.**
  ///
  /// To get an instance use [WebBluetoothRemoteGATTService.getCharacteristic],
  /// ignore: deprecated_member_use_from_same_package
  /// and [WebBluetoothRemoteGATTService.getCharacteristics].
  ///
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
