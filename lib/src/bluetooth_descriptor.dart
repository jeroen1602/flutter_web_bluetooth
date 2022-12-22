part of flutter_web_bluetooth;

///
/// A Bluetooth low energy descriptor. A descriptor describes the value stored
/// in the characteristic.
///
/// You can get a [BluetoothDescriptor] by calling
/// [BluetoothCharacteristic.getDescriptor] or
/// [BluetoothCharacteristic.getDescriptors].
///
class BluetoothDescriptor {
  ///
  /// A constructor for a new characteristic descriptor.
  ///
  /// **This should only be done by the library or if you're testing**
  ///
  /// To get an instance use [BluetoothCharacteristic.getDescriptor] or
  /// [BluetoothCharacteristic.getDescriptors].
  ///
  BluetoothDescriptor(this._descriptor);

  final WebBluetoothRemoteGATTDescriptor _descriptor;

  ///
  /// The uuid of the descriptor this descriptor belongs to.
  ///
  String get characteristicUUId => _descriptor.characteristic.uuid;

  ///
  /// The uuid of the descriptor
  ///
  String get uuid => _descriptor.uuid;

  ///
  /// The last read value of the descriptor. Will start out as `null`.
  ///
  ByteData? get value => _descriptor.value;

  ///
  /// Read the value of the descriptor.
  ///
  /// This will also set [value] with the same value as returned by the [Future].
  ///
  /// - May throw [SecurityError] if the descriptor is blocked from reading
  /// using the blocklist.
  ///
  /// - May throw [NetworkError] if the device is not connected or if
  /// there is an error with the communication.
  ///
  /// - May throw [StateError] if the descriptor is null.
  ///
  Future<ByteData> readValue() async {
    try {
      return await _descriptor.readValue();
    } catch (e) {
      final error = e.toString().trim();
      if (error.startsWith("NotSupportedError")) {
        throw NotSupportedError(uuid);
      } else if (error.startsWith("NetworkError")) {
        throw NetworkError.withUUid(uuid);
      } else if (error.startsWith("SecurityError")) {
        throw SecurityError(uuid, error);
      } else if (error.startsWith("InvalidStateError")) {
        throw StateError("Descriptor is null");
      }
      rethrow;
    }
  }

  ///
  /// Write a new value to the descriptor.
  ///
  /// [data] Data may not be larger than 512 bytes.
  ///
  /// - May throw [SecurityError] if the descriptor is blocked from writing
  /// using the blocklist.
  ///
  /// - May throw [NetworkError] if the device is not connected or if
  /// there is an error with the communication.
  ///
  /// - May throw [StateError] if the descriptor is null.
  ///
  ///  - May throw [StateError] if the input data is larger than 512 bytes.
  ///  TODO: use better error.
  ///
  Future<void> writeValue(final Uint8List data) async {
    try {
      _descriptor.writeValue(data);
    } catch (e) {
      final error = e.toString().trim();
      if (error.startsWith("NotSupportedError")) {
        throw NotSupportedError(uuid);
      } else if (error.startsWith("NetworkError")) {
        throw NetworkError.withUUid(uuid);
      } else if (error.startsWith("SecurityError")) {
        throw SecurityError(uuid, error);
      } else if (error.startsWith("InvalidStateError")) {
        throw StateError("Descriptor is null");
      } else if (error.startsWith("InvalidModificationError")) {
        throw StateError("Input data was larger than 512 bytes");
      }
      rethrow;
    }
  }
}
