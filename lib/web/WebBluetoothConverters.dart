part of js_web_bluetooth;

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
}
