part of js_web_bluetooth;

@JS('window')
external Object _window;

class WebBluetoothConverters {
  WebBluetoothConverters._();

  ///
  /// Convert the js DataView object to a dart [ByteData]. They're basically the
  /// same object (down to the api), but it helps to have the data in a native
  /// friendly data.
  ///
  static ByteData convertJSDataViewToByteData(Object _jsObject) {
    final byteLength = _JSUtil.getProperty(_jsObject, 'byteLength') as int;
    final byteData = ByteData(byteLength);
    for (var i = 0; i < byteLength; i++) {
      final value = _JSUtil.callMethod(_jsObject, 'getUint8', [i]) as int;
      byteData.setUint8(i, value);
    }
    return byteData;
  }

  ///
  /// Convert a Dart [Uint8List] to a js Uint8Array. Both are almost the same
  /// data type, but the web api doesn't like the [Uint8List].
  /// 
  static Object convertUint8ListToJSArrayBuffer(Uint8List data) {
    final constructor = _JSUtil.getProperty(_window, 'Uint8Array');
    final newArray = _JSUtil.callConstructor(constructor, [data.length]);
    for (var i = 0; i < data.length; i++) {
      _JSUtil.setProperty(newArray, i, data[i]);
    }
    return newArray;
  }
}
