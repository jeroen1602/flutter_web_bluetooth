import "package:flutter_web_bluetooth/web/js/js.dart";
import "package:flutter_web_bluetooth/web/js/js_map.dart";

///
/// A JS Iterator
///
/// This is just a helper class because the `web` package doesn't contain the Iterator object. It is not recommended to use outside of this project.
///
/// Feel free to copy it if you need it, do know that this is not well tested since this project only needs this to convert a [JSMap]
///
/// See:
///
/// - https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Iterator
///
/// - https://tc39.es/ecma262/multipage/control-abstraction-objects.html#sec-%iteratorprototype%-object
///
///
@JS("Iterator")
extension type JSIterator<T extends JSAny?>._(JSObject _) implements JSObject {
  ///
  /// Create an iterator from anything that is iterable. For example a [JSArray]
  ///
  external static JSIterator<V> from<V extends JSAny?>(final JSAny? object);

  ///
  /// Drop [limit] number of items from the iterator.
  ///
  /// [limit] may not be negative.
  ///
  external JSIterator<T> drop(final JSNumber limit);

  ///
  /// Take only [limit] number of items from the iterator.
  ///
  /// [limit] may not be negative.
  ///
  external JSIterator<T> take(final JSNumber limit);

  ///
  /// Test to see if every item in the iterator passes the test given by [callbackFn].
  ///
  /// [callbackFn] will be called for each item in the iterator.
  /// [callbackFn] should return something truthy or falsy.
  ///
  /// It will be called with the following arguments
  ///
  /// 1. element of type [T]. The current element of the iterator.
  ///
  /// 2. index of type [JSNumber]. The index of the item.
  ///
  external JSBoolean every(final JSFunction callbackFn);

  ///
  /// Call a method for each item in the iterator.
  ///
  /// [callbackFn] will be called for each item in the iterator.
  /// [callbackFn] should return undefined.
  ///
  /// It will be called with the following arguments
  ///
  /// 1. element of type [T]. The current element of the iterator.
  ///
  /// 2. index of type [JSNumber]. The index of the item.
  ///
  external void forEach(final JSFunction callbackFn);

  ///
  /// Filter out elements from the iterator.
  ///
  /// [callbackFn] will be called for each item in the iterator.
  /// [callbackFn] should return something truthy or falsy.
  ///
  /// It will be called with the following arguments
  ///
  /// 1. element of type [T]. The current element of the iterator.
  ///
  /// 2. index of type [JSNumber]. The index of the item.
  ///
  external JSIterator<T> filter(final JSFunction callbackFn);

  ///
  /// Find an elements in the iterator.
  ///
  /// [callbackFn] will be called for each item in the iterator until the object is found.
  /// [callbackFn] should return something truthy or falsy.
  ///
  /// It will be called with the following arguments
  ///
  /// 1. element of type [T]. The current element of the iterator.
  ///
  /// 2. index of type [JSNumber]. The index of the item.
  ///
  external T? find(final JSFunction callbackFn);

  ///
  /// Check to see if something is in the iterator.
  ///
  /// [callbackFn] will be called for each item in the iterator until the object is found.
  /// [callbackFn] should return something truthy or falsy.
  ///
  /// It will be called with the following arguments
  ///
  /// 1. element of type [T]. The current element of the iterator.
  ///
  /// 2. index of type [JSNumber]. The index of the item.
  ///
  external JSBoolean some(final JSFunction callbackFn);

  ///
  /// FlatMap each item in the iterator to a different type
  ///
  /// [callbackFn] will be called for each item in the iterator until the object is found.
  /// [callbackFn] should return the new value
  ///
  /// It will be called with the following arguments
  ///
  /// 1. element of type [T]. The current element of the iterator.
  ///
  /// 2. index of type [JSNumber]. The index of the item.
  ///
  external JSIterator<R> flatMap<R extends JSAny?>(final JSFunction callbackFn);

  ///
  /// Map each item in the iterator to a different type
  ///
  /// [callbackFn] will be called for each item in the iterator until the object is found.
  /// [callbackFn] should return the new value
  ///
  /// It will be called with the following arguments
  ///
  /// 1. element of type [T]. The current element of the iterator.
  ///
  /// 2. index of type [JSNumber]. The index of the item.
  ///
  external JSIterator<R> map<R extends JSAny?>(final JSFunction callbackFn);

  ///
  /// Reduce the
  ///
  /// [callbackFn] will be called for each item in the iterator until the object is found.
  /// [callbackFn] should return the accumulated value up to this element.
  ///
  /// It will be called with the following arguments
  ///
  /// 1. accumulator. Either the [initialValue] or the value returned by the
  /// previous call of [callbackFn]
  ///
  /// 2. element of type [T]. The current element of the iterator.
  ///
  /// 3. index of type [JSNumber]. The index of the item.
  ///
  /// The [initialValue] is the value to start with. For example `0` if you want
  /// to sum up all the numbers in an iterator.
  ///
  external R reduce<R extends JSAny?>(final JSFunction callbackFn,
      [final JSAny initialValue]);

  ///
  /// Convert the iterator to a [JSArray] with the same type [T].
  ///
  /// It's similar to the `Array.from()` method.
  ///
  external JSArray<T> toArray();
}
