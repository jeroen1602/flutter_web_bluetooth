//
// A wrapper around [js_web_bluetooth] to make it more Dart friendly.
// Changes event listeners into [Stream]s and Javascript promises into
// [Future]s.
//
export "src/flutter_web_bluetooth_unsupported.dart"
    if (dart.library.html) "src/flutter_web_bluetooth_web.dart";
