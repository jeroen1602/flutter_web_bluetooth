library bluetooth_web_js_utils;

import 'dart:js' as JS;
import 'dart:js_util' as JSUtil;

part 'JSUtilsInterface.dart';

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

  F allowInterop<F extends Function>(F f) {
    return JS.allowInterop(f);
  }
}
