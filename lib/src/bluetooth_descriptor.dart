part of flutter_web_bluetooth;

class BluetoothDescriptor {
  BluetoothDescriptor(this._descriptor);

  final WebBluetoothRemoteGATTDescriptor _descriptor;

  String get uuid => _descriptor.uuid;

  ByteData? get value => _descriptor.value;

  ///
  /// May throw [NotSupportedError] if the operation is not allowed.
  ///
  Future<ByteData> readValue() async {
    try {
      return await _descriptor.readValue();
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
  Future<void> writeValue(Uint8List data) async {
    try {
      _descriptor.writeValue(data);
    } catch (e) {
      final error = e.toString().trim();
      if (error.startsWith('NotSupportedError')) {
        throw NotSupportedError(uuid);
      }
      rethrow;
    }
  }
}
