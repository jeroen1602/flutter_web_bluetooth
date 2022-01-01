part of flutter_web_bluetooth;

///
/// An [Error] that is thrown if there ever is an error with communication
/// between the browser and the Bluetooth device.
///
class NetworkError extends Error {
  ///
  /// The id (that the browser generates) of the device.
  ///
  final String? deviceId;

  ///
  /// The uuid of the [BluetoothCharacteristic] or [BluetoothService] that
  /// has thrown the error.
  ///
  final String? uuid;

  ///
  /// Create a new instance of the error. For device id.
  ///
  NetworkError.withDeviceId(this.deviceId) : uuid = null;

  ///
  /// Create a new instance of the error. For a uuid.
  ///
  NetworkError.withUUid(this.uuid) : deviceId = null;

  @override
  String toString() {
    if (deviceId != null) {
      return "Could not connect to device ($deviceId) for unknown reason";
    }
    if (uuid != null) {
      return "Could not communicate with uuid ($uuid) for unknown reason";
    }
    return "A network error (for Bluetooth) has occurred";
  }
}
