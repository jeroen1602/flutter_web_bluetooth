part of "../js_web_bluetooth.dart";

///
/// An object representing a running Bluetooth LE scan.
/// This object can be retrieved using [Bluetooth.requestLEScan]. It will
/// have a copy of the [BluetoothLEScanOptions] used for the original call.
///
/// It additionally has an extra [active] field that represents if the scan
/// is still running.
///
/// **Note:** you need to keep a reference to this object if you want to be
/// able to stop the Bluetooth LE Scan in the future using [stop].
///
/// https://webbluetoothcg.github.io/web-bluetooth/scanning.html#bluetoothlescan
///
@JS()
extension type BluetoothLEScan._(JSObject _) implements JSObject {
  @JS("filters")
  external JSArray<BluetoothScanFilter> get _filters;

  ///
  /// A list of filters that were used to start (request) this Bluetooth LE scan.
  ///
  /// See [BluetoothLEScanOptions.filters]
  ///
  /// https://webbluetoothcg.github.io/web-bluetooth/scanning.html#dom-bluetoothlescan-filters
  ///
  List<BluetoothScanFilter> get filters => _filters.toDart;

  @JS("keepRepeatedDevices")
  external JSBoolean? get _keepRepeatedDevices;

  ///
  /// If this Bluetooth LE scan should keep repeated devices or just discard them.
  ///
  /// See [BluetoothLEScanOptions.keepRepeatedDevices]
  ///
  /// https://webbluetoothcg.github.io/web-bluetooth/scanning.html#dom-bluetoothlescan-keeprepeateddevices
  ///
  bool get keepRepeatedDevices =>
      _keepRepeatedDevices != null &&
      _keepRepeatedDevices.isDefinedAndNotNull &&
      _keepRepeatedDevices!.toDart;

  @JS("acceptAllAdvertisements")
  external JSBoolean? get _acceptAllAdvertisements;

  ///
  /// If this Bluetooth LE scan accepts all advertisements.
  ///
  /// See [BluetoothLEScanOptions.acceptAllAdvertisements]
  ///
  /// https://webbluetoothcg.github.io/web-bluetooth/scanning.html#dom-bluetoothlescan-acceptalladvertisements
  ///
  bool get acceptAllAdvertisements =>
      _acceptAllAdvertisements != null &&
      _acceptAllAdvertisements.isDefinedAndNotNull &&
      _acceptAllAdvertisements!.toDart;

  @JS("active")
  external JSBoolean? get _active;

  ///
  /// If this Bluetooth LE scan is (still) active. Meaning that it will generate
  /// new `advertisementreceived` events.
  ///
  /// If this is `false` then this object can safely be thrown away without
  /// risking that the scan can never be stopped. See [stop].
  ///
  /// https://webbluetoothcg.github.io/web-bluetooth/scanning.html#dom-bluetoothlescan-active
  ///
  bool get active =>
      _active != null && _active.isDefinedAndNotNull && _active!.toDart;

  ///
  /// Stop the currently running Bluetooth LE scan.
  ///
  /// This will result in [active] being set to `false`.
  ///
  /// If [active] is already `false` then nothing will happen.
  ///
  /// https://webbluetoothcg.github.io/web-bluetooth/scanning.html#dom-bluetoothlescan-stop
  ///
  external void stop();
}
