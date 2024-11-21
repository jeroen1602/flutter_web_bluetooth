// ignore: use_string_in_part_of_directives
part of flutter_web_bluetooth;

///
/// This is the object that is emitted for the `advertisementreceived` event.
/// This object only has the specific fields for the event and not the fields
/// form the basic javascript [Event] (target field and all that stuff).
///
/// This class is almost the same as [BluetoothAdvertisementReceivedEvent] however
/// instead of holding a [WebBluetoothDevice] it holds either a
/// [BluetoothDevice], or a [AdvertisementBluetoothDevice].
///
class AdvertisementReceivedEvent<D extends AdvertisementBluetoothDevice> {
  ///
  /// The device that this event was fired for.
  ///
  final D device;

  ///
  /// A list of service UUIDS that this advertisement says the device's GATT
  /// server supports. **Note** the [List] returned is a [List.unmodifiable]
  /// version so you cannot modify the returned value without causing errors!
  ///
  /// These UUIDS must be described in the [RequestOptions.optionalServices] or
  /// [BluetoothScanFilter.services] or else they will be filtered out
  /// even though the device may support them.
  ///
  final List<String> uuids;

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
  final UnmodifiableMapView<int, ByteData> manufacturerData;

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
  final UnmodifiableMapView<String, ByteData> serviceData;

  ///
  /// The name of the device, not every device advertises this.
  ///
  final String? name;

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
  final int? rssi;

  ///
  /// The original power that the advertisement was broadcast in. This is
  /// measured in dBm (decibel-milliwatts).
  ///
  /// This can be used to compute the path loss with [txPower] - [rssi].
  ///
  /// This value is technically a byte in size, but dart2js doesn't have that
  /// type so it is an [int] here.
  ///
  final int? txPower;

  ///
  /// Appearance is the way the device should show up in the user interface.
  /// For example if it should show up as a phone `0x0040` to 0x007F` or
  /// as a speaker `0x0841`. The full list of appearance values can be found
  /// in the Bluetooth specifications found here:
  /// https://specificationrefs.bluetooth.com/assigned-values/Appearance%20Values.pdf
  ///
  /// The value is technically an unsigned short (uint16), but dart2js doesn't
  /// have that type so it is an [int] here.
  ///
  final int? appearance;

  ///
  /// Create a new instance from an advertisement event
  ///
  AdvertisementReceivedEvent(
      final BluetoothAdvertisementReceivedEvent advertisementReceivedEvent,
      final D device)
      : this._(
            advertisementReceivedEvent.uuids,
            advertisementReceivedEvent.manufacturerData,
            advertisementReceivedEvent.serviceData,
            advertisementReceivedEvent.name,
            advertisementReceivedEvent.rssi,
            advertisementReceivedEvent.txPower,
            advertisementReceivedEvent.appearance,
            device);

  AdvertisementReceivedEvent._(
      this.uuids,
      this.manufacturerData,
      this.serviceData,
      this.name,
      this.rssi,
      this.txPower,
      this.appearance,
      this.device);

  ///
  /// Not every device sends all the fields in each advertisement packet.
  /// (probably has something to do with the maximum size of such a packet).
  ///
  /// This however makes it more difficult for the developer to keep track of
  /// the most up-to-date data. This factory creates a new instance of the
  /// event but fills in the missing data from [newEvent] with the information
  /// that was stored form the last event that is in [memory].
  ///
  /// Below in an example how you could implement this memorization.
  /// ```dart
  /// AdvertisementReceivedEvent? memory;
  ///
  /// stream.map((event) {
  ///   final convertedEvent =
  ///             AdvertisementReceivedEvent(event, device);
  ///
  ///   var combined = convertedEvent;
  ///   if (memory != null) {
  ///     combined = AdvertisementReceivedEvent.withMemory(memory!, convertedEvent);
  ///   }
  ///   memory = combined;
  ///   return combined;
  /// });
  ///
  /// ```
  factory AdvertisementReceivedEvent.withMemory(
      final AdvertisementReceivedEvent<D> memory,
      final AdvertisementReceivedEvent<D> newEvent) {
    assert(memory.device == newEvent.device,
        "The device from memory should be the same as from the new event");

    final uuids = newEvent.uuids;
    final manufacturerData = newEvent.manufacturerData;
    final serviceData = newEvent.serviceData;

    final name = newEvent.name ?? memory.name;

    final rssi = newEvent.rssi;
    final txPower = newEvent.txPower;

    final appearance = newEvent.appearance ?? memory.appearance;

    return AdvertisementReceivedEvent._(
      uuids,
      manufacturerData,
      serviceData,
      name,
      rssi,
      txPower,
      appearance,
      newEvent.device,
    );
  }
}
