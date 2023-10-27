part of "../../js_web_bluetooth.dart";

///
/// An administrator may disable Bluetooth in the browser via a policy. If this
/// is the case this error may get returned.
///
class PolicyError extends BrowserError {
  ///
  /// Create a new instance.
  /// [method] is the method where the error occurred.
  ///
  PolicyError(final String method)
      : super("The browser's policy doesn't allow the method \"$method\"");

  @protected
  @override
  String get errorName => "PolicyError";
}
