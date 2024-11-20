import "package:flutter_web_bluetooth/web/js/js.dart";
import "package:flutter_web_bluetooth/web/js/js_iterator.dart";

///
/// A JS Map object.
///
/// This is just a helper class because the `web` package doesn't contain the Map object.
/// It is not recommended to use outside of this project.
///
/// But feel free to copy it if you need it, do know that this is not well
/// tested since this project only needs to convert from JS to dart and back.
///
/// See:
///
/// - https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Map
///
/// - https://tc39.es/ecma262/multipage/keyed-collections.html#sec-map-objects
///
@JS("Map")
extension type JSMap<K extends JSAny?, V extends JSAny?>._(JSObject _)
    implements JSObject {
  ///
  /// Clear all the elements in the map
  ///
  external void clear();

  ///
  /// Delete an element with a specific key.
  ///
  /// Returns `true` if the element existed and has been removed. `false` otherwise.
  external JSBoolean delete(final K key);

  ///
  /// Get an iterator with key value pairs as an [JSArray] with the order { [K], [V] }
  ///
  external JSIterator<JSArray<JSAny>> entries();

  ///
  /// Run the callback function for every entry in the map.
  ///
  /// [callbackFn] has up to 3 arguments.
  ///
  ///  - value [V] the current value
  ///  - key [K] The key of the current value
  ///  - map [JSMap] The current map being iterated
  ///
  ///
  external void forEach(final JSFunction callbackFn, [final JSAny thisArg]);

  ///
  /// Get a value [V] from the map with key [K].
  ///
  /// If there was no value for the key then `undefined` will be returned.
  ///
  ///
  external V? get(final K key);

  ///
  /// Check to see if the map has a specific value.
  ///
  @JS("has")
  external JSBoolean mapHas(final K key);

  ///
  /// Get an iterator with the keys of type [K].
  ///
  external JSIterator<K> keys();

  ///
  /// Set an item in the map with [key]. If the [key] already exists in the map
  /// then it will be overwritten with the new [value]
  external void set(final K key, final V value);

  ///
  /// Get an iterator with the values of type [V].
  ///
  external JSIterator<V> values();

  ///
  /// Get the size of the map
  ///
  external JSNumber get size;

  ///
  /// Create a new instance of a map.
  ///
  ///
  external factory JSMap([final JSAny iterable]);
}

///
/// An extension to convert a dart [Map] to a [JSMap]
///
extension MapToJSMap<K extends JSAny?, V extends JSAny?> on Map<K, V> {
  ///
  /// Convert to a [JSMap]
  ///
  JSMap<K, V> get toJS {
    final inputIterable = entries
        .map((final entry) => [entry.key, entry.value].toJS)
        .toList(growable: false)
        .toJS;
    return JSMap(inputIterable);
  }
}

///
/// An extension to convert a [JSMap] to a dart [Map]
///
extension JSMapToMap<K extends JSAny, V extends JSAny> on JSMap<K, V> {
  ///
  /// Convert to a [Map]
  ///
  Map<K, V> get toDart {
    final entries =
        this.entries().toArray().toDart.map((final entry) => entry.toDart);
    return {for (final item in entries) item[0] as K: item[1] as V};
  }
}
