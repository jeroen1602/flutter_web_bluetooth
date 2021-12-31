part of flutter_web_bluetooth;

///
/// An [Error] that is thrown if a specific [BluetoothService] or
/// [BluetoothCharacteristic] is on a blocklist.
///
/// This blocklist is defined by the Web Bluetooth authors and may differ
/// between browsers and versions of these browsers.
///
class SecurityError extends Error {
  static final _urlReg = RegExp(r"https?:\/\/\S+");

  /// The uuid of the [BluetoothService] or [BluetoothCharacteristic].
  final String uuid;

  /// A possible url that links to an explanation as to why this happened.
  String? url;

  ///
  /// Create a new instance.
  ///
  /// [originalMessage] is the original message of the error thrown by the
  /// browser.
  SecurityError(this.uuid, String originalMessage) {
    final match = _urlReg.firstMatch(originalMessage);
    if (match != null) {
      final parsed = Uri.tryParse(originalMessage, match.start, match.end);
      url = parsed?.toString();
    }
  }

  @override
  String toString() {
    return 'SecurityError Tried getting blocklisted UUID ($uuid). ${url ?? ''}';
  }
}
