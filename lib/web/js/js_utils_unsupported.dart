///
/// A library around dart:js and dart:js_util to help make it testable and
/// helps making the library compile against dart IO. (It will however not
/// work).
///
library bluetooth_web_js_utils;

part "js_utils_interface.dart";

///
/// A stub implementation of [JSUtilsInterface] that will be used in dart native
/// builds of the project.
///
/// Everything results in an exception at runtime, but this allows for it to
/// be compiled.
///
/// The actually used implementation can be overwritten by calling [testingSetJSUtils].
///
class JSUtils extends JSUtilsInterface {
  @override
  Never callConstructor(final Object constr, final List<Object?>? arguments) {
    throw UnimplementedError();
  }

  @override
  Never callMethod(
      final Object o, final String method, final List<Object?> args) {
    throw UnimplementedError();
  }

  @override
  Never getProperty(final Object o, final Object name) {
    throw UnimplementedError();
  }

  @override
  Never hasProperty(final Object o, final Object name) {
    throw UnimplementedError();
  }

  @override
  Never instanceof(final Object? o, final Object type) {
    throw UnimplementedError();
  }

  @override
  Never newObject() {
    throw UnimplementedError();
  }

  @override
  Never promiseToFuture<T>(final Object jsPromise) {
    throw UnimplementedError();
  }

  @override
  Never setProperty(final Object o, final Object name, final Object? value) {
    throw UnimplementedError();
  }

  @override
  Never allowInterop<F extends Function>(final F f) {
    throw UnimplementedError();
  }
}
