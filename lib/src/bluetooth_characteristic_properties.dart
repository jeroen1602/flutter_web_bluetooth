part of flutter_web_bluetooth;

///
/// Properties for the current characteristic.
/// The properties describe what the characteristic is able to do.
/// For example does it support writing and/or reading.
///
/// If you call a method on [BluetoothCharacteristic] that is not supported
/// then it will throw a [NotSupportedError].
///
class BluetoothCharacteristicProperties {
  ///
  /// A constructor for new characteristic properties.
  ///
  /// **This should only be done by the library or if you're testing.**
  ///
  /// To get an instance use [BluetoothCharacteristic.properties].
  ///
  BluetoothCharacteristicProperties(this._properties);

  final WebBluetoothCharacteristicProperties _properties;

  ///
  /// Check to see if broadcast is available in this characteristic.
  ///
  /// If this is `true` then you can use get a notification when this device
  /// sends out a broadcast beacon.
  bool get broadcast => _properties.broadcast;

  ///
  /// Check to see if the current implementation has the [broadcast] field.
  ///
  /// This may return `false` on the bluefy browser.
  ///
  bool get hasBroadcast => _properties.hasBroadcast;

  ///
  /// Check to see if read is available in this characteristic.
  ///
  /// If this is `true` then you can use [BluetoothCharacteristic.readValue].
  /// Though it may still throw a [SecurityError]
  ///
  /// See: [BluetoothCharacteristic.readValue].
  bool get read => _properties.read;

  ///
  /// Check to see if the current implementation has the [read] field.
  ///
  /// This may return `false` on the bluefy browser.
  ///
  bool get hasRead => _properties.hasRead;

  ///
  /// Check to see if write without response is available in this
  /// characteristic.
  ///
  /// If this is `true` then you can use
  /// [BluetoothCharacteristic.writeValueWithoutResponse]. Otherwise only
  /// [BluetoothCharacteristic.writeValueWithResponse] is available.
  ///
  /// See: [BluetoothCharacteristic.writeValueWithoutResponse],
  /// [BluetoothCharacteristic.writeValueWithResponse], [write].
  bool get writeWithoutResponse => _properties.writeWithoutResponse;

  ///
  /// Check to see if the current implementation has the [writeWithoutResponse] field.
  ///
  /// This may return `false` on the bluefy browser.
  ///
  bool get hasWriteWithoutResponse => _properties.hasWritableAuxiliaries;

  ///
  /// Check to see if write is available in this characteristic.
  ///
  /// If this is `true` then you can use
  /// [BluetoothCharacteristic.writeValueWithResponse]. Check
  /// [writeWithoutResponse] if
  /// [BluetoothCharacteristic.writeValueWithoutResponse] is also available.
  ///
  /// See: [BluetoothCharacteristic.writeValueWithoutResponse],
  /// [BluetoothCharacteristic.writeValueWithResponse], [writeWithoutResponse].
  bool get write => _properties.write;

  ///
  /// Check to see if the current implementation has the [write] field.
  ///
  /// Will return `false` if the field doesn't exist.
  ///
  /// This may return `false` on the bluefy browser.
  ///
  bool get hasWrite => _properties.hasWrite;

  ///
  /// Check to see if notify is available in this characteristic. If this
  /// is `true` then you can use [BluetoothCharacteristic.startNotifications].
  /// Though it may still throw a [SecurityError]
  ///
  /// See: [BluetoothCharacteristic.startNotifications].
  bool get notify => _properties.notify;

  ///
  /// Check to see if the current implementation has the [notify] field.
  ///
  /// This may return `false` on the bluefy browser.
  ///
  bool get hasNotify => _properties.hasNotify;

  ///
  /// Check to see if indicate is available in this characteristic.
  ///
  bool get indicate => _properties.indicate;

  ///
  /// Check to see if the current implementation has the [indicate] field.
  ///
  /// This may return `false` on the bluefy browser.
  ///
  bool get hasIndicate => _properties.hasIndicate;

  ///
  /// Check to see if authenticated signed writes is available in this
  /// characteristic.
  ///
  bool get authenticatedSignedWrites => _properties.authenticatedSignedWrites;

  ///
  /// Check to see if the current implementation has the [authenticatedSignedWrites] field.
  ///
  /// This may return `false` on the bluefy browser.
  ///
  bool get hasAuthenticatedSignedWrites =>
      _properties.hasAuthenticatedSignedWrites;

  ///
  /// Check to see if reliable write is available in this characteristic.
  ///
  bool get reliableWrite => _properties.reliableWrite;

  ///
  /// Check to see if the current implementation has the [reliableWrite] field.
  ///
  /// This may return `false` on the bluefy browser.
  ///
  bool get hasReliableWrite => _properties.hasReliableWrite;

  ///
  /// Check to see if writable auxiliaries is available in this characteristic.
  ///
  bool get writableAuxiliaries => _properties.writableAuxiliaries;

  ///
  /// Check to see if the current implementation has the [writableAuxiliaries] field.
  ///
  /// This may return `false` on the bluefy browser.
  ///
  bool get hasWritableAuxiliaries => _properties.hasWritableAuxiliaries;

  ///
  /// Check to see if there is this characteristic has any property at all.
  ///
  /// If this returns `false` then the implementation of the browser probably
  /// hasn't implemented this and the values returned from the fields will
  /// always be `false` thus not being reliable.
  ///
  bool get hasProperties => _properties.hasProperties;
}
