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
@JS()
extension type WebBluetoothCharacteristicProperties._(JSObject _)
    implements JSObject {
  @JS("broadcast")
  external JSBoolean? get _broadcast;

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
    return _broadcast != null &&
        _broadcast.isDefinedAndNotNull &&
        _broadcast!.toDart;
  }

  ///
  /// Check to see if the current implementation has the [broadcast] field.
  ///
  /// This may return `false` on the bluefy browser.
  ///
  bool get hasBroadcast => has("broadcast");

  @JS("read")
  external JSBoolean? get _read;

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
    return _read != null && _read.isDefinedAndNotNull && _read!.toDart;
  }

  ///
  /// Check to see if the current implementation has the [read] field.
  ///
  /// This may return `false` on the bluefy browser.
  ///
  bool get hasRead => has("read");

  @JS("writeWithoutResponse")
  external JSBoolean? get _writeWithoutResponse;

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
    return _writeWithoutResponse != null &&
        _writeWithoutResponse.isDefinedAndNotNull &&
        _writeWithoutResponse!.toDart;
  }

  ///
  /// Check to see if the current implementation has the [writeWithoutResponse] field.
  ///
  /// This may return `false` on the bluefy browser.
  ///
  bool get hasWriteWithoutResponse => has("writeWithoutResponse");

  @JS("write")
  external JSBoolean? get _write;

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
    return _write != null && _write.isDefinedAndNotNull && _write!.toDart;
  }

  ///
  /// Check to see if the current implementation has the [write] field.
  ///
  /// Will return `false` if the field doesn't exist.
  ///
  /// This may return `false` on the bluefy browser.
  ///
  bool get hasWrite => has("write");

  @JS("notify")
  external JSBoolean? get _notify;

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
    return _notify != null && _notify.isDefinedAndNotNull && _notify!.toDart;
  }

  ///
  /// Check to see if the current implementation has the [notify] field.
  ///
  /// This may return `false` on the bluefy browser.
  ///
  bool get hasNotify => has("notify");

  @JS("indicate")
  external JSBoolean? get _indicate;

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
    return _indicate != null &&
        _indicate.isDefinedAndNotNull &&
        _indicate!.toDart;
  }

  ///
  /// Check to see if the current implementation has the [indicate] field.
  ///
  /// This may return `false` on the bluefy browser.
  ///
  bool get hasIndicate => has("indicate");

  @JS("authenticatedSignedWrites")
  external JSBoolean? get _authenticatedSignedWrites;

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
    return _authenticatedSignedWrites != null &&
        _authenticatedSignedWrites.isDefinedAndNotNull &&
        _authenticatedSignedWrites!.toDart;
  }

  ///
  /// Check to see if the current implementation has the [authenticatedSignedWrites] field.
  ///
  /// This may return `false` on the bluefy browser.
  ///
  bool get hasAuthenticatedSignedWrites => has("authenticatedSignedWrites");

  @JS("reliableWrite")
  external JSBoolean? get _reliableWrite;

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
    return _reliableWrite != null &&
        _reliableWrite.isDefinedAndNotNull &&
        _reliableWrite!.toDart;
  }

  ///
  /// Check to see if the current implementation has the [reliableWrite] field.
  ///
  /// This may return `false` on the bluefy browser.
  ///
  bool get hasReliableWrite => has("reliableWrite");

  @JS("writableAuxiliaries")
  external JSBoolean? get _writableAuxiliaries;

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
    return _writableAuxiliaries != null &&
        _writableAuxiliaries.isDefinedAndNotNull &&
        _writableAuxiliaries!.toDart;
  }

  ///
  /// Check to see if the current implementation has the [writableAuxiliaries] field.
  ///
  /// This may return `false` on the bluefy browser.
  ///
  bool get hasWritableAuxiliaries => has("writableAuxiliaries");

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
}
