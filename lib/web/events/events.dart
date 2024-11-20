part of "../../js_web_bluetooth.dart";

///
/// An extension class to add events as streams to the [WebBluetoothDevice].
///
extension WebBluetoothDeviceEvents on WebBluetoothDevice {
  // region: BluetoothDeviceEventHandlers

  ///
  /// An event fired when the gatt server disconnects. Either the
  /// [NativeBluetoothRemoteGATTServer.disconnect] method was called. Or the
  /// device is out of range/ turned off.
  ///
  /// This event will bubble through the [WebBluetoothDevice] to the root
  /// [Bluetooth] instance.
  ///
  Stream<Event> get onGattServerDisconnected =>
      BluetoothEventStreamProviders.gattServerDisconnectedEvent.forTarget(this);

  ///
  /// An event fired when an advertisement packet is received.
  ///
  /// These events are fired after calling [WebBluetoothDevice.watchAdvertisements].
  ///
  /// This event will bubble through the [WebBluetoothDevice] to the root
  /// [Bluetooth] instance.
  ///
  Stream<BluetoothAdvertisementReceivedEvent> get onAdvertisementReceived =>
      BluetoothEventStreamProviders.advertisementReceivedEvent.forTarget(this);

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
  Stream<Event> get onCharacteristicValueChanged =>
      BluetoothEventStreamProviders.characteristicValueChangedEvent
          .forTarget(this);

  // endregion

  // region: ServiceEventHandlers
  ///
  /// An event fired on a device when a service has been added.
  ///
  /// This event will bubble through the [WebBluetoothRemoteGATTService], then
  /// the [WebBluetoothDevice] and finally the root [Bluetooth] instance.
  ///
  Stream<Event> get onServiceAdded =>
      BluetoothEventStreamProviders.serviceAddedEvent.forTarget(this);

  ///
  /// An event fired on a device when a service has changed.
  ///
  /// This event will bubble through the [WebBluetoothRemoteGATTService] to
  /// the [WebBluetoothDevice] and finally root [Bluetooth] instance.
  ///
  Stream<Event> get onServiceChanged =>
      BluetoothEventStreamProviders.serviceChangedEvent.forTarget(this);

  ///
  /// An event fired on a device when a service has been removed.
  ///
  /// This event will bubble through the [WebBluetoothRemoteGATTService] to
  /// the [WebBluetoothDevice] and finally root [Bluetooth] instance.
  ///
  Stream<Event> get onServiceRemoved =>
      BluetoothEventStreamProviders.serviceRemovedEvent.forTarget(this);
// endregion
}

///
/// An extension class to add events as streams to the [_NativeBluetooth].
///
extension _NativeBluetoothEvents on _NativeBluetooth {
  // region NavigatorBluetoothEventHandlers

  ///
  /// An event fired when the bluetooth adapter becomes available or unavailable.
  ///
  /// this is fired either on [Bluetooth.getAvailability] or when the adapter
  /// becomes available.
  ///
  Stream<WebBluetoothValueEvent<JSBoolean>> get availabilityChanged =>
      BluetoothEventStreamProviders.availabilityChanged.forTarget(this);

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
  Stream<Event> get onGattServerDisconnected =>
      BluetoothEventStreamProviders.gattServerDisconnectedEvent.forTarget(this);

  ///
  /// An event fired when an advertisement packet is received.
  ///
  /// These events are fired after calling [WebBluetoothDevice.watchAdvertisements].
  ///
  /// This event will bubble through the [WebBluetoothDevice] to the root
  /// [Bluetooth] instance.
  ///
  Stream<BluetoothAdvertisementReceivedEvent> get onAdvertisementReceived =>
      BluetoothEventStreamProviders.advertisementReceivedEvent.forTarget(this);

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
  Stream<Event> get onCharacteristicValueChanged =>
      BluetoothEventStreamProviders.characteristicValueChangedEvent
          .forTarget(this);

  // endregion

  // region: ServiceEventHandlers
  ///
  /// An event fired on a device when a service has been added.
  ///
  /// This event will bubble through the [WebBluetoothRemoteGATTService], then
  /// the [WebBluetoothDevice] and finally the root [Bluetooth] instance.
  ///
  Stream<Event> get onServiceAdded =>
      BluetoothEventStreamProviders.serviceAddedEvent.forTarget(this);

  ///
  /// An event fired on a device when a service has changed.
  ///
  /// This event will bubble through the [WebBluetoothRemoteGATTService] to
  /// the [WebBluetoothDevice] and finally root [Bluetooth] instance.
  ///
  Stream<Event> get onServiceChanged =>
      BluetoothEventStreamProviders.serviceChangedEvent.forTarget(this);

  ///
  /// An event fired on a device when a service has been removed.
  ///
  /// This event will bubble through the [WebBluetoothRemoteGATTService] to
  /// the [WebBluetoothDevice] and finally root [Bluetooth] instance.
  ///
  Stream<Event> get onServiceRemoved =>
      BluetoothEventStreamProviders.serviceRemovedEvent.forTarget(this);
// endregion
}

///
/// An extension class to add events as streams to the [WebBluetoothRemoteGATTService].
///
extension WebBluetoothRemoteGATTServiceEvents on WebBluetoothRemoteGATTService {
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
  Stream<Event> get onCharacteristicValueChanged =>
      BluetoothEventStreamProviders.characteristicValueChangedEvent
          .forTarget(this);

// endregion

  // region: ServiceEventHandlers
  ///
  /// An event fired on a device when a service has been added.
  ///
  /// This event will bubble through the [WebBluetoothRemoteGATTService], then
  /// the [WebBluetoothDevice] and finally the root [Bluetooth] instance.
  ///
  Stream<Event> get onServiceAdded =>
      BluetoothEventStreamProviders.serviceAddedEvent.forTarget(this);

  ///
  /// An event fired on a device when a service has changed.
  ///
  /// This event will bubble through the [WebBluetoothRemoteGATTService] to
  /// the [WebBluetoothDevice] and finally root [Bluetooth] instance.
  ///
  Stream<Event> get onServiceChanged =>
      BluetoothEventStreamProviders.serviceChangedEvent.forTarget(this);

  ///
  /// An event fired on a device when a service has been removed.
  ///
  /// This event will bubble through the [WebBluetoothRemoteGATTService] to
  /// the [WebBluetoothDevice] and finally root [Bluetooth] instance.
  ///
  Stream<Event> get onServiceRemoved =>
      BluetoothEventStreamProviders.serviceRemovedEvent.forTarget(this);
// endregion
}

///
/// An extension class to add events as streams to the [WebBluetoothRemoteGATTCharacteristic].
///
extension WebBluetoothRemoteGATTCharacteristicEvents
    on WebBluetoothRemoteGATTCharacteristic {
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
  Stream<Event> get onCharacteristicValueChanged =>
      BluetoothEventStreamProviders.characteristicValueChangedEvent
          .forTarget(this);

// endregion
}
