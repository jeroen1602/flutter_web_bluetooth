part of flutter_web_bluetooth;

class BluetoothCharacteristic {
  @visibleForTesting
  BluetoothCharacteristic(this._characteristic) {
    this._characteristic.addEventListener('oncharacteristicvaluechanged',
        (event) {
      print(event);
      final data = this._characteristic.value;
      if (data != null) {
        _value.add(data);
      }
    });
  }

  WebBluetoothRemoteGATTCharacteristic _characteristic;

  String get uuid => this._characteristic.uuid;

  bool _isNotifying = false;

  bool get isNotifying => this._isNotifying;

  BehaviorSubject<ByteData> _value = BehaviorSubject();

  Stream<ByteData> get value => _value.stream;

  ByteData get lastValue => _value.value ?? ByteData(0);

  WebBluetoothCharacteristicProperties get properties =>
      this._characteristic.properties;

  ///
  /// May throw [NotSupportedError] if the operation is not allowed.
  ///
  Future<void> startNotifications() async {
    try {
      await this._characteristic.startNotifications();
      _isNotifying = true;
    } catch (e) {
      final error = e.toString().trim();
      if (error.startsWith('NotSupportedError')) {
        throw NotSupportedError(this.uuid);
      }
      throw e;
    }
  }

  ///
  /// May throw [NotSupportedError] if the operation is not allowed.
  ///
  Future<void> stopNotifications() async {
    try {
      await this._characteristic.stopNotifications();
      _isNotifying = false;
    } catch (e) {
      final error = e.toString().trim();
      if (error.startsWith('NotSupportedError')) {
        throw NotSupportedError(this.uuid);
      }
      throw e;
    }
  }

  Future<void> writeValueWithoutResponse(Uint8List data) async {
    if (this._characteristic.hasWriteValueWithoutResponse()) {
      return this._characteristic.writeValueWithoutResponse(data);
    }
    print(
        "WriteValueWithoutResponse not supported in this browser. Using writeValue instead");
    return this._characteristic.writeValue(data);
  }

  Future<void> writeValueWithResponse(Uint8List data) async {
    if (this._characteristic.hasWriteValueWithResponse()) {
      return this._characteristic.writeValueWithResponse(data);
    }
    print(
        "WriteValueWithResponse not supported in this browser. Using writeValue instead");
    return this._characteristic.writeValue(data);
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
      final value = await this._characteristic.readValue().timeout(timeout);
      this._value.add(value);
      return value;
    } catch (e) {
      final error = e.toString().trim();
      if (error.startsWith('NotSupportedError')) {
        throw NotSupportedError(this.uuid);
      }
      throw e;
    }
  }
}
