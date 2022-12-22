part of js_web_bluetooth;

///
/// A class for calling methods and values for a [NativeBluetoothRemoteGATTServer].
/// This is where most of the interesting stuff happens.
///
/// You can get a [NativeBluetoothRemoteGATTServer] from
/// [WebBluetoothDevice.gatt].
///
/// See:
///
/// - https://developer.mozilla.org/en-US/docs/Web/API/BluetoothRemoteGATTServer
///
/// - https://webbluetoothcg.github.io/web-bluetooth/#bluetoothgattremoteserver-interface
///
class NativeBluetoothRemoteGATTServer {
  final Object _jsObject;

  ///
  /// The device that this gatt server belongs too.
  ///
  /// See:
  ///
  /// - https://developer.mozilla.org/en-US/docs/Web/API/BluetoothRemoteGATTServer/device
  ///
  /// - https://webbluetoothcg.github.io/web-bluetooth/#dom-bluetoothremotegattserver-device
  ///
  final WebBluetoothDevice device;

  ///
  /// Check to see if the gatt server is connected to the device.
  ///
  /// See:
  ///
  /// - https://developer.mozilla.org/en-US/docs/Web/API/BluetoothRemoteGATTServer/connected
  ///
  /// - https://webbluetoothcg.github.io/web-bluetooth/#dom-bluetoothremotegattserver-connected
  ///
  bool get connected {
    final value = _JSUtil.getProperty(_jsObject, "connected");
    if (value is bool) {
      return value;
    }
    return false;
  }

  ///
  /// Connect the GATT server to the device.
  ///
  /// This [Future] will only complete once an error happens or the connection
  /// is made.
  ///
  /// To cancel connecting call [disconnect].
  ///
  /// - May throw NetworkError if no connection could be established.
  ///
  /// - May throw AbortError if the attempt was aborted.
  ///
  /// See:
  ///
  /// - [disconnect]
  ///
  /// - https://developer.mozilla.org/en-US/docs/Web/API/BluetoothRemoteGATTServer/connect
  ///
  /// - https://webbluetoothcg.github.io/web-bluetooth/#dom-bluetoothremotegattserver-connect
  ///
  Future<NativeBluetoothRemoteGATTServer> connect() async {
    final promise = _JSUtil.callMethod(_jsObject, "connect", []);
    await _JSUtil.promiseToFuture(promise);
    return this;
  }

  ///
  /// Disconnect the GATT server from the device.
  ///
  /// See:
  ///
  /// - [connect]
  ///
  /// - https://developer.mozilla.org/en-US/docs/Web/API/BluetoothRemoteGATTServer/disconnect
  ///
  /// - https://webbluetoothcg.github.io/web-bluetooth/#dom-bluetoothremotegattserver-disconnect
  ///
  void disconnect() {
    _JSUtil.callMethod(_jsObject, "disconnect", []);
  }

  ///
  /// Get a the primary services on the current device.
  ///
  /// Only services defined in [RequestOptions] and [BluetoothScanFilter] from
  /// when [Bluetooth.requestDevice] was called are available.
  ///
  /// [serviceUUID] is the UUID (lower case) of the service to get.
  ///
  /// - May throw SecurityError if a service's UUID is on a blocklist.
  ///
  /// - May throw NetworkError if the GATT server is not connected.
  ///
  /// - May throw InvalidStateError if GATT is `null`.
  ///
  /// - May throw NotFoundError if the services was found.
  ///
  /// See:
  ///
  /// - [getPrimaryServices]
  ///
  /// - https://developer.mozilla.org/en-US/docs/Web/API/BluetoothRemoteGATTServer/getPrimaryService
  ///
  /// - https://webbluetoothcg.github.io/web-bluetooth/#dom-bluetoothremotegattserver-getprimaryservice
  ///
  Future<WebBluetoothRemoteGATTService> getPrimaryService(
      final String serviceUUID) async {
    final promise = _JSUtil.callMethod(
        _jsObject, "getPrimaryService", [serviceUUID.toLowerCase()]);
    final result = await _JSUtil.promiseToFuture(promise);
    return WebBluetoothRemoteGATTService.fromJSObject(result, device);
  }

  ///
  /// Get all the primary services on the current device.
  ///
  /// Only services defined in [RequestOptions] and [BluetoothScanFilter] from
  /// when [Bluetooth.requestDevice] was called are available.
  ///
  /// [serviceUUID] according to the docs this value is optional, but I can't
  /// find what would it would do if you set it anyways.
  ///
  /// - May throw SecurityError if a service's UUID is on a blocklist.
  ///
  /// - May throw NetworkError if the GATT server is not connected.
  ///
  /// - May throw InvalidStateError if GATT is `null`.
  ///
  /// - May throw NotFoundError if no services were found.
  ///
  /// See:
  ///
  /// - [getPrimaryService]
  ///
  /// - https://developer.mozilla.org/en-US/docs/Web/API/BluetoothRemoteGATTServer/getPrimaryServices
  ///
  /// - https://webbluetoothcg.github.io/web-bluetooth/#dom-bluetoothremotegattserver-getprimaryservices
  ///
  Future<List<WebBluetoothRemoteGATTService>> getPrimaryServices(
      [final String? serviceUUID]) async {
    final arguments = serviceUUID == null ? [] : [serviceUUID.toLowerCase()];
    final promise =
        _JSUtil.callMethod(_jsObject, "getPrimaryServices", arguments);
    final result = await _JSUtil.promiseToFuture(promise);
    if (result is List) {
      final items = <WebBluetoothRemoteGATTService>[];
      for (final item in result) {
        try {
          items.add(WebBluetoothRemoteGATTService.fromJSObject(item, device));
        } catch (e, stack) {
          if (e is UnsupportedError) {
            webBluetoothLogger.severe(
                "Could not convert primary service to BluetoothRemoteGATTService",
                e,
                stack);
          } else {
            rethrow;
          }
        }
      }
      return items;
    }
    return [];
  }

  ///
  /// Create a new instance from a js object.
  ///
  /// **This should only be done by the library or if you're testing.**
  ///
  /// To get an instance use [WebBluetoothDevice.gatt].
  ///
  NativeBluetoothRemoteGATTServer.fromJSObject(this._jsObject, this.device) {
    if (!_JSUtil.hasProperty(_jsObject, "connected")) {
      throw UnsupportedError("JSObject does not have connected");
    }
    if (!_JSUtil.hasProperty(_jsObject, "device")) {
      throw UnsupportedError("JSObject does not have device");
    }
    if (!_JSUtil.hasProperty(_jsObject, "connect")) {
      throw UnsupportedError("JSObject does not have connect");
    }
    if (!_JSUtil.hasProperty(_jsObject, "disconnect")) {
      throw UnsupportedError("JSObject does not have disconnect");
    }
    if (!_JSUtil.hasProperty(_jsObject, "getPrimaryService")) {
      throw UnsupportedError("JSObject does not have getPrimaryService");
    }
    if (!_JSUtil.hasProperty(_jsObject, "getPrimaryServices")) {
      throw UnsupportedError("JSObject does not have getPrimaryServices");
    }
  }
}
