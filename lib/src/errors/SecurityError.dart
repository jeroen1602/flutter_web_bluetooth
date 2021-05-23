part of flutter_web_bluetooth;

class SecurityError extends Error {
  static final _urlReg = RegExp(r"https?:\/\/\S+");
  final String uuid;
  String? url;

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
