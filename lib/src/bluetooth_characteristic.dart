part of flutter_web_bluetooth;

class BluetoothCharacteristic {
  @visibleForTesting
  BluetoothCharacteristic(this._characteristic);

  WebBluetoothRemoteGATTCharacteristic _characteristic;

  String get uuid => this._characteristic.uuid;

}
