part of flutter_web_bluetooth;

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

  ///
  /// Get a Set of devices already known to the browser.
  /// According to the doc this should return a list of devices that the user
  /// has granted access to, but it sometimes it doesn't return known devices
  /// after a page reload.
  ///
  /// Will return a [Stream] of an empty [Set] if [isAvailable] is false.
  ///
  /// For non web platforms it will always return a [Stream] with an empty [Set].
  ///
  Stream<Set<WebBluetoothDevice>> get devices;

  Future<WebBluetoothDevice> requestDevice(RequestOptionsBuilder options);
}
