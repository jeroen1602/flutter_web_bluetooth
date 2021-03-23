part of native_web_bluetooth;

///
/// https://webbluetoothcg.github.io/web-bluetooth/#characteristicproperties-interface
/// https://developer.mozilla.org/en-US/docs/Web/API/BluetoothCharacteristicProperties
class NativeBluetoothCharacteristicProperties {
  final Object _jsObject;

  bool get broadcast {
    final result = JSUtil.getProperty(_jsObject, 'broadcast');
    if (result is bool) {
      return result;
    }
    return false;
  }

  bool get read {
    final result = JSUtil.getProperty(_jsObject, 'read');
    if (result is bool) {
      return result;
    }
    return false;
  }

  bool get writeWithoutResponse {
    final result = JSUtil.getProperty(_jsObject, 'writeWithoutResponse');
    if (result is bool) {
      return result;
    }
    return false;
  }

  bool get write {
    final result = JSUtil.getProperty(_jsObject, 'write');
    if (result is bool) {
      return result;
    }
    return false;
  }

  bool get notify {
    final result = JSUtil.getProperty(_jsObject, 'notify');
    if (result is bool) {
      return result;
    }
    return false;
  }

  bool get indicate {
    final result = JSUtil.getProperty(_jsObject, 'indicate');
    if (result is bool) {
      return result;
    }
    return false;
  }

  bool get authenticatedSignedWrites {
    final result = JSUtil.getProperty(_jsObject, 'authenticatedSignedWrites');
    if (result is bool) {
      return result;
    }
    return false;
  }

  bool get reliableWrite {
    final result = JSUtil.getProperty(_jsObject, 'reliableWrite');
    if (result is bool) {
      return result;
    }
    return false;
  }

  bool get writableAuxiliaries {
    final result = JSUtil.getProperty(_jsObject, 'writableAuxiliaries');
    if (result is bool) {
      return result;
    }
    return false;
  }

  NativeBluetoothCharacteristicProperties._fromJSObject(this._jsObject) {
    if (!JSUtil.hasProperty(_jsObject, 'broadcast')) {
      throw UnsupportedError('JSObject does not have broadcast');
    }
    if (!JSUtil.hasProperty(_jsObject, 'read')) {
      throw UnsupportedError('JSObject does not have read');
    }
    if (!JSUtil.hasProperty(_jsObject, 'writeWithoutResponse')) {
      throw UnsupportedError('JSObject does not have writeWithoutResponse');
    }
    if (!JSUtil.hasProperty(_jsObject, 'write')) {
      throw UnsupportedError('JSObject does not have write');
    }
    if (!JSUtil.hasProperty(_jsObject, 'notify')) {
      throw UnsupportedError('JSObject does not have notify');
    }
    if (!JSUtil.hasProperty(_jsObject, 'indicate')) {
      throw UnsupportedError('JSObject does not have indicate');
    }
    if (!JSUtil.hasProperty(_jsObject, 'authenticatedSignedWrites')) {
      throw UnsupportedError(
          'JSObject does not have authenticatedSignedWrites');
    }
    if (!JSUtil.hasProperty(_jsObject, 'reliableWrite')) {
      throw UnsupportedError('JSObject does not have reliableWrite');
    }
    if (!JSUtil.hasProperty(_jsObject, 'writableAuxiliaries')) {
      throw UnsupportedError('JSObject does not have writableAuxiliaries');
    }
  }
}