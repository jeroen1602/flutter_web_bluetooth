part of flutter_web_bluetooth;

///
/// This is a [BluetoothDevice] that has been found using
/// [FlutterWebBluetooth.requestLeScan] and will be emitted by the
/// [FlutterWebBluetooth.advertisements] stream.
///
/// Devices that have been retrieved in that way don't have access to the GATT
/// server so communicating with them is not possible. If you need a [BluetoothDevice]
/// use [FlutterWebBluetooth.requestAdvertisementDevice] to request the user to
/// give access to more of the features of the device.
///
class AdvertisementBluetoothDevice {
  ///
  /// Construct a new instance.
  ///
  /// **This should only be done by the library or if you're testing.**
  ///
  /// Get a new instance by calling [FlutterWebBluetooth.requestLeScan] and
  /// listening to the [FlutterWebBluetooth.advertisements] stream and
  /// getting the device from [AdvertisementReceivedEvent.device].
  ///
  AdvertisementBluetoothDevice(this._bluetoothDevice);

  final WebBluetoothDevice _bluetoothDevice;

  ///
  /// Get the id of the device.
  ///
  /// This id is randomly generated by the browser. A new id is generated for
  /// each session unless a flag is used to remember previously connected
  /// devices.
  ///
  /// The browser may decide how this is generated. On Chrome this is 128
  /// randomly generated bits that are encoded in base 64.
  ///
  String get id => _bluetoothDevice.id;

  ///
  /// A human readable name of the device.
  ///
  /// This name comes straight from the device itself.
  ///
  /// You could also use the [BluetoothDefaultCharacteristicUUIDS.deviceName]
  /// to get the same value (if it exists).
  ///
  /// And maybe even rename it if it allows for writing.
  ///
  String? get name => _bluetoothDevice.name;

  ///
  /// Check to see if two device have the same id.
  ///
  @override
  bool operator ==(final Object other) {
    if (other is! AdvertisementBluetoothDevice) {
      return false;
    }
    return id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}

///
/// A Bluetooth low energy (web) device. This represents a device that (may)
/// be connected to the browser using BLE. This is a descendant of
/// [AdvertisementBluetoothDevice] with an actual [gatt] server so it can
/// communicate with the [BluetoothService]s and [BluetoothCharacteristic]s of
/// the device.
///
/// You can get a [BluetoothDevice] by calling
/// [FlutterWebBluetooth.requestDevice] or
/// [FlutterWebBluetooth.requestAdvertisementDevice].
///
class BluetoothDevice extends AdvertisementBluetoothDevice {
  ///
  /// A constructor for a new device.
  ///
  /// **This should only be done by the library or if you're testing.**
  ///
  /// To get an instance use [FlutterWebBluetooth.requestDevice].
  ///
  BluetoothDevice(super.bluetoothDevice);

  WebBehaviorSubject<bool>? _connectionSubject;

  WebBehaviorSubject<AdvertisementReceivedEvent<BluetoothDevice>>?
      _advertisementSubject;
  AbortController? _advertisementAbortController;

  bool _forgotten = false;

  ///
  /// A stream which will emit all the advertisements received.
  ///
  /// Start watching for advertisements using [watchAdvertisements]. If the
  /// browser doesn't support watching advertisements then this stream will
  /// throw an error.
  ///
  /// Also take a look at [advertisementsUseMemory] because this field changes
  /// the behavior of the emitted events.
  ///
  Stream<AdvertisementReceivedEvent<BluetoothDevice>> get advertisements {
    _startAdvertisementStream();
    return _advertisementSubject!.stream;
  }

  ///
  /// This is a setting for this device if it should use memory for advertisements
  ///
  /// Not every device sends a completely filled out advertisement packet for
  /// each advertisements. For example every other packet might have the name
  /// field missing. If this setting is set to `true` it will use the last received
  /// event to fill in the missing data on the current new event.
  ///
  /// You may want to disable this for certain projects in that case set this
  /// option to `false`.
  ///
  /// It can also be set globally (for new devices) here
  /// [FlutterWebBluetoothInterface.defaultAdvertisementsMemory].
  ///
  bool advertisementsUseMemory =
      FlutterWebBluetooth.instance.defaultAdvertisementsMemory;

  ///
  /// A stream that gives the current connection state.
  ///
  /// This will be `true` if the device is currently connected, it will also
  /// update if for whatever reason the connection is broken.
  ///
  Stream<bool> get connected {
    _startConnectedStream();
    return _connectionSubject!.stream;
  }

  void _startConnectedStream() {
    if (_connectionSubject != null) {
      return;
    }

    _connectionSubject = WebBehaviorSubject.seeded(gatt?.connected ?? false);

    _bluetoothDevice.addEventListener("gattserverdisconnected",
        (final dynamic event) {
      _connectionSubject?.add(false);
      if (_servicesSubject.hasValue) {
        _servicesSubject.add([]);
      }
    });
  }

  void _startAdvertisementStream() {
    if (_advertisementSubject != null) {
      return;
    }

    _advertisementSubject = WebBehaviorSubject();

    WebAdvertisementReceivedEvent? memory;
    _bluetoothDevice.addEventListener("advertisementreceived",
        (final dynamic event) {
      try {
        final convertedEvent =
            WebAdvertisementReceivedEvent.fromJSObject(event, _bluetoothDevice);

        var combined = convertedEvent;
        final storedMemory = memory;
        if (storedMemory != null && advertisementsUseMemory) {
          combined = WebAdvertisementReceivedEvent.withMemory(
              storedMemory, convertedEvent);
        }
        memory = combined;

        _advertisementSubject?.add(
            AdvertisementReceivedEvent<BluetoothDevice>._(combined, this));
      } catch (e, s) {
        if (e is Error) {
          _advertisementSubject?.controller.addError(e, s);
        } else {
          _advertisementSubject?.controller
              .addError(BrowserError(e.toString()), StackTrace.current);
        }
      }
    });
  }

  ///
  /// Check to see if the device currently has a GATT connection.
  ///
  /// Some devices may allow you to find them, but they are on a blocklist
  /// restricting the ability to communicate with its GATT service.
  ///
  bool get hasGATT => gatt != null;

  ///
  /// Disconnect from the device.
  ///
  /// See [hasGATT].
  ///
  void disconnect() {
    gatt?.disconnect();
  }

  ///
  /// Connect to the device's GATT server.
  ///
  /// The [connect] call may timeout after [timeout] if set to `null` then it
  /// will never timeout. Call [disconnect] if you want to cancel it in that
  /// case.
  ///
  /// - May throw [TypeError] if there is no gatt. Always check [hasGATT] before
  /// calling this method.
  ///
  /// - May throw [NetworkError] if no connection could be established.
  ///
  /// - May throw [StateError] if the connection was aborted. TODO: use a better error.
  ///
  Future<void> connect(
      {final Duration? timeout = const Duration(seconds: 5)}) async {
    final gatt = this.gatt!;
    _startConnectedStream();
    // No timeout.
    try {
      if (timeout == null) {
        await gatt.connect();
      } else {
        await gatt.connect().timeout(timeout);
      }
    } catch (e) {
      if (e is TimeoutException) {
        disconnect();
        rethrow;
      }
      final error = e.toString().trim();
      if (error.startsWith("NetworkError")) {
        throw NetworkError.withDeviceId(id);
      } else if (error.startsWith("AbortError")) {
        throw StateError("Connection attempt was aborted!");
      }
      rethrow;
    }

    _connectionSubject?.add(true);
  }

  ///
  /// Forget the device. This means that the device will no longer show up
  /// in [FlutterWebBluetooth.devices] stream.
  ///
  /// You can no longer communicate with the device after calling [forget].
  /// It basically reverts into a [AdvertisementBluetoothDevice].
  ///
  /// Will throw [NativeAPINotImplementedError] if the browser/ user agent
  /// doesn't have the method implemented.
  ///
  /// Will throw [StateError] if the device has already been forgotten.
  ///
  Future<void> forget() async {
    if (_forgotten) {
      // Stops you from crashing the browser by forgetting a device twice.
      throw StateError("The device has already been forgotten");
    }
    await _bluetoothDevice.forget();
    _forgotten = true;
    // Remove the device from the list of devices.
    await FlutterWebBluetooth.instance._forgetDevice(this);
  }

  ///
  /// A bool representing if the device has already been forgotten.
  ///
  /// Will be `true` after calling [forget]. Otherwise it will be `false`.
  ///
  bool get isForgotten => _forgotten;

  ///
  /// Check to see if the browser/ user agent has [forget].
  ///
  bool get hasForget => _bluetoothDevice.hasForget;

  ///
  /// Check to see if the current browser supports the [watchAdvertisements]
  /// call.
  /// This can be used to avoid the [NativeAPINotImplementedError].
  ///
  bool hasWatchAdvertisements() => _bluetoothDevice.hasWatchAdvertisements();

  ///
  /// Watch for advertisements from this device. The advertisements will
  /// be received using the [advertisements] [Stream].
  /// You can choose to only watch advertisements for a specific amount of times
  /// in that case use the [timeout] variable. If this is `null` then it will
  /// watch advertisements for as long as the device is in range. Do note that
  /// not every device will keep sending out advertisements.
  ///
  /// Not every browser supports this API yet. Chrome for Windows, Linux, and
  /// probably also mac os have this hidden behind the
  /// chrome://flags/#enable-experimental-web-platform-features flag.
  /// If the API is not supported then this method will throw a
  /// [NativeAPINotImplementedError] use [hasWatchAdvertisements] to make sure
  /// that the browser supports the method.
  /// Even if the device technically has the method sometimes it won't fire any
  /// advertisement events even though the device may be sending them. This is
  /// the case with chrome for linux.
  ///
  /// If the browser is already watching for advertisements and this is called
  /// again then nothing special will happen and it will request the device
  /// again to send advertisements.
  ///
  Future<void> watchAdvertisements([final Duration? timeout]) async {
    if (!_bluetoothDevice.hasWatchAdvertisements()) {
      // Throw the error
      return await _bluetoothDevice.watchAdvertisements();
    }
    _advertisementAbortController
        ?.abort(StateError("Can only watch the advertisements once"));

    _startAdvertisementStream();
    final controller = timeout != null ? null : AbortController();
    if (timeout != null) {
      _advertisementAbortController = controller;
    }
    final signal = timeout != null
        ? AbortSignal.timeout(timeout.inMilliseconds)
        : controller!.signal;
    try {
      final options = WatchAdvertisementsOptions(signal: signal);
      await _bluetoothDevice.watchAdvertisements(options);
    } catch (e) {
      if (e is Error) {
        rethrow;
      }
      final asString = e.toString();
      throw BrowserError(asString);
    }
  }

  ///
  /// Stop watching for advertisements.
  ///
  /// If the device was not watching advertisements then this method will
  /// just silently do nothing. You can check if the device was watching
  /// advertisements by using [watchingAdvertisements].
  ///
  /// Unlike [watchAdvertisements] this will never throw a [NativeAPINotImplementedError]
  /// even if the api is not supported. It will just silently do nothing.
  ///
  Future<void> unwatchAdvertisements() async {
    _advertisementAbortController
        ?.abort(StateError("Watching advertisements has been aborted"));
    _advertisementAbortController = null;
    if (_bluetoothDevice.watchingAdvertisements &&
        _bluetoothDevice.hasWatchAdvertisements()) {
      try {
        // It seems that the device is still watching for advertisements even
        // though it should have already stopped. Stop it anyways.
        final signal =
            AbortSignal.abort(StateError("Stop the advertisements!"));
        final options = WatchAdvertisementsOptions(signal: signal);
        await _bluetoothDevice.watchAdvertisements(options);
      } catch (e) {
        // expect an error because of the aborted signal.
        final asString = e.toString();
        if (!asString.toLowerCase().startsWith("aborterror")) {
          // Expect the abort error, rethrow for everything else.
          throw BrowserError(asString);
        }
      }
    }
  }

  ///
  /// If the device is watching for advertisements.
  /// If advertisements are not unsupported then it will always return `false`.
  ///
  bool get watchingAdvertisements => _bluetoothDevice.watchingAdvertisements;

  final WebBehaviorSubject<List<BluetoothService>> _servicesSubject =
      WebBehaviorSubject.seeded([]);

  ///
  /// A [Stream] with a list of all the [BluetoothService] that have been discovered on
  /// this device.
  ///
  /// Getting this [Stream] while [connected] is `true` will also result in a
  /// call to [discoverServices]. If this hasn't happened yet.
  Stream<List<BluetoothService>> get services async* {
    while (_connectionSubject == null ||
        _connectionSubject?.value == false ||
        _connectionSubject?.hasValue == false) {
      yield [];
    }
    if (_servicesSubject.value?.isEmpty ?? false) {
      yield await discoverServices();
    }
    yield* _servicesSubject.stream;
  }

  ///
  /// Discover the primary services on this device.
  ///
  /// Will return a list of [BluetoothService].
  ///
  /// Only services defined in the [RequestOptionsBuilder] from when
  /// [FlutterWebBluetooth.requestDevice] was called are available.
  ///
  /// Will also update the [services] stream with the data returned form this
  /// method.
  ///
  /// - May throw [StateError] if the device is not connected.
  ///
  Future<List<BluetoothService>> discoverServices() async {
    final gatt = this.gatt;
    if (gatt == null || !gatt.connected) {
      throw StateError(
          "Cannot discover services if the device is not connected.");
    }

    try {
      final services = await gatt.getPrimaryServices();
      final convertedServices = services.map(BluetoothService.new).toList();
      _servicesSubject.add(convertedServices);
      return convertedServices;
    } catch (e) {
      final error = e.toString().trim();
      if (error.startsWith("SecurityError")) {
        throw SecurityError("getPrimaryServices", error);
      } else if (error.startsWith("NetworkError")) {
        throw StateError(
            "Cannot discover services if the device is not connected.");
      } else if (error.startsWith("InvalidStateError")) {
        throw StateError("GATT is null");
      } else if (error.startsWith("NotFoundError")) {
        _servicesSubject.add([]);
        return [];
      }
      rethrow;
    }
  }

  /// Get the underlying native (web) gatt service.
  @visibleForTesting
  NativeBluetoothRemoteGATTServer? get gatt => _bluetoothDevice.gatt;

  ///
  /// Get the underlying native (web) bluetooth device.
  ///
  @Deprecated("This is here for debugging and will be removed once web "
      "bluetooth is actually released.")
  WebBluetoothDevice get nativeDevice => _bluetoothDevice;
}
