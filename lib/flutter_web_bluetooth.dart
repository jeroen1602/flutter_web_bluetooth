//
// A wrapper around [js_web_bluetooth] to make it more Dart friendly.
// Changes event listeners into [Stream]s and Javascript promises into
// [Future]s.
//
export "src/flutter_web_bluetooth_unsupported.dart"
    if (dart.library.js_interop) "src/flutter_web_bluetooth_web.dart";
