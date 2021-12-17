part of bluetooth_web_js_utils;

abstract class JSUtilsInterface {
  dynamic newObject();

  bool hasProperty(Object o, Object name);

  dynamic getProperty(Object o, Object name);

  dynamic setProperty(Object o, Object name, Object? value);

  dynamic callMethod(Object o, String method, List<Object?> args);

  bool instanceof(Object? o, Object type);

  dynamic callConstructor(Object constr, List<Object?>? arguments);

  Future<T> promiseToFuture<T>(Object jsPromise);

  F allowInterop<F extends Function>(F f);
}
