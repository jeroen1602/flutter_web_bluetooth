part of js_web_bluetooth;

class UserCancelledDialogError extends DeviceNotFoundError {
  UserCancelledDialogError(String message) : super(message);

  ///
  /// A protected value for the sub classes.
  ///
  @override
  String get errorName => 'UserCancelledDialogError';
}
