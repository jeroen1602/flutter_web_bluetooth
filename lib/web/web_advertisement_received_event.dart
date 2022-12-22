part of js_web_bluetooth;

///
/// An interface for the `advertisementreceived` event.
///
/// This interface exists to ensure that the web version of this event has the
/// same fields as the version in src. The only difference between the two
/// versions is that they reference a different bluetooth device. Because the
/// version in src has more creature comfort methods to help out.
///
abstract class AdvertisementReceivedEventInterface<T> {
  ///
  /// The device that this event was fired for.
  ///
  final T device;

  ///
  /// A list of service UUIDS that this advertisement says the device's GATT
  /// server supports. **Note** the [List] returned is a [List.unmodifiable]
  /// version so you cannot modify the returned value without causing errors!
  ///
  /// These UUIDS must be described in the [RequestOptions.optionalServices] or
  /// [BluetoothScanFilter.services] or else they will be filtered out
  /// even though the device may support them.
  ///
  List<String> get uuids;

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
  UnmodifiableMapView<int, ByteData> get manufacturerData;

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
  UnmodifiableMapView<String, ByteData> get serviceData;

  ///
  /// The name of the device, not every device advertises this.
  ///
  String? get name;

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
  int? get rssi;

  ///
  /// The original power that the advertisement was broadcast in. This is
  /// measured in dBm (decibel-milliwatts).
  ///
  /// This can be used to compute the path loss with [txPower] - [rssi].
  ///
  /// This value is technically a byte in size, but dart2js doesn't have that
  /// type so it is an [int] here.
  ///
  int? get txPower;

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
  int? get appearance;

  ///
  /// Set the device for this abstract class.
  ///
  AdvertisementReceivedEventInterface(this.device);
}

///
/// This is the object that is emitted for the `advertisementreceived` event.
/// This object only has the specific fields for the event and not the fields
/// form the basic javascript [Event] (target field and all that stuff).
///
/// See:
///
/// - https://webbluetoothcg.github.io/web-bluetooth/#advertising-events
///
class WebAdvertisementReceivedEvent
    extends AdvertisementReceivedEventInterface<WebBluetoothDevice> {
  @override
  final List<String> uuids;

  static List<String> _parseUUIDS(final Object jsObject) =>
      List.unmodifiable(WebBluetoothConverters.convertJSObjectToList(
          _JSUtil.getProperty(jsObject, "uuids")));

  @override
  final UnmodifiableMapView<int, ByteData> manufacturerData;

  @override
  final UnmodifiableMapView<String, ByteData> serviceData;

  static UnmodifiableMapView<K, ByteData> _getByteDataMap<K>(
      final Object jsObject, final String name) {
    final Object original = _JSUtil.getProperty(jsObject, name);
    final Map<K, ByteData> converted =
        WebBluetoothConverters.convertJsObjectToMap<K, ByteData>(original,
            valueConverter: WebBluetoothConverters.convertJSDataViewToByteData);
    return UnmodifiableMapView<K, ByteData>(converted);
  }

  @override
  final String? name;

  @override
  final int? rssi;

  @override
  final int? txPower;

  @override
  final int? appearance;

  ///
  /// Convert an event received from a single js object to something that
  /// can actually be used.
  ///
  /// [jsObject] is the original object. [device] is the device that the event
  /// was fired for. Normally the device would be inside of the [jsObject] but
  /// then that device would need to be wrapped in another [WebBluetoothDevice]
  /// while the original can just be re-used.
  ///
  factory WebAdvertisementReceivedEvent.fromJSObject(
      final Object jsObject, final WebBluetoothDevice device) {
    if (!_JSUtil.hasProperty(jsObject, "device")) {
      throw UnsupportedError("JSObject does not have a device.");
    }
    if (!_JSUtil.hasProperty(jsObject, "uuids")) {
      throw UnsupportedError("JSObject does not have a uuids.");
    }
    if (!_JSUtil.hasProperty(jsObject, "manufacturerData")) {
      throw UnsupportedError("JSObject does not have a manufacturerData.");
    }
    if (!_JSUtil.hasProperty(jsObject, "serviceData")) {
      throw UnsupportedError("JSObject does not have a serviceData.");
    }

    final List<String> uuids = _parseUUIDS(jsObject);
    final UnmodifiableMapView<int, ByteData> manufacturerData =
        _getByteDataMap(jsObject, "manufacturerData");
    final UnmodifiableMapView<String, ByteData> serviceData =
        _getByteDataMap(jsObject, "serviceData");

    final String? name = _JSUtil.getProperty(jsObject, "name") as String?;
    final int? rssi = _JSUtil.getProperty(jsObject, "rssi") as int?;
    final int? txPower = _JSUtil.getProperty(jsObject, "txPower") as int?;
    final int? appearance = _JSUtil.getProperty(jsObject, "appearance") as int?;

    return WebAdvertisementReceivedEvent._(
        uuids: uuids,
        manufacturerData: manufacturerData,
        serviceData: serviceData,
        name: name,
        rssi: rssi,
        txPower: txPower,
        appearance: appearance,
        device: device);
  }

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
  /// WebAdvertisementReceivedEvent? memory;
  ///
  /// stream.map((event) {
  ///   final convertedEvent =
  ///             WebAdvertisementReceivedEvent.fromJSObject(event, device);
  ///
  ///   var combined = convertedEvent;
  ///   if (memory != null) {
  ///     combined = WebAdvertisementReceivedEvent.withMemory(memory!, convertedEvent);
  ///   }
  ///   memory = combined;
  ///   return combined;
  /// });
  ///
  /// ```
  factory WebAdvertisementReceivedEvent.withMemory(
      final WebAdvertisementReceivedEvent memory,
      final WebAdvertisementReceivedEvent newEvent) {
    assert(memory.device == newEvent.device,
        "The device from memory should be the same as from the new event");

    final List<String> uuids = newEvent.uuids;
    final UnmodifiableMapView<int, ByteData> manufacturerData =
        newEvent.manufacturerData;
    final UnmodifiableMapView<String, ByteData> serviceData =
        newEvent.serviceData;

    late String? name;
    if (newEvent.name != null) {
      name = newEvent.name;
    } else {
      name = memory.name;
    }

    final int? rssi = newEvent.rssi;
    final int? txPower = newEvent.txPower;

    late int? appearance;
    if (newEvent.appearance != null) {
      appearance = newEvent.appearance;
    } else {
      appearance = memory.appearance;
    }

    return WebAdvertisementReceivedEvent._(
        uuids: uuids,
        manufacturerData: manufacturerData,
        serviceData: serviceData,
        name: name,
        rssi: rssi,
        txPower: txPower,
        appearance: appearance,
        device: newEvent.device);
  }

  WebAdvertisementReceivedEvent._({
    required this.uuids,
    required this.manufacturerData,
    required this.serviceData,
    required final WebBluetoothDevice device,
    this.name,
    this.rssi,
    this.txPower,
    this.appearance,
  }) : super(device);
}
