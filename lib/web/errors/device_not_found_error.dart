part of js_web_bluetooth;

///
/// An [Error] that is thrown if no device could be found to match the
/// [RequestOptions]. For [Bluetooth.requestDevice].
///
class DeviceNotFoundError extends BrowserError {
  ///
  /// Create an instance of the error with the message of the error.
  ///
  DeviceNotFoundError(super.message);

  ///
  /// A protected value for the sub classes to change the [errorName] for the
  /// [toString] function.
  ///
  @override
  @protected
  String get errorName => "DeviceNotFoundError";
}
