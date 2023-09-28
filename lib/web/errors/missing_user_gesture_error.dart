part of js_web_bluetooth;


///
/// An error thrown if a method has not been called from a user gesture.
/// Some actions require a user gesture before they can be run. This stops
/// websites from for example showing annoying popups as soon as the user loads
/// the site
///
class MissingUserGestureError extends BrowserError {
  ///
  /// Create a new instance.
  /// [method] is the method where the error occurred.
  ///
  MissingUserGestureError(this.method) : super("\"$method\" must be called from a user gesture");

  ///
  /// The method that the error occurred in.
  ///
  final String method;

  @protected
  @override
  String get errorName => "MissingUserGestureError";
}

