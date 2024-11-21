part of "../../js_web_bluetooth.dart";

///
/// This is the object that is emitted for the `advertisementreceived` event.
/// This object only has the specific fields for the event and not the fields
/// form the basic javascript [Event] (target field and all that stuff).
///
/// See:
///
/// - https://webbluetoothcg.github.io/web-bluetooth/#advertising-events
///
extension type BluetoothAdvertisementReceivedEvent._(JSObject _)
    implements JSObject, Event {
  ///
  /// The device that this event was fired for.
  ///
  external WebBluetoothDevice get device;

  @JS("uuids")
  external JSArray<JSString> get _uuids;

  ///
  /// A list of service UUIDS that this advertisement says the device's GATT
  /// server supports. **Note** the [List] returned is a [List.unmodifiable]
  /// version so you cannot modify the returned value without causing errors!
  ///
  /// These UUIDS must be described in the [RequestOptions.optionalServices] or
  /// [BluetoothScanFilter.services] or else they will be filtered out
  /// even though the device may support them.
  ///
  List<String> get uuids =>
      List.unmodifiable(_uuids.toDart.map((final x) => x.toDart));

  @JS("manufacturerData")
  external JSMap<JSNumber, JSDataView> get _manufacturerData;

  ///
  /// This map shows the manufacturer data of the device.
  ///
  /// The key is a 16 bit unsigned short but dart2js doesn't have that data
  /// type so an [int] is used instead.
  /// The key is the company identifier code which can be found on the
  /// Bluetooth standards website:
  /// https://www.bluetooth.com/specifications/assigned-numbers/company-identifiers/.
  ///
  /// The value is a [ByteData] that contains the device's name.
  ///
  UnmodifiableMapView<int, ByteData> get manufacturerData =>
      UnmodifiableMapView({
        for (final item in _manufacturerData.toDart.entries)
          item.key.toDartInt: item.value.toDart
      });

  @JS("serviceData")
  external JSMap<JSString, JSDataView> get _serviceData;

  ///
  /// Some devices send service data in their advertisements. For example a
  /// heart rate sensor may advertise the current heart rate it is detecting.
  ///
  /// These values will show up in this map. The key is the UUID of the service
  /// that has been reported and the value is [ByteData] that contains the value
  /// for this service. How to interpret this data depends on the data send
  /// and also the service.
  ///
  /// The service UUIDS must be described in the
  /// [RequestOptions.optionalServices] or [BluetoothScanFilter.services] or
  /// else they will be filtered out even though the device may support them.
  ///
  UnmodifiableMapView<String, ByteData> get serviceData => UnmodifiableMapView({
        for (final item in _serviceData.toDart.entries)
          item.key.toDart: item.value.toDart
      });

  @JS("name")
  external JSString? get _name;

  ///
  /// The name of the device, not every device advertises this.
  ///
  String? get name =>
      (_name != null && _name.isDefinedAndNotNull) ? _name!.toDart : null;

  @JS("rssi")
  external JSNumber get _rssi;

  ///
  /// The RSSI is the received signal strength indicator. It is the signal
  /// strength that the advertisement was received with in dBm
  /// (decibel-milliwatts).
  ///
  /// This can be used to compute the path loss with [txPower] - [rssi].
  ///
  /// This value is technically a byte in size, but dart2js doesn't have that
  /// type so it is an [int] here.
  ///
  int? get rssi => _rssi.isDefinedAndNotNull ? _rssi.toDartInt : null;

  @JS("txPower")
  external JSNumber get _txPower;

  ///
  /// The original power that the advertisement was broadcast in. This is
  /// measured in dBm (decibel-milliwatts).
  ///
  /// This can be used to compute the path loss with [txPower] - [rssi].
  ///
  /// This value is technically a byte in size, but dart2js doesn't have that
  /// type so it is an [int] here.
  ///
  int? get txPower => _txPower.isDefinedAndNotNull ? _txPower.toDartInt : null;

  @JS("appearance")
  external JSNumber get _appearance;

  ///
  /// Appearance is the way the device should show up in the user interface.
  /// For example if it should show up as a phone `0x0040` to `0x007F` or
  /// as a speaker `0x0841`. The full list of appearance values can be found
  /// in the Bluetooth specifications found here:
  /// https://specificationrefs.bluetooth.com/assigned-values/Appearance%20Values.pdf
  ///
  /// The value is technically an unsigned short (uint16), but dart2js doesn't
  /// have that type so it is an [int] here.
  ///
  int? get appearance =>
      _appearance.isDefinedAndNotNull ? _appearance.toDartInt : null;
}
