///
/// A library around dart:js and dart:js_util to help make it testable and
/// helps making the library compile against dart IO. (It will however not
/// work).
///
library bluetooth_web_js_utils;

// ignore: library_prefixes
import "dart:js" as JS;

// ignore: library_prefixes
import "dart:js_util" as JSUtil;

part "js_utils_interface.dart";

///
/// An implementation of [JSUtilsInterface] that will call the actual methods
/// that are part of dart:js and dart:js_util.
///
/// The actually used implementation can be overwritten by calling [testingSetJSUtils].
///
class JSUtils extends JSUtilsInterface {
  @override
  dynamic callConstructor(
          final Object constr, final List<Object?>? arguments) =>
      JSUtil.callConstructor(constr, arguments);

  @override
  dynamic callMethod(
          final Object o, final String method, final List<Object?> args) =>
      JSUtil.callMethod(o, method, args);

  @override
  dynamic getProperty(final Object o, final Object name) =>
      JSUtil.getProperty(o, name);

  @override
  bool hasProperty(final Object o, final Object name) =>
      JSUtil.hasProperty(o, name);

  @override
  bool instanceof(final Object? o, final Object type) =>
      JSUtil.instanceof(o, type);

  @override
  dynamic newObject() => JSUtil.newObject();

  @override
  Future<T> promiseToFuture<T>(final Object jsPromise) =>
      JSUtil.promiseToFuture(jsPromise);

  @override
  dynamic setProperty(final Object o, final Object name, final Object? value) =>
      JSUtil.setProperty(o, name, value);

  @override
  F allowInterop<F extends Function>(final F f) => JS.allowInterop(f);
}
