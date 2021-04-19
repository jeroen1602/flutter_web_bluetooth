import '../native_web_bluetooth.dart';

abstract class FlutterWebBluetoothInterface {
  ///
  /// Get if the bluetooth api is available in this browser. This will only
  /// check if the api is in the `navigator`. Not if anything is available.
  /// This will sometimes return false if the website is not loaded in a
  /// [secure context](https://developer.mozilla.org/docs/Web/Security/Secure_Contexts).
  ///
  /// For non web platfors it will always return `false`
  ///
  bool get isBluetoothApiSupported;

  ///
  /// Get a [Stream] for the availability of a Bluetooth adapter.
  /// If a user inserts or removes a bluetooth adapter from their devices this
  /// stream will update.
  /// It will not necicerly update if the user enables/ disables a bleutooth
  /// adapter.
  ///
  /// Will return `Stream.value(false)` if [isBluetoothApiSupported] is false.
  ///
  /// For non web platfors it will always return `false`
  ///
  Stream<bool> get isAvailable;

  Future<WebBluetoothDevice> requestDevice(RequestOptions options);
}

class WebBluetoothDevice {}
