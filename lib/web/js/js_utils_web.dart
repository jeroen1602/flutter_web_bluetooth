///
/// A library around dart:js and dart:js_util to help make it testable and
/// helps making the library compile against dart IO. (It will however not
/// work).
///
library bluetooth_web_js_utils;

// ignore: library_prefixes
import 'dart:js' as JS;

// ignore: library_prefixes
import 'dart:js_util' as JSUtil;

part 'js_utils_interface.dart';

///
/// An implementation of [JSUtilsInterface] that will call the actual methods
/// that are part of dart:js and dart:js_util.
///
/// The actually used implementation can be overwritten by calling [testingSetJSUtils].
///
class JSUtils extends JSUtilsInterface {
  @override
  dynamic callConstructor(Object constr, List<Object?>? arguments) =>
      JSUtil.callConstructor(constr, arguments);

  @override
  dynamic callMethod(Object o, String method, List<Object?> args) =>
      JSUtil.callMethod(o, method, args);

  @override
  dynamic getProperty(Object o, Object name) => JSUtil.getProperty(o, name);

  @override
  bool hasProperty(Object o, Object name) => JSUtil.hasProperty(o, name);

  @override
  bool instanceof(Object? o, Object type) => JSUtil.instanceof(o, type);

  @override
  dynamic newObject() => JSUtil.newObject();

  @override
  Future<T> promiseToFuture<T>(Object jsPromise) =>
      JSUtil.promiseToFuture(jsPromise);

  @override
  dynamic setProperty(Object o, Object name, Object? value) =>
      JSUtil.setProperty(o, name, value);

  @override
  F allowInterop<F extends Function>(F f) {
    return JS.allowInterop(f);
  }
}
