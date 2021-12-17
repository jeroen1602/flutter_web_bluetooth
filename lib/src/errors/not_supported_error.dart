part of flutter_web_bluetooth;

class NotSupportedError extends Error {
  final String uuid;

  NotSupportedError(this.uuid) : super();

  @override
  String toString() {
    return 'Operation not supported for uuid $uuid';
  }
}
