import 'package:flutter_web_bluetooth/native_web_bluetooth.dart';

class NativeBluetoothTesting extends NativeBluetooth {
  NativeBluetoothTesting({this.available = true});

  bool available;
  Map<String, dynamic>? bluetoothDevice;

  @override
  Object getAvailability() {
    return Future.value(this.available);
  }

  Object requestDevice(RequestOptions? options) {
    return Future.value(bluetoothDevice ?? Map<String, dynamic>());
  }

  @override
  void removeEventListener(String type, Function listener) {
    throw UnimplementedError();
  }

  @override
  void addEventListener(String type, Function listener) {
    throw UnimplementedError();
  }

  @override
  Object getDevices() {
    throw UnimplementedError();
  }
}
