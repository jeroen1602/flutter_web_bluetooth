import "package:flutter_web_bluetooth/js_web_bluetooth.dart";

class NativeBluetoothTesting extends NativeBluetooth {
  NativeBluetoothTesting({this.available = true});

  bool available;
  Map<String, dynamic>? bluetoothDevice;

  @override
  Object getAvailability() => Future.value(available);

  @override
  Object requestDevice(final RequestOptions? options) =>
      Future.value(bluetoothDevice ?? <String, dynamic>{});

  @override
  void removeEventListener(final String type, final Function listener) {
    throw UnimplementedError();
  }

  @override
  void addEventListener(final String type, final Function listener) {
    throw UnimplementedError();
  }

  @override
  Object getDevices() {
    throw UnimplementedError();
  }
}
