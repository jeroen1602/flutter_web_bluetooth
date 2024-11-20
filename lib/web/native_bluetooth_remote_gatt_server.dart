part of "../js_web_bluetooth.dart";

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
@JS()
extension type NativeBluetoothRemoteGATTServer._(JSObject _)
    implements JSObject {
  ///
  /// The device that this gatt server belongs too.
  ///
  /// See:
  ///
  /// - https://developer.mozilla.org/en-US/docs/Web/API/BluetoothRemoteGATTServer/device
  ///
  /// - https://webbluetoothcg.github.io/web-bluetooth/#dom-bluetoothremotegattserver-device
  ///
  external WebBluetoothDevice get device;

  @JS("connected")
  external JSBoolean get _connected;

  ///
  /// Check to see if the gatt server is connected to the device.
  ///
  /// See:
  ///
  /// - https://developer.mozilla.org/en-US/docs/Web/API/BluetoothRemoteGATTServer/connected
  ///
  /// - https://webbluetoothcg.github.io/web-bluetooth/#dom-bluetoothremotegattserver-connected
  ///
  bool get connected => _connected.isDefinedAndNotNull && _connected.toDart;

  @JS("connect")
  external JSPromise<NativeBluetoothRemoteGATTServer> _connect();

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
    await _connect().toDart;
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
  external void disconnect();

  @JS("getPrimaryService")
  external JSPromise<WebBluetoothRemoteGATTService> _getPrimaryService(
      final JSString serviceUUID);

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
  /// **NOTE:** Some services are on a block list, and are thus not available.
  /// The complete blocklist can be found here:
  /// https://github.com/WebBluetoothCG/registries/blob/master/gatt_blocklist.txt
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
          final String serviceUUID) async =>
      await _getPrimaryService(serviceUUID.toLowerCase().toJS).toDart;

  @JS("getPrimaryServices")
  external JSPromise<JSArray<WebBluetoothRemoteGATTService>>
      _getPrimaryServices([final JSString? serviceUUID]);

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
  /// **NOTE:** Some services are on a block list, and are thus not available.
  /// The complete blocklist can be found here:
  /// https://github.com/WebBluetoothCG/registries/blob/master/gatt_blocklist.txt
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
    final argument = serviceUUID?.toLowerCase().toJS;
    if (argument == null) {
      return (await _getPrimaryServices().toDart).toDart;
    } else {
      return (await _getPrimaryServices(argument).toDart).toDart;
    }
  }
}
