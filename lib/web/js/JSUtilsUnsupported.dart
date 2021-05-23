/// @nodoc
library bluetooth_web_js_utils;

part 'JSUtilsInterface.dart';

/// @nodoc
class JSUtils extends JSUtilsInterface {
  @override
  callConstructor(Object constr, List<Object?>? arguments) {
    throw UnimplementedError();
  }

  @override
  callMethod(Object o, String method, List<Object?> args) {
    throw UnimplementedError();
  }

  @override
  getProperty(Object o, Object name) {
    throw UnimplementedError();
  }

  @override
  bool hasProperty(Object o, Object name) {
    throw UnimplementedError();
  }

  @override
  bool instanceof(Object? o, Object type) {
    throw UnimplementedError();
  }

  @override
  newObject() {
    throw UnimplementedError();
  }

  @override
  Future<T> promiseToFuture<T>(Object jsPromise) {
    throw UnimplementedError();
  }

  @override
  setProperty(Object o, Object name, Object? value) {
    throw UnimplementedError();
  }

  @override
  F allowInterop<F extends Function>(F f) {
    throw UnimplementedError();
  }
}
