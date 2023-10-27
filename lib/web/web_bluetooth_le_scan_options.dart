part of "../js_web_bluetooth.dart";

///
/// The js object for request options. This is used for [Bluetooth.requestLEScan].
///
/// Either [filters] or [acceptAllAdvertisements] must have something meaningful set
/// in them, they can't be set at the same time.
/// If for example [acceptAllAdvertisements] is `true` and [filters] is not an empty
/// list. Then an Error will be thrown when trying to request devices.
///
/// https://webbluetoothcg.github.io/web-bluetooth/scanning.html#dictdef-bluetoothlescanoptions
///
@JS()
@anonymous
class BluetoothLEScanOptions {
  ///
  /// A list of filters that the accepted device must meet.
  ///
  /// A device must meet at least one filter before the browser will listen
  /// to its advertisements.
  ///
  /// A [filters] list cannot be set while [acceptAllAdvertisements] is `true`.
  ///
  external List<BluetoothScanFilter> get filters;

  ///
  /// Normally scans will discard the second and subsequent advertisements from
  /// a single device to save power. If you need to receive them, set
  /// [keepRepeatedDevices] to `true`. Note that setting [keepRepeatedDevices]
  /// to `false` doesn't guarantee you won’t get redundant events;
  /// It just allows the UA to save power by omitting them.
  ///
  /// Defaults to `false`.
  ///
  external bool get keepRepeatedDevices;

  ///
  /// If all advertisements should be received.
  ///
  /// This cannot be true while a [filters] list is set.
  ///
  /// Defaults to `false`.
  ///
  external bool get acceptAllAdvertisements;

  ///
  /// A constructor for Bluetooth LE scan options.
  ///
  /// Because of how the conversion to JS works, there is a difference between
  /// leaving an item blank in this constructor and setting it to `null`.
  ///
  external factory BluetoothLEScanOptions(
      {final List<BluetoothScanFilter> filters,
      final bool keepRepeatedDevices,
      final bool acceptAllAdvertisements});
}
