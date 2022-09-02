part of js_web_bluetooth;

///
/// A class for calling methods and values for a [WebBluetoothCharacteristicProperties].
///
/// This is where you can find out the properties of a characteristic.
///
/// You can get a [WebBluetoothCharacteristicProperties] from
/// [WebBluetoothRemoteGATTCharacteristic.properties].
///
/// See:
///
/// - https://developer.mozilla.org/en-US/docs/Web/API/BluetoothCharacteristicProperties
///
/// - https://webbluetoothcg.github.io/web-bluetooth/#characteristicproperties-interface
///
class WebBluetoothCharacteristicProperties {
  final Object _jsObject;

  ///
  /// Check to see if broadcast is available in this characteristic.
  ///
  /// See:
  ///
  /// - https://developer.mozilla.org/en-US/docs/Web/API/BluetoothCharacteristicProperties/broadcast
  ///
  bool get broadcast {
    final result = _JSUtil.getProperty(_jsObject, 'broadcast');
    if (result is bool) {
      return result;
    }
    return false;
  }

  ///
  /// Check to see if read is available in this characteristic.
  ///
  /// If this is `true` then you can use
  /// [WebBluetoothRemoteGATTCharacteristic.readValue].
  /// Though it may still throw a SecurityError.
  ///
  /// See:
  ///
  /// - [WebBluetoothRemoteGATTCharacteristic.readValue]
  ///
  /// - https://developer.mozilla.org/en-US/docs/Web/API/BluetoothCharacteristicProperties/read
  ///
  bool get read {
    final result = _JSUtil.getProperty(_jsObject, 'read');
    if (result is bool) {
      return result;
    }
    return false;
  }

  ///
  /// Check to see if write without response is available in this
  /// characteristic.
  ///
  /// If this is `true` then you can use
  /// [WebBluetoothRemoteGATTCharacteristic.writeValueWithoutResponse].
  /// Otherwise only
  /// [WebBluetoothRemoteGATTCharacteristic.writeValueWithResponse] is available.
  ///
  /// You will still need to check if these methods are available in the current
  /// browser by calling
  /// [WebBluetoothRemoteGATTCharacteristic.hasWriteValueWithoutResponse] and
  /// [WebBluetoothRemoteGATTCharacteristic.hasWriteValueWithResponse].
  ///
  /// Otherwise you're still only able to call
  /// ignore: deprecated_member_use_from_same_package
  /// [WebBluetoothRemoteGATTCharacteristic.writeValue].
  ///
  /// See:
  ///
  /// - [WebBluetoothRemoteGATTCharacteristic.hasWriteValueWithoutResponse]
  ///
  /// - [WebBluetoothRemoteGATTCharacteristic.writeValueWithoutResponse]
  ///
  /// - [WebBluetoothRemoteGATTCharacteristic.hasWriteValueWithResponse]
  ///
  /// - [WebBluetoothRemoteGATTCharacteristic.writeValueWithResponse]
  ///
  /// ignore: deprecated_member_use_from_same_package
  /// - [WebBluetoothRemoteGATTCharacteristic.writeValue].
  ///
  /// - https://developer.mozilla.org/en-US/docs/Web/API/BluetoothCharacteristicProperties/writeWithoutResponse
  ///
  bool get writeWithoutResponse {
    if (!_JSUtil.hasProperty(_jsObject, 'writeWithoutResponse')) {
      return false;
    }
    final result = _JSUtil.getProperty(_jsObject, 'writeWithoutResponse');
    if (result is bool) {
      return result;
    }
    return false;
  }

  ///
  /// Check to see if write is available in this characteristic.
  ///
  /// If this is `true` then you can use
  /// [BluetoothCharacteristic.writeValueWithResponse]. Check
  /// [writeWithoutResponse] if
  /// [BluetoothCharacteristic.writeValueWithoutResponse] is also available.
  ///
  /// You will still need to check if these methods are available in the current
  /// browser by calling
  /// [WebBluetoothRemoteGATTCharacteristic.hasWriteValueWithoutResponse] and
  /// [WebBluetoothRemoteGATTCharacteristic.hasWriteValueWithResponse].
  ///
  /// Otherwise you're still only able to call
  /// ignore: deprecated_member_use_from_same_package
  /// [WebBluetoothRemoteGATTCharacteristic.writeValue].
  ///
  /// See:
  ///
  /// - [WebBluetoothRemoteGATTCharacteristic.hasWriteValueWithoutResponse]
  ///
  /// - [WebBluetoothRemoteGATTCharacteristic.writeValueWithoutResponse]
  ///
  /// - [WebBluetoothRemoteGATTCharacteristic.hasWriteValueWithResponse]
  ///
  /// - [WebBluetoothRemoteGATTCharacteristic.writeValueWithResponse]
  ///
  /// ignore: deprecated_member_use_from_same_package
  /// - [WebBluetoothRemoteGATTCharacteristic.writeValue].
  ///
  /// - https://developer.mozilla.org/en-US/docs/Web/API/BluetoothCharacteristicProperties/write
  ///
  bool get write {
    final result = _JSUtil.getProperty(_jsObject, 'write');
    if (result is bool) {
      return result;
    }
    return false;
  }

  ///
  /// Check to see if notify is available in this characteristic. If this
  /// is `true` then you can use
  /// [WebBluetoothRemoteGATTCharacteristic.startNotifications].
  /// Though it may still throw a [SecurityError]
  /// See:
  ///
  /// - [WebBluetoothRemoteGATTCharacteristic.startNotifications]
  ///
  /// - https://developer.mozilla.org/en-US/docs/Web/API/BluetoothCharacteristicProperties/notify
  ///
  bool get notify {
    final result = _JSUtil.getProperty(_jsObject, 'notify');
    if (result is bool) {
      return result;
    }
    return false;
  }

  ///
  /// Check to see if indicate is available in this characteristic.
  ///
  /// See:
  ///
  /// - https://developer.mozilla.org/en-US/docs/Web/API/BluetoothCharacteristicProperties/indicate
  ///
  bool get indicate {
    final result = _JSUtil.getProperty(_jsObject, 'indicate');
    if (result is bool) {
      return result;
    }
    return false;
  }

  ///
  /// Check to see if authenticated signed writes is available in this
  /// characteristic.
  ///
  /// See:
  ///
  /// - https://developer.mozilla.org/en-US/docs/Web/API/BluetoothCharacteristicProperties/authenticatedSignedWrites
  ///
  bool get authenticatedSignedWrites {
    final result = _JSUtil.getProperty(_jsObject, 'authenticatedSignedWrites');
    if (result is bool) {
      return result;
    }
    return false;
  }

  ///
  /// Check to see if reliable write is available in this characteristic.
  ///
  /// See:
  ///
  /// - https://developer.mozilla.org/en-US/docs/Web/API/BluetoothCharacteristicProperties/reliableWrite
  ///
  bool get reliableWrite {
    final result = _JSUtil.getProperty(_jsObject, 'reliableWrite');
    if (result is bool) {
      return result;
    }
    return false;
  }

  ///
  /// Check to see if writable auxiliaries is available in this characteristic.
  ///
  /// See:
  ///
  /// - https://developer.mozilla.org/en-US/docs/Web/API/BluetoothCharacteristicProperties/writableAuxiliaries
  ///
  bool get writableAuxiliaries {
    final result = _JSUtil.getProperty(_jsObject, 'writableAuxiliaries');
    if (result is bool) {
      return result;
    }
    return false;
  }

  ///
  /// Create a new instance from a js object.
  ///
  /// **This should only be done by the library or if you're testing.**
  ///
  /// To get an instance use [WebBluetoothRemoteGATTCharacteristic.properties].
  ///
  WebBluetoothCharacteristicProperties.fromJSObject(this._jsObject) {
    // if (!_JSUtil.hasProperty(_jsObject, 'broadcast')) {
    //   throw UnsupportedError('JSObject does not have broadcast');
    // }
    // if (!_JSUtil.hasProperty(_jsObject, 'read')) {
    //   throw UnsupportedError('JSObject does not have read');
    // }
    // if (!_JSUtil.hasProperty(_jsObject, 'write')) {
    //   throw UnsupportedError('JSObject does not have write');
    // }
    // if (!_JSUtil.hasProperty(_jsObject, 'notify')) {
    //   throw UnsupportedError('JSObject does not have notify');
    // }
    // if (!_JSUtil.hasProperty(_jsObject, 'indicate')) {
    //   throw UnsupportedError('JSObject does not have indicate');
    // }
    // if (!_JSUtil.hasProperty(_jsObject, 'authenticatedSignedWrites')) {
    //   throw UnsupportedError(
    //       'JSObject does not have authenticatedSignedWrites');
    // }
    // if (!_JSUtil.hasProperty(_jsObject, 'reliableWrite')) {
    //   throw UnsupportedError('JSObject does not have reliableWrite');
    // }
    // if (!_JSUtil.hasProperty(_jsObject, 'writableAuxiliaries')) {
    //   throw UnsupportedError('JSObject does not have writableAuxiliaries');
    // }
  }
}
