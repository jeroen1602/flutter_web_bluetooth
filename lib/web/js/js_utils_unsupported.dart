///
/// A library around dart:js and dart:js_util to help make it testable and
/// helps making the library compile against dart IO. (It will however not
/// work).
///
library bluetooth_web_js_utils;

import "package:meta/meta.dart";

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
  @alwaysThrows
  @override
  dynamic callConstructor(final Object constr, final List<Object?>? arguments) {
    throw UnimplementedError();
  }

  @alwaysThrows
  @override
  dynamic callMethod(
      final Object o, final String method, final List<Object?> args) {
    throw UnimplementedError();
  }

  @alwaysThrows
  @override
  dynamic getProperty(final Object o, final Object name) {
    throw UnimplementedError();
  }

  @alwaysThrows
  @override
  bool hasProperty(final Object o, final Object name) {
    throw UnimplementedError();
  }

  @alwaysThrows
  @override
  bool instanceof(final Object? o, final Object type) {
    throw UnimplementedError();
  }

  @alwaysThrows
  @override
  dynamic newObject() {
    throw UnimplementedError();
  }

  @alwaysThrows
  @override
  Future<T> promiseToFuture<T>(final Object jsPromise) {
    throw UnimplementedError();
  }

  @alwaysThrows
  @override
  dynamic setProperty(final Object o, final Object name, final Object? value) {
    throw UnimplementedError();
  }

  @alwaysThrows
  @override
  F allowInterop<F extends Function>(final F f) {
    throw UnimplementedError();
  }
}
