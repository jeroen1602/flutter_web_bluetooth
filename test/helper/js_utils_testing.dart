import "package:flutter_web_bluetooth/web/js/js_utils.dart";

class JSUtilsTesting extends JSUtilsInterface {
  // Return Never for now
  @override
  Never callConstructor(final Object constr, final List<Object?>? arguments) {
    // TODO: implement callConstructor
    throw UnimplementedError();
  }

  // Return Never for now
  @override
  Never callMethod(
      final Object o, final String method, final List<Object?> args) {
    // TODO: implement callMethod
    throw UnimplementedError();
  }

  @override
  dynamic getProperty(final Object o, final Object name) {
    if (o is Map<dynamic, dynamic>) {
      return o[name];
    }
    throw UnimplementedError("You should use a map for testing");
  }

  @override
  bool hasProperty(final Object o, final Object name) {
    if (o is Map<String, dynamic>) {
      return o.containsKey(name);
    }
    throw UnimplementedError("You should use a map for testing");
  }

  @override
  bool instanceof(final Object? o, final Object type) {
    // TODO: implement instanceof
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic> newObject() => <String, dynamic>{};

  @override
  Future<T> promiseToFuture<T>(final Object jsPromise) {
    if (jsPromise is Future) {
      if (jsPromise is! Future<T>) {
        // ignore: avoid_print
        print("Warning the input \"promise\" (future for testing) didn't "
            "have the correct generic.");
      }
      return jsPromise as Future<T>;
    }
    throw StateError("Input wasn't a Future for testing");
  }

  // Return Never for now
  @override
  Never setProperty(final Object o, final Object name, final Object? value) {
    // TODO: implement setProperty
    throw UnimplementedError();
  }

  @override
  F allowInterop<F extends Function>(final F f) => f;
}
