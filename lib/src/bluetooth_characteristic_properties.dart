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
  BluetoothCharacteristicProperties(this._properties);

  final WebBluetoothCharacteristicProperties _properties;

  ///
  /// Check to see if broadcast is available in this characteristic.
  ///
  /// If this is `true` then you can use get a notification when this device
  /// sends out a broadcast beacon.
  bool get broadcast => _properties.broadcast;

  ///
  /// Check to see if read is available in this characteristic.
  ///
  /// If this is `true` then you can use [BluetoothCharacteristic.readValue].
  /// Though it may still throw a [SecurityError]
  ///
  /// See: [BluetoothCharacteristic.readValue].
  bool get read => _properties.read;

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
  /// Check to see if notify is available in this characteristic. If this
  /// is `true` then you can use [BluetoothCharacteristic.startNotifications].
  /// Though it may still throw a [SecurityError]
  ///
  /// See: [BluetoothCharacteristic.startNotifications].
  bool get notify => _properties.notify;

  ///
  /// Check to see if indicate is available in this characteristic.
  ///
  bool get indicate => _properties.indicate;

  ///
  /// Check to see if authenticated signed writes is available in this
  /// characteristic.
  ///
  bool get authenticatedSignedWrites => _properties.authenticatedSignedWrites;

  ///
  /// Check to see if reliable write is available in this characteristic.
  ///
  bool get reliableWrite => _properties.reliableWrite;

  ///
  /// Check to see if writable auxiliaries is available in this characteristic.
  ///
  bool get writableAuxiliaries => _properties.writableAuxiliaries;
}
