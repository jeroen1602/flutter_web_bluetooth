import "package:flutter_web_bluetooth/flutter_web_bluetooth.dart";

///
/// A model to hold the data that is shown for a device on the main screen.
/// Devices retrieved through advertisements have different capabilities than
/// device retrieved through a request.
///
class MainPageDevice<D extends AdvertisementBluetoothDevice> {
  MainPageDevice(
      {required this.device,
      final AdvertisementReceivedEvent<AdvertisementBluetoothDevice>? event})
      : _event = event;

  MainPageDevice.fromEvent({required final AdvertisementReceivedEvent<D> event})
      : device = event.device,
        _event = event;

  final D device;

  final AdvertisementReceivedEvent<AdvertisementBluetoothDevice>? _event;

  int? get rssi => _event?.rssi;

  int? get txPower => _event?.txPower;

  int? get appearance => _event?.appearance;

  bool get hasEvent => _event != null;

  ///
  /// Check to see if two device have the same id.
  ///
  @override
  bool operator ==(final Object other) {
    if (other is! MainPageDevice) {
      return false;
    }
    return device == other.device;
  }

  @override
  int get hashCode => device.hashCode;
}
