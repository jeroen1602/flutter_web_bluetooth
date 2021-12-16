part of flutter_web_bluetooth;

class BluetoothCharacteristic {
  BluetoothCharacteristic(this._characteristic) {
    _characteristic.addEventListener('characteristicvaluechanged', (event) {
      print(event);
      final data = _characteristic.value;
      if (data != null) {
        _value.add(data);
      }
    });
  }

  final WebBluetoothRemoteGATTCharacteristic _characteristic;

  String get uuid => _characteristic.uuid;

  bool _isNotifying = false;

  bool get isNotifying => _isNotifying;

  final BehaviorSubject<ByteData> _value = BehaviorSubject();

  Stream<ByteData> get value => _value.stream;

  ByteData get lastValue => _value.valueOrNull ?? ByteData(0);

  WebBluetoothCharacteristicProperties get properties =>
      _characteristic.properties;

  ///
  /// May throw [NotSupportedError] if the operation is not allowed.
  ///
  Future<void> startNotifications() async {
    try {
      await _characteristic.startNotifications();
      _isNotifying = true;
    } catch (e) {
      final error = e.toString().trim();
      if (error.startsWith('NotSupportedError')) {
        throw NotSupportedError(uuid);
      }
      rethrow;
    }
  }

  ///
  /// May throw [NotSupportedError] if the operation is not allowed.
  ///
  Future<void> stopNotifications() async {
    try {
      await _characteristic.stopNotifications();
      _isNotifying = false;
    } catch (e) {
      final error = e.toString().trim();
      if (error.startsWith('NotSupportedError')) {
        throw NotSupportedError(uuid);
      }
      rethrow;
    }
  }

  Future<void> writeValueWithoutResponse(Uint8List data) async {
    if (_characteristic.hasWriteValueWithoutResponse()) {
      return _characteristic.writeValueWithoutResponse(data);
    }
    print(
        "WriteValueWithoutResponse not supported in this browser. Using writeValue instead");
    // ignore: deprecated_member_use_from_same_package
    return _characteristic.writeValue(data);
  }

  Future<void> writeValueWithResponse(Uint8List data) async {
    if (_characteristic.hasWriteValueWithResponse()) {
      return _characteristic.writeValueWithResponse(data);
    }
    print(
        "WriteValueWithResponse not supported in this browser. Using writeValue instead");
    // ignore: deprecated_member_use_from_same_package
    return _characteristic.writeValue(data);
  }

  ///
  /// Will read the value of the characteristic.
  /// The value read will be returned and also added to the [value] stream.
  ///
  /// May throw [NotSupportedError] if the operation is not allowed.
  /// May throw [TimeoutException] if the timeout expires.
  ///
  Future<ByteData> readValue(
      {Duration timeout = const Duration(seconds: 5)}) async {
    try {
      final value = await _characteristic.readValue().timeout(timeout);
      _value.add(value);
      return value;
    } catch (e) {
      final error = e.toString().trim();
      if (error.startsWith('NotSupportedError')) {
        throw NotSupportedError(uuid);
      }
      rethrow;
    }
  }
}
