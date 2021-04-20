part of js_web_bluetooth;

///
/// https://webbluetoothcg.github.io/web-bluetooth/#characteristicproperties-interface
/// https://developer.mozilla.org/en-US/docs/Web/API/BluetoothCharacteristicProperties
class NativeBluetoothCharacteristicProperties {
  final Object _jsObject;

  bool get broadcast {
    final result = _JSUtil.getProperty(_jsObject, 'broadcast');
    if (result is bool) {
      return result;
    }
    return false;
  }

  bool get read {
    final result = _JSUtil.getProperty(_jsObject, 'read');
    if (result is bool) {
      return result;
    }
    return false;
  }

  bool get writeWithoutResponse {
    final result = _JSUtil.getProperty(_jsObject, 'writeWithoutResponse');
    if (result is bool) {
      return result;
    }
    return false;
  }

  bool get write {
    final result = _JSUtil.getProperty(_jsObject, 'write');
    if (result is bool) {
      return result;
    }
    return false;
  }

  bool get notify {
    final result = _JSUtil.getProperty(_jsObject, 'notify');
    if (result is bool) {
      return result;
    }
    return false;
  }

  bool get indicate {
    final result = _JSUtil.getProperty(_jsObject, 'indicate');
    if (result is bool) {
      return result;
    }
    return false;
  }

  bool get authenticatedSignedWrites {
    final result = _JSUtil.getProperty(_jsObject, 'authenticatedSignedWrites');
    if (result is bool) {
      return result;
    }
    return false;
  }

  bool get reliableWrite {
    final result = _JSUtil.getProperty(_jsObject, 'reliableWrite');
    if (result is bool) {
      return result;
    }
    return false;
  }

  bool get writableAuxiliaries {
    final result = _JSUtil.getProperty(_jsObject, 'writableAuxiliaries');
    if (result is bool) {
      return result;
    }
    return false;
  }

  NativeBluetoothCharacteristicProperties._fromJSObject(this._jsObject) {
    if (!_JSUtil.hasProperty(_jsObject, 'broadcast')) {
      throw UnsupportedError('JSObject does not have broadcast');
    }
    if (!_JSUtil.hasProperty(_jsObject, 'read')) {
      throw UnsupportedError('JSObject does not have read');
    }
    if (!_JSUtil.hasProperty(_jsObject, 'writeWithoutResponse')) {
      throw UnsupportedError('JSObject does not have writeWithoutResponse');
    }
    if (!_JSUtil.hasProperty(_jsObject, 'write')) {
      throw UnsupportedError('JSObject does not have write');
    }
    if (!_JSUtil.hasProperty(_jsObject, 'notify')) {
      throw UnsupportedError('JSObject does not have notify');
    }
    if (!_JSUtil.hasProperty(_jsObject, 'indicate')) {
      throw UnsupportedError('JSObject does not have indicate');
    }
    if (!_JSUtil.hasProperty(_jsObject, 'authenticatedSignedWrites')) {
      throw UnsupportedError(
          'JSObject does not have authenticatedSignedWrites');
    }
    if (!_JSUtil.hasProperty(_jsObject, 'reliableWrite')) {
      throw UnsupportedError('JSObject does not have reliableWrite');
    }
    if (!_JSUtil.hasProperty(_jsObject, 'writableAuxiliaries')) {
      throw UnsupportedError('JSObject does not have writableAuxiliaries');
    }
  }
}
