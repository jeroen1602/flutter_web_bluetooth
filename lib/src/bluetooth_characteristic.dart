part of flutter_web_bluetooth;

///
/// A Bluetooth low energy characteristic. This is where the actual data
/// of the device is stored and how you send or receive data from the device.
///
/// Read the [properties] value to see what this characteristic is capable of!
/// Not all characteristics are the same.
///
/// See [BluetoothDefaultCharacteristicUUIDS] for a list of default UUIDS
/// provided in the Bluetooth low energy specification.
///
/// You can get a [BluetoothCharacteristic] by calling
/// [BluetoothService.getCharacteristic].
///
class BluetoothCharacteristic {
  ///
  /// A constructor for a new characteristic.
  ///
  /// **This should only be done by the library or if you're testing.**
  ///
  /// To get an instance use [BluetoothService.getCharacteristic].
  ///
  BluetoothCharacteristic(this._characteristic)
      : _properties =
            BluetoothCharacteristicProperties(_characteristic.properties) {
    _characteristic.addEventListener("characteristicvaluechanged",
        (final event) {
      final data = _characteristic.value;
      if (data != null) {
        _value.add(data);
      }
    });
  }

  final WebBluetoothRemoteGATTCharacteristic _characteristic;

  ///
  /// The uuid of the characteristic
  ///
  String get uuid => _characteristic.uuid;

  bool _isNotifying = false;

  ///
  /// Check to see if the current characteristic is notifying.
  ///
  bool get isNotifying => _isNotifying;

  final WebBehaviorSubject<ByteData> _value = WebBehaviorSubject<ByteData>();

  ///
  /// A [Stream] of [ByteData] with the values read from the
  /// [BluetoothCharacteristic].
  ///
  /// This [Stream] will update if [isNotifying] is `true` and the Bluetooth
  /// device notifies of a new value.
  ///
  /// It will also be updated with the value returned from [readValue].
  ///
  Stream<ByteData> get value => _value.stream;

  ///
  /// Get the last value retrieved from the [BluetoothCharacteristic].
  ///
  /// Will return an empty [ByteData] with the length of 0 if no value has been
  /// retrieved yet.
  ///
  ByteData get lastValue => _value.value ?? ByteData(0);

  final BluetoothCharacteristicProperties _properties;

  ///
  /// Get the properties of the [BluetoothCharacteristic]. This will contain
  /// the properties of what the [BluetoothCharacteristic] does and doesn't
  /// support.
  ///
  /// See [hasProperties] or [BluetoothCharacteristicProperties.hasProperties]
  /// to see if the current browser has properties implemented
  ///
  BluetoothCharacteristicProperties get properties => _properties;

  ///
  /// Check to see if [properties] has any properties at all. Some browsers
  /// don't have this feature implemented yet.
  ///
  /// If this is `false` then reading any of the properties will also return
  /// `false`. It will not throw any errors.
  ///
  bool get hasProperties => properties.hasProperties;

  ///
  /// Return a [BluetoothDescriptor] for this characteristic.
  ///
  /// [descriptorUUID] the UUID of the descriptor.
  ///
  /// - May throw [SecurityError] if the UUID is on a blocklist.
  ///
  /// - May throw [NetworkError] if the device is not connected or if
  /// there is an error with the communication.
  ///
  /// - May throw [StateError] if the characteristic is null.
  ///
  /// - May throw [NotFoundError] if the descriptor could not be found.
  ///
  /// See: [BluetoothDescriptor].
  ///
  Future<BluetoothDescriptor> getDescriptor(final String descriptorUUID) async {
    try {
      final descriptor = await _characteristic.getDescriptor(descriptorUUID);
      return BluetoothDescriptor(descriptor);
    } catch (e) {
      final error = e.toString().trim();
      if (error.startsWith("NetworkError")) {
        throw NetworkError.withUUid(uuid);
      } else if (error.startsWith("SecurityError")) {
        throw SecurityError(uuid, error);
      } else if (error.startsWith("InvalidStateError")) {
        throw StateError("Characteristic is null");
      } else if (error.startsWith("NotFoundError")) {
        throw NotFoundError.forDescriptor(descriptorUUID, uuid);
      }
      rethrow;
    }
  }

  ///
  /// Return a list [BluetoothDescriptor]s for this characteristic.
  ///
  /// - May throw [SecurityError] if the UUID is on a blocklist.
  ///
  /// - May throw [NetworkError] if the device is not connected or if
  /// there is an error with the communication.
  ///
  /// - May throw [StateError] if the characteristic is null.
  ///
  /// - May throw [NotFoundError] if the descriptor could not be found.
  ///
  /// See: [BluetoothDescriptor].
  ///
  Future<List<BluetoothDescriptor>> getDescriptors() async {
    try {
      final descriptors = await _characteristic.getDescriptors();
      return descriptors.map(BluetoothDescriptor.new).toList();
    } catch (e) {
      final error = e.toString().trim();
      if (error.startsWith("NetworkError")) {
        throw NetworkError.withUUid(uuid);
      } else if (error.startsWith("SecurityError")) {
        throw SecurityError(uuid, error);
      } else if (error.startsWith("InvalidStateError")) {
        throw StateError("Characteristic is null");
      } else if (error.startsWith("NotFoundError")) {
        throw NotFoundError.forDescriptor("ALL", uuid);
      }
      rethrow;
    }
  }

  ///
  /// Request the [BluetoothCharacteristic] to start notifying. This means that
  /// the Bluetooth device will give an event everytime that the value of the
  /// characteristic changes.
  ///
  /// - May throw [NotSupportedError] if the operation is not allowed.
  /// Check [properties] to see if it is supported.
  ///
  /// - May throw [SecurityError] if the characteristic is blocked from reading
  /// using the blocklist.
  ///
  /// - May throw [NetworkError] if the device is not connected or if
  /// there is an error with the communication.
  ///
  /// - May throw [StateError] if the characteristic is null.
  ///
  /// See: [stopNotifications], [isNotifying], [value] and [lastValue].
  ///
  Future<void> startNotifications() async {
    try {
      await _characteristic.startNotifications();
      _isNotifying = true;
    } catch (e) {
      final error = e.toString().trim();
      if (error.startsWith("NotSupportedError")) {
        throw NotSupportedError(uuid);
      } else if (error.startsWith("NetworkError")) {
        throw NetworkError.withUUid(uuid);
      } else if (error.startsWith("SecurityError")) {
        throw SecurityError(uuid, error);
      } else if (error.startsWith("InvalidStateError")) {
        throw StateError("Characteristic is null");
      }
      rethrow;
    }
  }

  ///
  /// Request the [BluetoothCharacteristic] to stop notifying. This means that
  /// you will not long get notifications of changes to the value.
  ///
  /// - May throw [StateError] if the characteristic is null.
  ///
  /// See: [startNotifications], [isNotifying], [value] and [lastValue].
  ///
  Future<void> stopNotifications() async {
    try {
      await _characteristic.stopNotifications();
      _isNotifying = false;
    } catch (e) {
      final error = e.toString().trim();
      if (error.startsWith("InvalidStateError")) {
        throw StateError("Characteristic is null");
      }
      rethrow;
    }
  }

  ///
  /// Write a new value to the characteristic without waiting for a response
  /// from the Bluetooth device.
  ///
  /// This means that the data that is written may not reach the device and
  /// you won't know about it.
  /// It's a bit like UDP.
  ///
  /// - May throw [NotSupportedError] if the operation is not allowed.
  /// Check [properties] to see if it is supported.
  ///
  /// - May throw [NetworkError] if the device is not connected or if
  /// there is an error with the communication.
  ///
  /// - May throw [StateError] if the characteristic is null.
  ///
  /// ignore: deprecated_member_use_from_same_package
  /// - Will call [WebBluetoothRemoteGATTCharacteristic.writeValue] if
  /// [WebBluetoothRemoteGATTCharacteristic.writeValueWithoutResponse] is not
  /// supported on the browser.
  ///
  /// See: [writeValueWithResponse].
  ///
  Future<void> writeValueWithoutResponse(final Uint8List data) async {
    try {
      if (_characteristic.hasWriteValueWithoutResponse()) {
        return _characteristic.writeValueWithoutResponse(data);
      }
      webBluetoothLogger.info(
          "WriteValueWithoutResponse not supported in this browser. "
          "Using writeValue instead",
          null,
          StackTrace.current);
      // ignore: deprecated_member_use_from_same_package
      return _characteristic.writeValue(data);
    } catch (e) {
      final error = e.toString().trim();
      if (error.startsWith("NotSupportedError")) {
        throw NotSupportedError(uuid);
      } else if (error.startsWith("NetworkError")) {
        throw NetworkError.withUUid(uuid);
      } else if (error.startsWith("InvalidStateError")) {
        throw StateError("Characteristic is null");
      }
      rethrow;
    }
  }

  ///
  /// Write a new value to the characteristic **with** waiting for a response
  /// from the Bluetooth device.
  ///
  /// This means that the the [Future] will only return if the device has
  /// acknowledged that it has received the data. (or a timeout is reached).
  /// It's a bit like TCP.
  ///
  /// - May throw [NotSupportedError] if the operation is not allowed.
  /// Check [properties] to see if it is supported.
  ///
  /// - May throw [NetworkError] if the device is not connected or if
  /// there is an error with the communication.
  ///
  /// - May throw [StateError] if the characteristic is null.
  ///
  /// ignore: deprecated_member_use_from_same_package
  /// Will call [WebBluetoothRemoteGATTCharacteristic.writeValue] if
  /// [WebBluetoothRemoteGATTCharacteristic.writeValueWithoutResponse] is not
  /// supported on the browser.
  ///
  /// See: [writeValueWithResponse].
  ///
  Future<void> writeValueWithResponse(final Uint8List data) async {
    try {
      if (_characteristic.hasWriteValueWithResponse()) {
        return _characteristic.writeValueWithResponse(data);
      }
      webBluetoothLogger.info(
          "WriteValueWithResponse not supported in this browser. "
          "Using writeValue instead",
          null,
          StackTrace.current);
      // ignore: deprecated_member_use_from_same_package
      return _characteristic.writeValue(data);
    } catch (e) {
      final error = e.toString().trim();
      if (error.startsWith("NotSupportedError")) {
        throw NotSupportedError(uuid);
      } else if (error.startsWith("NetworkError")) {
        throw NetworkError.withUUid(uuid);
      } else if (error.startsWith("InvalidStateError")) {
        throw StateError("Characteristic is null");
      }
      rethrow;
    }
  }

  ///
  /// Will read the value of the characteristic.
  /// The value read will be returned and also added to the [value] stream.
  ///
  /// - May throw [NotSupportedError] if the operation is not allowed.
  /// Check [properties] to see if it is supported.
  ///
  /// - May throw [SecurityError] if the characteristic is blocked from reading
  /// using the blocklist.
  ///
  /// - May throw [NetworkError] if the device is not connected or if
  /// there is an error with the communication.
  ///
  /// - May throw [TimeoutException] if the timeout expires.
  ///
  /// - May throw [StateError] if the characteristic is null.
  ///
  /// See: [value] and [lastValue].
  ///
  Future<ByteData> readValue(
      {final Duration timeout = const Duration(seconds: 5)}) async {
    try {
      final value = await _characteristic.readValue().timeout(timeout);
      _value.add(value);
      return value;
    } catch (e) {
      final error = e.toString().trim();
      if (error.startsWith("NotSupportedError")) {
        throw NotSupportedError(uuid);
      } else if (error.startsWith("NetworkError")) {
        throw NetworkError.withUUid(uuid);
      } else if (error.startsWith("SecurityError")) {
        throw SecurityError(uuid, error);
      } else if (error.startsWith("InvalidStateError")) {
        throw StateError("Characteristic is null");
      }
      rethrow;
    }
  }
}
