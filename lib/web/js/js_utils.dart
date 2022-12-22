///
/// A library around dart:js and dart:js_util to help make it testable and
/// helps making the library compile against dart IO. (It will however not
/// work).
///
export "js_utils_unsupported.dart" if (dart.library.html) "js_utils_web.dart";
