part of "../js_web_bluetooth.dart";

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
  /// Will return `false` if the field doesn't exist.
  ///
  /// See:
  ///
  /// - https://developer.mozilla.org/en-US/docs/Web/API/BluetoothCharacteristicProperties/broadcast
  ///
  bool get broadcast {
    if (!hasBroadcast) {
      return false;
    }
    final result = _JSUtil.getProperty(_jsObject, "broadcast");
    if (result is bool) {
      return result;
    }
    return false;
  }

  ///
  /// Check to see if the current implementation has the [broadcast] field.
  ///
  /// This may return `false` on the bluefy browser.
  ///
  bool get hasBroadcast => _JSUtil.hasProperty(_jsObject, "broadcast");

  ///
  /// Check to see if read is available in this characteristic.
  ///
  /// Will return `false` if the field doesn't exist.
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
    if (!hasRead) {
      return false;
    }
    final result = _JSUtil.getProperty(_jsObject, "read");
    if (result is bool) {
      return result;
    }
    return false;
  }

  ///
  /// Check to see if the current implementation has the [read] field.
  ///
  /// This may return `false` on the bluefy browser.
  ///
  bool get hasRead => _JSUtil.hasProperty(_jsObject, "read");

  ///
  /// Check to see if write without response is available in this
  /// characteristic.
  ///
  /// Will return `false` if the field doesn't exist.
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
    if (!hasWriteWithoutResponse) {
      return false;
    }
    final result = _JSUtil.getProperty(_jsObject, "writeWithoutResponse");
    if (result is bool) {
      return result;
    }
    return false;
  }

  ///
  /// Check to see if the current implementation has the [writeWithoutResponse] field.
  ///
  /// This may return `false` on the bluefy browser.
  ///
  bool get hasWriteWithoutResponse =>
      _JSUtil.hasProperty(_jsObject, "writeWithoutResponse");

  ///
  /// Check to see if write is available in this characteristic.
  ///
  /// Will return `false` if the field doesn't exist.
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
    if (!hasWrite) {
      return false;
    }
    final result = _JSUtil.getProperty(_jsObject, "write");
    if (result is bool) {
      return result;
    }
    return false;
  }

  ///
  /// Check to see if the current implementation has the [write] field.
  ///
  /// Will return `false` if the field doesn't exist.
  ///
  /// This may return `false` on the bluefy browser.
  ///
  bool get hasWrite => _JSUtil.hasProperty(_jsObject, "write");

  ///
  /// Check to see if notify is available in this characteristic. If this
  /// is `true` then you can use
  /// [WebBluetoothRemoteGATTCharacteristic.startNotifications].
  /// Though it may still throw a [SecurityError]
  ///
  /// Will return `false` if the field doesn't exist.
  ///
  /// See:
  ///
  /// - [WebBluetoothRemoteGATTCharacteristic.startNotifications]
  ///
  /// - https://developer.mozilla.org/en-US/docs/Web/API/BluetoothCharacteristicProperties/notify
  ///
  bool get notify {
    if (!hasNotify) {
      return false;
    }
    final result = _JSUtil.getProperty(_jsObject, "notify");
    if (result is bool) {
      return result;
    }
    return false;
  }

  ///
  /// Check to see if the current implementation has the [notify] field.
  ///
  /// This may return `false` on the bluefy browser.
  ///
  bool get hasNotify => _JSUtil.hasProperty(_jsObject, "notify");

  ///
  /// Check to see if indicate is available in this characteristic.
  ///
  /// Will return `false` if the field doesn't exist.
  ///
  /// See:
  ///
  /// - https://developer.mozilla.org/en-US/docs/Web/API/BluetoothCharacteristicProperties/indicate
  ///
  bool get indicate {
    if (!hasIndicate) {
      return false;
    }
    final result = _JSUtil.getProperty(_jsObject, "indicate");
    if (result is bool) {
      return result;
    }
    return false;
  }

  ///
  /// Check to see if the current implementation has the [indicate] field.
  ///
  /// This may return `false` on the bluefy browser.
  ///
  bool get hasIndicate => _JSUtil.hasProperty(_jsObject, "indicate");

  ///
  /// Check to see if authenticated signed writes is available in this
  /// characteristic.
  ///
  /// Will return `false` if the field doesn't exist.
  ///
  /// See:
  ///
  /// - https://developer.mozilla.org/en-US/docs/Web/API/BluetoothCharacteristicProperties/authenticatedSignedWrites
  ///
  bool get authenticatedSignedWrites {
    if (!hasAuthenticatedSignedWrites) {
      return false;
    }
    final result = _JSUtil.getProperty(_jsObject, "authenticatedSignedWrites");
    if (result is bool) {
      return result;
    }
    return false;
  }

  ///
  /// Check to see if the current implementation has the [authenticatedSignedWrites] field.
  ///
  /// This may return `false` on the bluefy browser.
  ///
  bool get hasAuthenticatedSignedWrites =>
      _JSUtil.hasProperty(_jsObject, "authenticatedSignedWrites");

  ///
  /// Check to see if reliable write is available in this characteristic.
  ///
  /// Will return `false` if the field doesn't exist.
  ///
  /// See:
  ///
  /// - https://developer.mozilla.org/en-US/docs/Web/API/BluetoothCharacteristicProperties/reliableWrite
  ///
  bool get reliableWrite {
    if (!hasReliableWrite) {
      return false;
    }
    final result = _JSUtil.getProperty(_jsObject, "reliableWrite");
    if (result is bool) {
      return result;
    }
    return false;
  }

  ///
  /// Check to see if the current implementation has the [reliableWrite] field.
  ///
  /// This may return `false` on the bluefy browser.
  ///
  bool get hasReliableWrite => _JSUtil.hasProperty(_jsObject, "reliableWrite");

  ///
  /// Check to see if writable auxiliaries is available in this characteristic.
  ///
  /// Will return `false` if the field doesn't exist.
  ///
  /// See:
  ///
  /// - https://developer.mozilla.org/en-US/docs/Web/API/BluetoothCharacteristicProperties/writableAuxiliaries
  ///
  bool get writableAuxiliaries {
    if (!hasWritableAuxiliaries) {
      return false;
    }
    final result = _JSUtil.getProperty(_jsObject, "writableAuxiliaries");
    if (result is bool) {
      return result;
    }
    return false;
  }

  ///
  /// Check to see if the current implementation has the [writableAuxiliaries] field.
  ///
  /// This may return `false` on the bluefy browser.
  ///
  bool get hasWritableAuxiliaries =>
      _JSUtil.hasProperty(_jsObject, "writableAuxiliaries");

  ///
  /// Check to see if there is this characteristic has any property at all.
  ///
  /// If this returns `false` then the implementation of the browser probably
  /// hasn't implemented this and the values returned from the fields will
  /// always be `false` thus not being reliable.
  ///
  bool get hasProperties =>
      hasBroadcast ||
      hasRead ||
      hasWriteWithoutResponse ||
      hasWrite ||
      hasNotify ||
      hasIndicate ||
      hasAuthenticatedSignedWrites ||
      hasReliableWrite ||
      hasWritableAuxiliaries;

  ///
  /// Create a new instance from a js object.
  ///
  /// **This should only be done by the library or if you're testing.**
  ///
  /// To get an instance use [WebBluetoothRemoteGATTCharacteristic.properties].
  ///
  WebBluetoothCharacteristicProperties.fromJSObject(this._jsObject);
}
