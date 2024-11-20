// ignore: avoid_web_libraries_in_flutter
import "dart:js_interop";

import "package:web/web.dart";

class WebHelpers {
  static const _httpsPort = int.fromEnvironment("httpsPort", defaultValue: -1);

  static bool get isSecureContext {
    return window.location.protocol.startsWith("https") == true ||
        window.location.hostname == "localhost" ||
        window.location.hostname.endsWith(".localhost") ||
        window.location.hostname.startsWith("127.") ||
        window.location.hostname == "[::1]";
  }

  static void redirectToHttps() {
    if (!isSecureContext) {
      console.log("Redirecting to https...".toJS);
      final url = window.location;
      url.protocol = "https:";
      if (_httpsPort > 0) {
        url.port = _httpsPort.toRadixString(10);
      }
      window.location.assign(url.toString());
    }
  }
}
