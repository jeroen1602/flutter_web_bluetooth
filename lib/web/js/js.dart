//
// A class to make sure @JS and @anonymous exist even for native builds.
// They will of course not have the same functionality but the code will compile.
//
export "js_unsupported.dart" if (dart.library.js_interop) "js_supported.dart";
