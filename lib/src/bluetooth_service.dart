part of flutter_web_bluetooth;

class BluetoothService {
  @visibleForTesting
  BluetoothService(this._bluetoothService);

  final WebBluetoothRemoteGATTService _bluetoothService;

  String get uuid => _bluetoothService.uuid;

  bool get isPrimary {
    if (_bluetoothService.hasIsPrimary()) {
      return _bluetoothService.isPrimary;
    }
    return false; // Maybe return true?
  }

  bool get hasIncludedService =>
      _bluetoothService.hasGetIncludedServiceFunction();

  ///
  /// May throw [NotFoundError] if the service could not be found.
  /// May throw [SecurityError] if the uuid is on a blocklist.
  ///
  Future<BluetoothService> getIncludedService(String uuid) async {
    try {
      final service = await _bluetoothService.getIncludedService(uuid);
      return BluetoothService(service);
    } catch (e) {
      final error = e.toString().trim();
      if (error.startsWith("NotFoundError")) {
        throw NotFoundError.forService(uuid, this.uuid);
      } else if (error.startsWith("SecurityError")) {
        throw SecurityError(uuid, error);
      }
      throw e;
    }
  }

  ///
  /// May throw [NotFoundError] if the characteristic could not be found.
  /// May throw [SecurityError] if the uuid is on a blocklist.
  ///
  Future<BluetoothCharacteristic> getCharacteristic(String uuid) async {
    try {
      final characteristic = await _bluetoothService.getCharacteristic(uuid);
      return BluetoothCharacteristic(characteristic);
    } catch (e) {
      final error = e.toString().trim();
      if (error.startsWith("NotFoundError")) {
        throw NotFoundError.forCharacteristic(uuid, this.uuid);
      } else if (error.startsWith("SecurityError")) {
        throw SecurityError(uuid, error);
      }
      throw e;
    }
  }
}
