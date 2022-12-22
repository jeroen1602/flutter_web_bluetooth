// ignore: avoid_web_libraries_in_flutter
import "dart:html";

class WebHelpers {
  static const _httpsPort = int.fromEnvironment("httpsPort", defaultValue: -1);

  static bool get isSecureContext {
    return window.location.protocol.startsWith("https") == true ||
        window.location.hostname == "localhost" ||
        (window.location.hostname?.startsWith("127.") ?? false) ||
        window.location.hostname == "[::1]";
  }

  static void redirectToHttps() {
    if (!isSecureContext) {
      window.console.log("Redirecting to https...");
      final url = window.location;
      url.protocol = "https:";
      if (_httpsPort > 0) {
        url.port = _httpsPort.toRadixString(10);
      }
      window.location = url;
    }
  }
}
