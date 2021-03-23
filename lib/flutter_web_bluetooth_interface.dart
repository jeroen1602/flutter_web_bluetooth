import 'native_web_bluetooth.dart';

abstract class FlutterWebBluetoothInterface {
  bool get isBluetoothSupported;

  Future<bool> get isAvailable;

  Future<NativeBluetoothDevice> requestDevice(RequestOptions options);
}
