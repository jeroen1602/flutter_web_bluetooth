part of flutter_web_bluetooth;

class WebBluetoothDevice {
  @visibleForTesting
  WebBluetoothDevice(this._bluetoothDevice);

  final NativeBluetoothDevice _bluetoothDevice;

  String get id => _bluetoothDevice.id;

  String? get name => _bluetoothDevice.name;

  bool get hasGATT => this.gatt != null;

  // Get the underlying native (web) gatt service.
  //@visibleForTesting
  @Deprecated('This is here for debugging and will be removed once web '
      'bluetooth is actually released. '
      '(It will still exist as visible for testing)')
  NativeBluetoothRemoteGATTServer? get gatt => _bluetoothDevice.gatt;

  ///
  /// Get the underlying native (web) bluetooth device.
  ///
  @Deprecated('This is here for debugging and will be removed once web '
      'bluetooth is actually released.')
  NativeBluetoothDevice get nativeDevice => _bluetoothDevice;
}
