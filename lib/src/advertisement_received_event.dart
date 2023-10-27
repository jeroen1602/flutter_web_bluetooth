// ignore: use_string_in_part_of_directives
part of flutter_web_bluetooth;

///
/// This is the object that is emitted for the `advertisementreceived` event.
/// This object only has the specific fields for the event and not the fields
/// form the basic javascript [Event] (target field and all that stuff).
///
/// This class is almost the same as [WebAdvertisementReceivedEvent] however
/// instead of holding a [WebBluetoothDevice] it holds either a
/// [BluetoothDevice], or a [AdvertisementBluetoothDevice].
///
class AdvertisementReceivedEvent<D extends AdvertisementBluetoothDevice>
    extends AdvertisementReceivedEventInterface<D> {
  final AdvertisementReceivedEventInterface<dynamic>
      _advertisementReceivedEvent;

  @override
  List<String> get uuids => _advertisementReceivedEvent.uuids;

  @override
  UnmodifiableMapView<int, ByteData> get manufacturerData =>
      _advertisementReceivedEvent.manufacturerData;

  @override
  UnmodifiableMapView<String, ByteData> get serviceData =>
      _advertisementReceivedEvent.serviceData;

  @override
  String? get name => _advertisementReceivedEvent.name;

  @override
  int? get rssi => _advertisementReceivedEvent.rssi;

  @override
  int? get txPower => _advertisementReceivedEvent.txPower;

  @override
  int? get appearance => _advertisementReceivedEvent.appearance;

  AdvertisementReceivedEvent._(this._advertisementReceivedEvent, final D device)
      : super(device);
}
