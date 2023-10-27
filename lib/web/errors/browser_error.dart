part of "../../js_web_bluetooth.dart";

///
/// This error is the base error for any error that the browser may throw.
/// It exists because browser errors are just strings and thus won't have
/// any nice Dart features. It has for example no stack trace.
class BrowserError extends Error {
  ///
  /// The error message.
  ///
  final String message;

  ///
  /// Create a new [BrowserError]. Normally the message would be the original
  /// js error converted to a string.
  BrowserError(this.message) : super();

  ///
  /// A protected value for the sub classes to change the [errorName] for the
  /// [toString] function.
  ///
  @protected
  String get errorName => "BrowserError";

  @override
  String toString() => "$errorName: $message";
}
