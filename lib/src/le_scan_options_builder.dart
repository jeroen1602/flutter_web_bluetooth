part of flutter_web_bluetooth;

///
/// A builder for creating the scan options needed for
/// [FlutterWebBluetooth.requestLeScan]. This is needed to tell the browser
/// what devices should be found while scanning.
///
class LEScanOptionsBuilder {
  final bool _acceptAllAdvertisements;
  final bool _keepRepeatedDevices;
  final List<RequestFilterBuilder> _requestFilters;

  ///
  /// Tell the browser to only accept devices matching the [requestFilters].
  /// A device has to only match one filter, so if you support multiple device
  /// types then you need to add a filter for each device type.
  ///
  /// Normally scans will discard the second and subsequent advertisements from
  /// a single device to save power. If you need to receive them, set
  /// [keepRepeatedDevices] to `true`. Note that setting [keepRepeatedDevices]
  /// to `false` doesn't guarantee you won’t get redundant events;
  /// It just allows the UA to save power by omitting them.
  ///
  /// May throw [StateError] if no filters are set, consider using
  /// [LEScanOptionsBuilder.acceptAllAdvertisements].
  ///
  LEScanOptionsBuilder(List<RequestFilterBuilder> requestFilters,
      {bool keepRepeatedDevices = false})
      : _acceptAllAdvertisements = false,
        _keepRepeatedDevices = keepRepeatedDevices,
        _requestFilters = requestFilters {
    if (_requestFilters.isEmpty) {
      throw StateError('No filters have been set, consider using '
          'LEScanOptionsBuilder.acceptAllAdvertisements() instead.');
    }
  }

  ///
  /// Tell the browser to just accept all device advertisements.
  ///
  /// Normally scans will discard the second and subsequent advertisements from
  /// a single device to save power. If you need to receive them, set
  /// [keepRepeatedDevices] to `true`. Note that setting [keepRepeatedDevices]
  /// to `false` doesn't guarantee you won’t get redundant events;
  /// It just allows the UA to save power by omitting them.
  ///
  LEScanOptionsBuilder.acceptAllAdvertisements(
      {bool keepRepeatedDevices = false})
      : _acceptAllAdvertisements = true,
        _keepRepeatedDevices = keepRepeatedDevices,
        _requestFilters = [];

  ///
  /// Convert the input requests to a [BluetoothLEScanOptions] objected needed
  /// to start a Bluetooth LE scan.
  ///
  BluetoothLEScanOptions toRequestOptions() {
    if (_acceptAllAdvertisements) {
      return BluetoothLEScanOptions(
          keepRepeatedDevices: _keepRepeatedDevices,
          acceptAllAdvertisements: _acceptAllAdvertisements);
    } else {
      return BluetoothLEScanOptions(
          keepRepeatedDevices: _keepRepeatedDevices,
          filters: _requestFilters.map((final e) => e.toScanFilter()).toList());
    }
  }
}
