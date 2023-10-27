// ignore: use_string_in_part_of_directives
part of bluetooth_web_js_utils;

///
/// An interface to make sure supported and unsupported version have the
/// same methods.
///
/// It also enables the ability to create a test mock version of the UTILS
/// interface to help with simulating the responses from the browser and thus
/// allowing for testing.
///
abstract class JSUtilsInterface {
  ///
  /// Use JS utils to create a new empty js object.
  ///
  dynamic newObject();

  ///
  /// Use JS utils to check if a js object has a property.
  ///
  /// this will effectively result into `name in o`  in js.
  ///
  bool hasProperty(final Object o, final Object name);

  ///
  /// Use JS utils to get the property of a js object.
  ///
  dynamic getProperty(final Object o, final Object name);

  ///
  /// Use JS utils to set a property of a js object.
  ///
  dynamic setProperty(final Object o, final Object name, final Object? value);

  ///
  /// Use JS utils to call a method of a js object.
  ///
  /// Note that `null` in dart is not the same as `undefined`/ missing in js.
  ///
  dynamic callMethod(
      final Object o, final String method, final List<Object?> args);

  ///
  /// Use JS utils to use instance of on a js object.
  ///
  bool instanceof(final Object? o, final Object type);

  ///
  /// Use JS utils to call a constructor of a class.
  ///
  /// Note that `null` in dart is not the same as `undefined`/ missing in js.
  ///
  dynamic callConstructor(final Object constr, final List<Object?>? arguments);

  ///
  /// Use JS utils to convert a js promise into a dart Future.
  ///
  Future<T> promiseToFuture<T>(final Object jsPromise);

  ///
  /// Use JS utils to allow for interop from dart functions into js code.
  ///
  /// If for example you want to add an event handler than that handler must
  /// be wrapped inside this [allowInterop] method, otherwise the js API cannot
  /// call it.
  ///
  F allowInterop<F extends Function>(final F f);
}
