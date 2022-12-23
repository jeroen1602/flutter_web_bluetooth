part of js_web_bluetooth;

@JS("window")
external Object _window;

///
/// Some converters to convert from Dart objects to native js object expected
/// by some API calls.
///
/// You shouldn't have to do this manually as the library should take care of
/// it when it is needed.
///
class WebBluetoothConverters {
  WebBluetoothConverters._();

  ///
  /// Convert the js DataView object to a dart [ByteData]. They're basically the
  /// same object (down to the api), but it helps to have the data in a native
  /// friendly data.
  ///
  static ByteData convertJSDataViewToByteData(final Object jsObject) {
    final byteLength = _JSUtil.getProperty(jsObject, "byteLength") as int;
    final byteData = ByteData(byteLength);
    for (var i = 0; i < byteLength; i++) {
      final value = _JSUtil.callMethod(jsObject, "getUint8", [i]) as int;
      byteData.setUint8(i, value);
    }
    return byteData;
  }

  ///
  /// Convert a Dart [Uint8List] to a js Uint8Array. Both are almost the same
  /// data type, but the web api doesn't like the [Uint8List].
  ///
  static Object convertUint8ListToJSArrayBuffer(final Uint8List data) {
    final constructor = _JSUtil.getProperty(_window, "Uint8Array");
    final newArray = _JSUtil.callConstructor(constructor, [data.length]);
    for (var i = 0; i < data.length; i++) {
      _JSUtil.setProperty(newArray, i, data[i]);
    }
    return newArray;
  }

  ///
  /// Convert a js list that is a basic js object to a [List] with type [T].
  /// [list] is the js object to convert to a list. All the entries in the
  /// original list will be copied over.
  ///
  /// [converter] is how to convert the entries in the list from their js types
  /// to something that dart can handle. By default it will use the [castConverter]
  /// which will just cast the object to [T]. If something else is required
  /// then you will need to provide your own method.
  ///
  static List<T> convertJSObjectToList<T>(final Object list,
      [final T Function(Object)? converter]) {
    final length = _JSUtil.getProperty(list, "length") as int? ?? 0;
    final List<T> output = List.generate(
        length,
        (final index) => converter != null
            ? converter.call(_JSUtil.callMethod(list, "at", [index]))
            : castConverter<T>(_JSUtil.callMethod(list, "at", [index])));
    return output;
  }

  ///
  /// Convert an incoming js object to [T] using a basic cast.2
  /// This method is used for the [convertJSObjectToList] method by default.
  /// Replace it if something more specific is required.
  ///
  static T castConverter<T>(final Object input) => input as T;

  ///
  /// Convert a js map that is a basic js object to a [Map] with key [K] and
  /// value [V].
  ///
  /// Set the [keyConverter] and/ or the [valueConverter] to change the behaviour
  /// on how the keys and/ or values should be converted inside the resulting map.
  /// By default if they are not set the [castConverter] will be used.
  ///
  static Map<K, V> convertJsObjectToMap<K, V>(final Object map,
      {final K Function(Object)? keyConverter,
      final V Function(Object)? valueConverter}) {
    final List<K> keys = WebBluetoothConverters.convertJSObjectToList(
        _JSUtil.callMethod(map, "keys", []), keyConverter);
    final Map<K, V> converted = {};
    for (final item in keys) {
      converted[item] = valueConverter != null
          ? valueConverter.call(_JSUtil.callMethod(map, "get", [item]))
          : castConverter<V>(_JSUtil.callMethod(map, "get", [item]));
    }
    return converted;
  }
}
