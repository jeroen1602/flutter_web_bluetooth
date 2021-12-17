part of flutter_web_bluetooth;

class BluetoothAdapterNotAvailable extends StateError {
  BluetoothAdapterNotAvailable(String method)
      : super('Bluetooth adapter not availbe for method "$method"');
}
