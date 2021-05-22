part of flutter_web_bluetooth;

class BluetoothDevice {
  @visibleForTesting
  BluetoothDevice(this._bluetoothDevice);

  final WebBluetoothDevice _bluetoothDevice;

  String get id => _bluetoothDevice.id;

  String? get name => _bluetoothDevice.name;

  BehaviorSubject<bool>? _connectionSubject;

  Stream<bool> get connected {
    _startConnectedStream();
    return _connectionSubject!.stream;
  }

  void _startConnectedStream() {
    if (_connectionSubject != null) {
      return;
    }

    _connectionSubject = BehaviorSubject.seeded(gatt?.connected == true);

    this._bluetoothDevice.addEventListener('gattserverdisconnected',
        (dynamic event) {
      _connectionSubject?.add(false);
      if (_servicesSubject.hasValue) {
        _servicesSubject.add([]);
      }
    });
  }

  bool get hasGATT => this.gatt != null;

  void disconnect() {
    gatt?.disconnect();
  }

  ///
  /// Connect to the device's GATT server. The connect call may timeout after
  /// [timeout] if set to `null` then it will never timeout. Call [disconnect]
  /// if you want to cancel it in that case.
  /// May throw [TypeError] if there is no gatt. Always check [hasGATT] before
  /// calling this method.
  /// May throw [NetworkError] if no connection could be established.
  ///
  Future<void> connect({Duration? timeout = const Duration(seconds: 5)}) async {
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
        this.disconnect();
        throw e;
      }
      final error = e.toString().trim();
      if (error.startsWith('NetworkError')) {
        throw NetworkError(this.id);
      }
    }

    this._connectionSubject?.add(true);
  }

  BehaviorSubject<List<BluetoothService>> _servicesSubject =
      BehaviorSubject.seeded([]);

  Stream<List<BluetoothService>> get services async* {
    while (_connectionSubject == null ||
        !_connectionSubject!.hasValue ||
        _connectionSubject!.value == false) {
      yield [];
    }
    if (!_servicesSubject.hasValue || _servicesSubject.value!.isEmpty) {
      yield await discoverServices();
    }
    yield* _servicesSubject.stream;
  }

  ///
  /// May throw [StateError] if the device is not connected.
  ///
  Future<List<BluetoothService>> discoverServices() async {
    final gatt = this.gatt;
    if (gatt == null || !gatt.connected) {
      throw StateError(
          'Cannot discover services if the device is not connected.');
    }

    final services = await gatt.getPrimaryServices(null);
    final convertedServices = services.map((e) => BluetoothService(e)).toList();
    _servicesSubject.add(convertedServices);
    return convertedServices;
  }

  /// Get the underlying native (web) gatt service.
  ///@visibleForTesting
  @Deprecated('This is here for debugging and will be removed once web '
      'bluetooth is actually released. '
      '(It will still exist as visible for testing)')
  NativeBluetoothRemoteGATTServer? get gatt => _bluetoothDevice.gatt;

  ///
  /// Get the underlying native (web) bluetooth device.
  ///
  @Deprecated('This is here for debugging and will be removed once web '
      'bluetooth is actually released.')
  WebBluetoothDevice get nativeDevice => _bluetoothDevice;

  @override
  bool operator ==(Object other) {
    if (!(other is BluetoothDevice)) {
      return false;
    }
    return this.id == other.id;
  }

  @override
  int get hashCode => this.id.hashCode;
}
