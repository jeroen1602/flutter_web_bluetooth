part of js_web_bluetooth;

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
class BluetoothLEScan {
  final Object _jsObject;

  List<BluetoothLEScanOptions>? _filters;

  ///
  /// A list of filters that were used to start (request) this Bluetooth LE scan.
  ///
  /// See [BluetoothLEScanOptions.filters]
  ///
  /// https://webbluetoothcg.github.io/web-bluetooth/scanning.html#dom-bluetoothlescan-filters
  ///
  List<BluetoothLEScanOptions> get filters {
    return _filters ??=
        WebBluetoothConverters.convertJSObjectToList<BluetoothLEScanOptions>(
            _JSUtil.getProperty(_jsObject, 'filters'));
  }

  bool? _keepRepeatedDevices;

  ///
  /// If this Bluetooth LE scan should keep repeated devices or just discard them.
  ///
  /// See [BluetoothLEScanOptions.keepRepeatedDevices]
  ///
  /// https://webbluetoothcg.github.io/web-bluetooth/scanning.html#dom-bluetoothlescan-keeprepeateddevices
  ///
  bool get keepRepeatedDevices {
    var keep = _keepRepeatedDevices;
    if (keep != null) {
      return keep;
    }
    keep =
        _JSUtil.getProperty(_jsObject, 'keepRepeatedDevices') as bool? ?? false;
    _keepRepeatedDevices = keep;
    return keep;
  }

  bool? _acceptAllAdvertisements;

  ///
  /// If this Bluetooth LE scan accepts all advertisements.
  ///
  /// See [BluetoothLEScanOptions.acceptAllAdvertisements]
  ///
  /// https://webbluetoothcg.github.io/web-bluetooth/scanning.html#dom-bluetoothlescan-acceptalladvertisements
  ///
  bool get acceptAllAdvertisements {
    var all = _acceptAllAdvertisements;
    if (all != null) {
      return all;
    }
    all = _JSUtil.getProperty(_jsObject, 'acceptAllAdvertisements') as bool? ??
        false;
    _acceptAllAdvertisements = all;
    return all;
  }

  ///
  /// If this Bluetooth LE scan is (still) active. Meaning that it will generate
  /// new `advertisementreceived` events.
  ///
  /// If this is `false` then this object can be safely throw away without
  /// risking that the scan can never be stopped. See [stop].
  ///
  /// https://webbluetoothcg.github.io/web-bluetooth/scanning.html#dom-bluetoothlescan-active
  ///
  bool get active {
    return _JSUtil.getProperty(_jsObject, 'active') as bool? ?? false;
  }

  ///
  /// Stop the currently running Bluetooth LE scan.
  ///
  /// This will result in [active] to be `false`.
  ///
  /// If [active] is already `false` the nothing will happen.
  ///
  /// https://webbluetoothcg.github.io/web-bluetooth/scanning.html#dom-bluetoothlescan-stop
  ///
  void stop() {
    _JSUtil.callMethod(_jsObject, 'stop', []);
  }

  ///
  /// Construct a new instance.
  ///
  /// To get an instance use [Bluetooth.requestLEScan].
  ///
  BluetoothLEScan.fromJSObject(this._jsObject) {
    if (!_JSUtil.hasProperty(_jsObject, 'filters')) {
      throw UnsupportedError('JSObject does not have filters.');
    }
    if (!_JSUtil.hasProperty(_jsObject, 'keepRepeatedDevices')) {
      throw UnsupportedError('JSObject does not have keepRepeatedDevices.');
    }
    if (!_JSUtil.hasProperty(_jsObject, 'acceptAllAdvertisements')) {
      throw UnsupportedError('JSObject does not have acceptAllAdvertisements.');
    }
    if (!_JSUtil.hasProperty(_jsObject, 'active')) {
      throw UnsupportedError('JSObject does not have active.');
    }
    if (!_JSUtil.hasProperty(_jsObject, 'stop')) {
      throw UnsupportedError('JSObject does not have stop.');
    }
  }
}
