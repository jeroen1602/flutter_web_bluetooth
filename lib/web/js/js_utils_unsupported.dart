///
/// A library around dart:js and dart:js_util to help make it testable and
/// helps making the library compile against dart IO. (It will however not
/// work).
///
library bluetooth_web_js_utils;

import 'package:meta/meta.dart';

part 'js_utils_interface.dart';

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
  dynamic callConstructor(Object constr, List<Object?>? arguments) {
    throw UnimplementedError();
  }

  @alwaysThrows
  @override
  dynamic callMethod(Object o, String method, List<Object?> args) {
    throw UnimplementedError();
  }

  @alwaysThrows
  @override
  dynamic getProperty(Object o, Object name) {
    throw UnimplementedError();
  }

  @alwaysThrows
  @override
  bool hasProperty(Object o, Object name) {
    throw UnimplementedError();
  }

  @alwaysThrows
  @override
  bool instanceof(Object? o, Object type) {
    throw UnimplementedError();
  }

  @alwaysThrows
  @override
  dynamic newObject() {
    throw UnimplementedError();
  }

  @alwaysThrows
  @override
  Future<T> promiseToFuture<T>(Object jsPromise) {
    throw UnimplementedError();
  }

  @alwaysThrows
  @override
  dynamic setProperty(Object o, Object name, Object? value) {
    throw UnimplementedError();
  }

  @alwaysThrows
  @override
  F allowInterop<F extends Function>(F f) {
    throw UnimplementedError();
  }
}
