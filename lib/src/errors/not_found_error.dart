// ignore: use_string_in_part_of_directives
part of flutter_web_bluetooth;

///
/// An [Error] that is thrown if a [BluetoothService] or
/// [BluetoothCharacteristic] could not be found on a Bluetooth device.
///
/// This could happen if the [BluetoothService] isn't defined when requesting
/// the device using [FlutterWebBluetooth.requestDevice].
///
/// See: [RequestOptionsBuilder].
///
class NotFoundError extends Error {
  /// The uuid that could not be found.
  final String searchUUID;

  /// The parent service for the error message.
  final String? fromUUID;

  /// The type of what needed to be found; 'Service' or 'Characteristic'
  final String searchType;

  ///
  /// Create an error for a [BluetoothService] that could not be found.
  ///
  NotFoundError.forService(final String? searchUUID, this.fromUUID)
      : searchUUID = searchUUID ?? "UNKNOWN",
        searchType = "Service";

  ///
  /// Creat an error for a [BluetoothCharacteristic]  that could not be found.
  ///
  NotFoundError.forCharacteristic(this.searchUUID, this.fromUUID)
      : searchType = "Characteristic";

  ///
  /// Create an error for a [BluetoothDescriptor] that could not be found.
  ///
  NotFoundError.forDescriptor(final String? searchUUID, this.fromUUID)
      : searchUUID = searchUUID ?? "UNKNOWN",
        searchType = "Descriptor";

  @override
  String toString() {
    final startMessage = "No $searchType matching UUID $searchUUID found";
    if (fromUUID == null) {
      return startMessage;
    }
    return "$startMessage in Service with UUID $fromUUID.";
  }
}
