part of flutter_web_bluetooth;

///
/// A Bluetooth low energy service. this can be primary or secondary.
/// A service contains one or more [BluetoothCharacteristic]s.
///
/// See [BluetoothDefaultServiceUUIDS] for a list of default UUIDS provided in
/// the Bluetooth low energy specification.
///
/// You get get a [BluetoothService] by calling
/// [BluetoothDevice.discoverServices] or getting them from the
/// [BluetoothDevice.services] stream.
///
class BluetoothService {
  ///
  /// A constructor for a new service.
  ///
  /// **This should only be done by the library or if you're testing.**
  ///
  /// To get an instance use [BluetoothDevice.discoverServices] or the
  /// [BluetoothDevice.services] stream.
  ///
  BluetoothService(this._bluetoothService);

  final WebBluetoothRemoteGATTService _bluetoothService;

  ///
  /// The uuid of the service
  ///
  String get uuid => _bluetoothService.uuid;

  ///
  /// Check to see if the service is a primary service (top level).
  ///
  /// Some browsers don't support this yet, in that case it will return `false`.
  ///
  bool get isPrimary {
    if (_bluetoothService.hasIsPrimary()) {
      return _bluetoothService.isPrimary;
    }
    return false; // Maybe return true?
  }

  ///
  /// Check to see if the [getIncludedService] method exists for this service.
  ///
  /// Some browsers don't support this method yet so use this to not run into
  /// any [Error]s.
  ///
  bool get hasIncludedService =>
      _bluetoothService.hasGetIncludedServiceFunction();

  ///
  /// Get an included service (secondary) service form this service.
  ///
  /// [uuid] the uuid of the included Service.
  ///
  /// Not all browsers support this feature yet, so check [hasIncludedService]
  /// first.
  ///
  /// - May throw [NotFoundError] if the service could not be found.
  ///
  /// - May throw [SecurityError] if the uuid is on a blocklist.
  ///
  /// - May throw [NetworkError] if the device is not connected or if
  /// there is an error with the communication.
  ///
  /// - May throw [StateError] if the service is null.
  ///
  /// - May throw [NativeAPINotImplementedError] if the method is not implemented
  /// for this browser. Check [hasIncludedService] to make sure you don't get
  /// this error.
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
      } else if (error.startsWith('NetworkError')) {
        throw NetworkError.withUUid(uuid);
      } else if (error.startsWith('InvalidStateError')) {
        throw StateError("Service is null");
      }
      rethrow;
    }
  }

  ///
  /// Get a characteristic from this service.
  ///
  /// [uuid] the uuid of the characteristic.
  ///
  /// - May throw [NotFoundError] if the characteristic could not be found.
  ///
  /// - May throw [SecurityError] if the uuid is on a blocklist.
  ///
  /// - May throw [NetworkError] if the device is not connected or if
  /// there is an error with the communication.
  ///
  /// - May throw [StateError] if the service is null.
  ///
  Future<BluetoothCharacteristic> getCharacteristic(String uuid) async {
    try {
      final characteristic = await _bluetoothService.getCharacteristic(uuid);
      return BluetoothCharacteristic(characteristic);
    } catch (e) {
      final error = e.toString().trim();
      if (error.startsWith("NotFoundError")) {
        throw NotFoundError.forService(uuid, this.uuid);
      } else if (error.startsWith("SecurityError")) {
        throw SecurityError(uuid, error);
      } else if (error.startsWith('NetworkError')) {
        throw NetworkError.withUUid(uuid);
      } else if (error.startsWith('InvalidStateError')) {
        throw StateError("Service is null");
      }
      rethrow;
    }
  }

  ///
  /// Get a list of characteristics from this service.
  ///
  /// [uuid] optional uuid.
  ///
  /// - May throw [NotFoundError] if the characteristic or service could not be found.
  ///
  /// - May throw [SecurityError] if the service or uuid is on a blacklist
  ///
  /// - May throw [NetworkError] if the device is not connected or if
  /// there is an error with the communication.
  ///
  /// - May throw [StateError] if the service is null.
  ///
  ///
  Future<List<BluetoothCharacteristic>> getCharacteristics(
      {String? uuid}) async {
    try {
      final List<WebBluetoothRemoteGATTCharacteristic> characteristic =
          await _bluetoothService.getCharacteristics(uuid);
      List<BluetoothCharacteristic> characteristics = [];
      for (final element in characteristic) {
        characteristics.add(BluetoothCharacteristic(element));
      }
      return characteristics;
    } catch (e) {
      final error = e.toString().trim();
      if (error.startsWith("NotFoundError")) {
        throw NotFoundError.forService(uuid, this.uuid);
      } else if (error.startsWith("SecurityError")) {
        throw SecurityError(this.uuid, error);
      } else if (error.startsWith('NetworkError')) {
        throw NetworkError.withUUid(uuid);
      } else if (error.startsWith('InvalidStateError')) {
        throw StateError("Service is null");
      }
      rethrow;
    }
  }
}
