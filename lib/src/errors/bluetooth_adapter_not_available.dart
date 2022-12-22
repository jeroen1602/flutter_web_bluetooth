part of flutter_web_bluetooth;

///
/// An [Error] that is thrown if there is no Bluetooth adapter available to the
/// browser.
///
/// Use [FlutterWebBluetooth.isAvailable] to avoid this error.
///
class BluetoothAdapterNotAvailable extends StateError {
  ///
  /// Create a new instance of the error with the method that the error happened
  /// in.
  BluetoothAdapterNotAvailable(final String method)
      : super('Bluetooth adapter not available for method "$method"');
}
