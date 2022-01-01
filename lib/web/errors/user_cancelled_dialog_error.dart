part of js_web_bluetooth;

///
/// A subclass of [DeviceNotFoundError] for the case where the user has
/// cancelled the pair dialog.
///
class UserCancelledDialogError extends DeviceNotFoundError {
  ///
  /// Create an instance of the error with the message of the error.
  ///
  UserCancelledDialogError(String message) : super(message);

  @protected
  @override
  String get errorName => 'UserCancelledDialogError';
}
