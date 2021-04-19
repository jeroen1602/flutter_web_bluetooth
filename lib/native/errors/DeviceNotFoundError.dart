part of native_web_bluetooth;

class DeviceNotFoundError extends Error {
  final String message;

  DeviceNotFoundError(this.message) : super();

  @protected
  String get errorName => 'DeviceNotFoundError';

  @override
  String toString() => '$errorName: $message';
}
