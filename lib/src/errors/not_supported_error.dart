part of flutter_web_bluetooth;

///
/// An [Error] that is throw if an operation is not supported.
///
///
/// You'll mostly find it thrown on the method in [BluetoothCharacteristic].
/// It is thrown whenever a method is not supported by the underlying characteristic.
/// For example a characteristic may not support
/// [BluetoothCharacteristic.writeValueWithResponse] if it's for reading only.
/// In that case you'll get a [NotSupportedError].
///
/// To avoid these errors firs read the [BluetoothCharacteristic.properties]
/// value to see what it does and doesn't support.
///
/// See: [WebBluetoothCharacteristicProperties]
///
class NotSupportedError extends Error {
  /// The uuid of the [BluetoothCharacteristic] that the error occurred in.
  final String uuid;

  /// Construct a new instance of the error.
  NotSupportedError(this.uuid) : super();

  @override
  String toString() => "Operation not supported for uuid $uuid";
}
