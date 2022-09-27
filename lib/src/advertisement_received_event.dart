part of flutter_web_bluetooth;

///
/// This is the object that is emitted for the `advertisementreceived` event.
/// This object only has the specific fields for the event and not the fields
/// form the basic javascript [Event] (target field and all that stuff).
///
/// This class is almost the same as [WebAdvertisementReceivedEvent] however
/// instead of holding a [WebBluetoothDevice] it holds a [BluetoothDevice].
///
class AdvertisementReceivedEvent
    extends AdvertisementReceivedEventInterface<BluetoothDevice> {
  final AdvertisementReceivedEventInterface<dynamic>
      _advertisementReceivedEvent;

  @override
  List<String> get uuids {
    return _advertisementReceivedEvent.uuids;
  }

  @override
  UnmodifiableMapView<int, ByteData> get manufacturerData {
    return _advertisementReceivedEvent.manufacturerData;
  }

  @override
  UnmodifiableMapView<String, ByteData> get serviceData {
    return _advertisementReceivedEvent.serviceData;
  }

  @override
  String? get name {
    return _advertisementReceivedEvent.name;
  }

  @override
  int? get rssi {
    return _advertisementReceivedEvent.rssi;
  }

  @override
  int? get txPower {
    return _advertisementReceivedEvent.txPower;
  }

  @override
  int? get appearance {
    return _advertisementReceivedEvent.appearance;
  }

  AdvertisementReceivedEvent._(
      this._advertisementReceivedEvent, BluetoothDevice device)
      : super(device);
}
