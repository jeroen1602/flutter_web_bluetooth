part of js_web_bluetooth;

///
/// An error thrown if a permission ahs been denied by the user.
///
class PermissionError extends BrowserError {
  ///
  /// Create a new instance.
  /// [method] is the method where the error occurred.
  ///
  PermissionError(this.method) : super("Permission denied for \"$method\"");

  ///
  /// The method that the error occurred in.
  ///
  final String method;

  @protected
  @override
  String get errorName => "PermissionError";
}
