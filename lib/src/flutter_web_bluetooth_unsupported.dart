import '../native_web_bluetooth.dart';
import 'flutter_web_bluetooth_interface.dart';

class FlutterWebBluetooth extends FlutterWebBluetoothInterface {
  FlutterWebBluetooth._() {
    print(
        'WARNING! initialized an instance of FlutterWebBluetooth on a non web platform!');
  }

  static FlutterWebBluetooth? _instance;

  static FlutterWebBluetoothInterface get instance {
    _instance ??= FlutterWebBluetooth._();
    return _instance!;
  }

  @override
  bool get isBluetoothApiSupported => false;

  @override
  Stream<bool> get isAvailable => Stream.value(false);

  @override
  Future<WebBluetoothDevice> requestDevice(RequestOptions options) {
    throw StateError('Web Bluetooth is not available for this device!');
  }
}
