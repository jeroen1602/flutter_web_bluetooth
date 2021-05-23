part of js_web_bluetooth;

class DeviceNotFoundError extends Error {
  final String message;

  DeviceNotFoundError(this.message) : super();

  ///
  /// A protected value for the sub classes.
  ///
  String get errorName => 'DeviceNotFoundError';

  @override
  String toString() => '$errorName: $message';
}
