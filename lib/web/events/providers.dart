part of "../../js_web_bluetooth.dart";

///
/// An abstract class that contains all the events that could be fired on
/// Web Bluetooth [EventTarget]s
///
abstract final class BluetoothEventStreamProviders {
  // region NavigatorBluetoothEventHandlers

  ///
  /// An event fired when the bluetooth adapter becomes available or unavailable.
  ///
  /// this is fired either on [Bluetooth.getAvailability] or when the adapter
  /// becomes available.
  ///
  static const EventStreamProvider<WebBluetoothValueEvent<JSBoolean>>
      availabilityChanged =
      EventStreamProvider<WebBluetoothValueEvent<JSBoolean>>(
          "availabilitychanged");

  // endregion
  // region: BluetoothDeviceEventHandlers
  ///
  /// An event fired when the gatt server disconnects. Either the
  /// [NativeBluetoothRemoteGATTServer.disconnect] method was called. Or the
  /// device is out of range/ turned off.
  ///
  /// This event will bubble through the [WebBluetoothDevice] to the root
  /// [Bluetooth] instance.
  ///
  static const EventStreamProvider<Event> gattServerDisconnectedEvent =
      EventStreamProvider<Event>("gattserverdisconnected");

  ///
  /// An event fired when an advertisement packet is received.
  ///
  /// These events are fired after calling [WebBluetoothDevice.watchAdvertisements].
  ///
  /// This event will bubble through the [WebBluetoothDevice] to the root
  /// [Bluetooth] instance.
  ///
  static const EventStreamProvider<BluetoothAdvertisementReceivedEvent>
      advertisementReceivedEvent =
      EventStreamProvider<BluetoothAdvertisementReceivedEvent>(
          "advertisementreceived");

  // endregion

  // region: CharacteristicEventHandlers
  ///
  /// An event fired on an characteristic when the characteristic value has changed.
  ///
  /// This event is fired after calling [WebBluetoothRemoteGATTCharacteristic.readValue]
  /// or [WebBluetoothRemoteGATTCharacteristic.startNotifications] is used to
  /// start receiving these events.
  ///
  /// This event will bubble through the [WebBluetoothRemoteGATTCharacteristic],
  /// then [WebBluetoothRemoteGATTService], then the [WebBluetoothDevice],
  /// and finally the root [Bluetooth] instance.
  ///
  static const EventStreamProvider<Event> characteristicValueChangedEvent =
      EventStreamProvider<Event>("characteristicvaluechanged");

  // endregion

  // region: ServiceEventHandlers

  ///
  /// An event fired on a device when a service has been added.
  ///
  /// This event will bubble through the [WebBluetoothRemoteGATTService], then
  /// the [WebBluetoothDevice] and finally the root [Bluetooth] instance.
  ///
  static const EventStreamProvider<Event> serviceAddedEvent =
      EventStreamProvider<Event>("serviceadded");

  ///
  /// An event fired on a device when a service has changed.
  ///
  /// This event will bubble through the [WebBluetoothRemoteGATTService] to
  /// the [WebBluetoothDevice] and finally root [Bluetooth] instance.
  ///
  static const EventStreamProvider<Event> serviceChangedEvent =
      EventStreamProvider<Event>("servicechanged");

  ///
  /// An event fired on a device when a service has been removed.
  ///
  /// This event will bubble through the [WebBluetoothRemoteGATTService] to
  /// the [WebBluetoothDevice] and finally root [Bluetooth] instance.
  ///
  static const EventStreamProvider<Event> serviceRemovedEvent =
      EventStreamProvider<Event>("serviceremoved");
// endregion
}
