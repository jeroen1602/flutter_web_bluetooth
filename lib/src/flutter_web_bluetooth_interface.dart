part of flutter_web_bluetooth;

///
/// An interface for [FlutterWebBluetooth] to make sure that both the
/// unsupported and web version have the same api.
///
/// See: [FlutterWebBluetooth].
///
abstract class FlutterWebBluetoothInterface {
  ///
  /// An interface for [FlutterWebBluetooth] to make sure that both the
  /// unsupported and web version have the same api.
  ///
  /// See: [FlutterWebBluetooth].
  ///
  FlutterWebBluetoothInterface();

  ///
  /// Get if the bluetooth api is available in this browser. This will only
  /// check if the api is in the `navigator`. Not if anything is available.
  /// This will return false if the website is not loaded in a
  /// [secure context](https://developer.mozilla.org/docs/Web/Security/Secure_Contexts).
  ///
  /// For non web platforms it will always return `false`
  ///
  bool get isBluetoothApiSupported;

  ///
  /// Get a [Stream] for the availability of a Bluetooth adapter.
  ///
  /// If a user inserts or removes a bluetooth adapter from their devices this
  /// stream will update.
  ///
  /// It will not necessarily update if the user enables/ disables a bluetooth
  /// adapter.
  ///
  /// Will return `Stream.value(false)` if [isBluetoothApiSupported] is false.
  ///
  /// For non web platforms it will always return `false`
  ///
  Stream<bool> get isAvailable;

  ///
  /// Get a [Stream] with a [Set] of all devices paired in this browser session.
  /// If the browser supports [Bluetooth.getDevices], which none currently do
  /// unless a flag is used, then it will also return a list of all paired devices.
  ///
  /// Will return a [Stream] of an empty [Set] if [isAvailable] is false.
  ///
  /// A paired device is a device that the user has granted access to and the
  /// web app has once connected with.
  ///
  /// For non web platforms it will always return a [Stream] with an empty [Set].
  ///
  Stream<Set<BluetoothDevice>> get devices;

  ///
  /// Request a [WebBluetoothDevice] from the browser (user). This will resolve
  /// into a single device even if the filter [options] (and environment) have
  /// multiple devices that fit that could be found.
  ///
  /// If you want multiple devices you will need to call this method multiple
  /// times, the user however can still click the already connected device twice.
  ///
  /// - May throw [NativeAPINotImplementedError] if the native api is not
  /// implemented for this user agent (browser).
  ///
  /// - May throw [BluetoothAdapterNotAvailable] if there is no bluetooth adapter
  /// available.
  ///
  /// - May throw [UserCancelledDialogError] if the user cancels the pairing dialog.
  ///
  /// - May throw [DeviceNotFoundError] if the device could not be found with the
  /// current request filters.
  ///
  /// - Will always throw a [NativeAPINotImplementedError] if called on a non
  /// web platform.
  ///
  /// See: [RequestOptionsBuilder]
  ///
  Future<BluetoothDevice> requestDevice(RequestOptionsBuilder options);
}
