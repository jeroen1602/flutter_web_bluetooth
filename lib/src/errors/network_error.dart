part of flutter_web_bluetooth;

class NetworkError extends Error {
  final String deviceId;

  NetworkError(this.deviceId);

  @override
  String toString() {
    return "Could not connect to deice ($deviceId) for unknown reason";
  }
}
