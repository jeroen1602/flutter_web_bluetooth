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
  @visibleForTesting
  BluetoothCharacteristicProperties(this._properties);

  WebBluetoothCharacteristicProperties _properties;

  bool get broadcast => _properties.broadcast;

  bool get read => _properties.read;

  bool get writeWithoutResponse => _properties.writeWithoutResponse;

  bool get write => _properties.write;

  bool get notify => _properties.notify;

  bool get indicate => _properties.indicate;

  bool get authenticatedSignedWrites => _properties.authenticatedSignedWrites;

  bool get reliableWrite => _properties.reliableWrite;

  bool get writableAuxiliaries => _properties.writableAuxiliaries;
}
