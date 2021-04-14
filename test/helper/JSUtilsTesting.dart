import 'package:flutter_web_bluetooth/native/JSUtilsInterface.dart';

class JSUtilsTesting extends JSUtilsInterface {
  @override
  callConstructor(Object constr, List<Object?>? arguments) {
    // TODO: implement callConstructor
    throw UnimplementedError();
  }

  @override
  callMethod(Object o, String method, List<Object?> args) {
    // TODO: implement callMethod
    throw UnimplementedError();
  }

  @override
  getProperty(Object o, Object name) {
    // TODO: implement getProperty
    throw UnimplementedError();
  }

  @override
  bool hasProperty(Object o, Object name) {
    if (o is Map<String, dynamic>) {
      return o.containsKey(name);
    }
    throw UnimplementedError("You should use a map for testing");
  }

  @override
  bool instanceof(Object? o, Object type) {
    // TODO: implement instanceof
    throw UnimplementedError();
  }

  @override
  newObject() {
    return Map<String, dynamic>();
  }

  @override
  Future<T> promiseToFuture<T>(Object jsPromise) {
    if (jsPromise is Future) {
      if (!(jsPromise is Future<T>)) {
        print('Warning the input "promnise" (future for testing) didn\'t '
            'have the correct generic.');
      }
      return jsPromise as Future<T>;
    }
    throw StateError('Input wasn\'t a Future for testing');
  }

  @override
  setProperty(Object o, Object name, Object? value) {
    // TODO: implement setProperty
    throw UnimplementedError();
  }
}
