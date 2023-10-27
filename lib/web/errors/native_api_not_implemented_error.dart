part of "../../js_web_bluetooth.dart";

///
/// An [Error] thrown if a field/ method is not implemented in the browser.
///
/// This is for example thrown when you try to call
/// [WebBluetoothRemoteGATTCharacteristic.writeValueWithResponse] on a browser
/// that doesn't support the Bluetooth web api.
///
class NativeAPINotImplementedError extends UnsupportedError {
  ///
  /// Create a new instance of the error with the method that is not
  /// implemented.
  ///
  NativeAPINotImplementedError(final String method)
      : super("$method not supported in this user agent");
}
