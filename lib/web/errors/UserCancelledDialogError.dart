part of js_web_bluetooth;

class UserCancelledDialogError extends DeviceNotFoundError {
  UserCancelledDialogError(String message) : super(message);

  @protected
  @override
  String get errorName => 'UserCancelledDialogError';
}
