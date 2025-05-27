// ignore: use_string_in_part_of_directives
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
  /// Check if a bluetooth adapter is available for the browser (user agent)
  /// If no bluetooth adapters are available to the browser it will
  /// resolve into false. This may return true even if the adapter is disabled
  /// by the user.
  ///
  /// Will check if `bluetooth in navigator` if this is not the case then the
  /// api is not available in the browser.
  /// After this it will call `navigator.bluetooth.getAvailability()` to check
  /// if there is an adapter available.
  ///
  /// This will return false if the website is not run in a secure context.
  ///
  Future<bool> getAvailability();

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
  Future<BluetoothDevice> requestDevice(final RequestOptionsBuilder options);

  ///
  /// The [advertisements] stream emits an event with a
  /// [AdvertisementBluetoothDevice]. This device doesn't have a gatt server and
  /// can thus not do everything you may want.
  ///
  /// This method requests the user to pair to the device.
  ///
  /// All this method does is constructs a [RequestOptionsBuilder] using
  /// information from [device], [requiredServices], and [optionalServices] and
  /// then calls [requestDevice].
  ///
  /// There is no guarantee that the user only sees 1 option in their pair
  /// dialog and thus there is no guarantee that the user pairs the exact same
  /// device as the one given.
  ///
  /// May throw the same exceptions as [requestDevice].
  ///
  /// See: [requestDevice]
  ///
  Future<BluetoothDevice> requestAdvertisementDevice(
    final AdvertisementBluetoothDevice device, {
    final List<String> requiredServices = const [],
    final List<String> optionalServices = const [],
  });

  ///
  /// Check to see if the current browser has the [requestLEScan] method.
  ///
  /// Use this to avoid the [NativeAPINotImplementedError].
  ///
  bool get hasRequestLEScan;

  ///
  /// Request the user to start scanning for Bluetooth LE devices in the
  /// area. Not every browser supports this method yet so check it using
  /// [hasRequestLEScan]. However even if the browser supports it, the [Future]
  /// may never complete on browsers. This has been the case for Chrome on linux
  /// and windows even with the correct flag enabled. Chrome on Android does
  /// seem to work. Add a [Future.timeout] to combat this.
  ///
  /// The devices found through this are emitted using the [advertisements]
  /// stream. The devices emitted through this stream aren't [BluetoothDevice]s
  /// but [AdvertisementBluetoothDevice]s instead as they don't have a
  /// gatt server.
  ///
  /// It will only emit devices that match the [options] so it could happen
  /// that there are no devices in range while the scan is running.
  /// See [LEScanOptionsBuilder] for details on the options.
  ///
  /// Once a scan is running (and there were no errors) it can be stopped by
  /// calling [BluetoothLEScan.stop] on the returned object from the [Future].
  /// If this object doesn't get saved then there is no way to stop the scan,
  /// it should be able to start multiple scans with different scan options.
  ///
  /// - May throw [UserCancelledDialogError] if the user cancelled the dialog.
  ///
  /// - May throw [NativeAPINotImplementedError] if the browser/ user agent
  /// doesn't support this method. This may still be thrown even if
  /// [hasRequestLEScan] is checked first.
  ///
  /// - May throw [StateError] for any state error that the method may throw.
  ///
  /// - May throw [PolicyError] if Bluetooth has been disabled by an
  /// administrator via a policy.
  ///
  /// - May throw [PermissionError] if the user has disallowed the permission.
  ///
  /// - May throw [BluetoothAdapterNotAvailable] if there is no Bluetooth
  /// adapter available.
  ///
  /// - May throw [BrowserError] for every other browser error.
  ///
  Future<BluetoothLEScan> requestLEScan(final LEScanOptionsBuilder options);

  ///
  /// the [advertisements] stream emits [AdvertisementReceivedEvent]s
  /// for devices found through [requestLEScan].
  ///
  /// The device that is in this event is a [AdvertisementBluetoothDevice] this
  /// bluetooth device lacks a gatt server and can thus not communicate with
  /// any [BluetoothCharacteristic]s. Use [requestAdvertisementDevice] to get
  /// a [BluetoothDevice] based on the [AdvertisementBluetoothDevice].
  ///
  /// Even if the browser doesn't support [requestLEScan] this stream will not
  /// throw an [Error]. It will just never emit any events since you can't start
  /// a scan.
  ///
  Stream<AdvertisementReceivedEvent<AdvertisementBluetoothDevice>>
      get advertisements;

  ///
  /// This is a setting for (new) devices if it should use memory for advertisements.
  ///
  /// Not every device sends a completely filled out advertisement packet for
  /// each advertisements. For example every other packet might have the name
  /// field missing. If this setting is set to `true` it will use the last received
  /// event to fill in the missing data on the current new event.
  ///
  /// You may want to disable this for certain projects in that case set this
  /// option to `false`.
  ///
  /// It can also be set on a per device level if that is desirable.
  /// [BluetoothDevice.advertisementsUseMemory].
  ///
  bool defaultAdvertisementsMemory = true;

  ///
  /// The [devices] stream has a [Set] of [BluetoothDevice]s. If the
  /// [BluetoothDevice.forget] method is used then it should also be removed
  /// from the [devices] stream. This method takes in a [BluetoothDevice] to
  /// be removed from this stream.
  ///
  Future<void> _forgetDevice(final BluetoothDevice device);
}
