import "package:flutter_web_bluetooth/js_web_bluetooth.dart";
import "package:flutter_web_bluetooth/web/js/js.dart";

class NativeBluetoothTesting extends NativeBluetooth {
  NativeBluetoothTesting({this.available = true});

  bool available;
  WebBluetoothDevice? bluetoothDevice;

  @override
  JSPromise<JSBoolean> getAvailability() => Future.value(available.toJS).toJS;

  @override
  JSPromise<WebBluetoothDevice> requestDevice(final RequestOptions? options) {
    if (bluetoothDevice != null) {
      return Future.value(bluetoothDevice!).toJS;
    } else {
      return Future.error("No bluetooth device set".toJS).toJS
          as JSPromise<WebBluetoothDevice>;
    }
  }

  @override
  void removeEventListener(
    final String type,
    final EventListener? callback, [
    final JSAny? options,
  ]) {
    throw UnimplementedError();
  }

  @override
  void addEventListener(
    final String type,
    final EventListener? callback, [
    final JSAny? options,
  ]) {
    throw UnimplementedError();
  }

  @override
  JSPromise<JSArray<WebBluetoothDevice>> getDevices() {
    throw UnimplementedError();
  }
}
