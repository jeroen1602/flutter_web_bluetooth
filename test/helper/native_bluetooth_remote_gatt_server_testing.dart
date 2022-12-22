typedef ConnectFunction = Future<Map<String, dynamic>> Function();
typedef DisconnectFunction = void Function();
typedef GetPrimaryService = Future<Map<String, dynamic>> Function();
typedef GetPrimaryServices = Future<List<Map<String, dynamic>>> Function();

abstract class NativeBluetoothRemoteGATTServerTesting {
  NativeBluetoothRemoteGATTServerTesting._();

  static Map<String, dynamic> createJSObject({
    required final ConnectFunction connectFunction,
    required final DisconnectFunction disconnectFunction,
    required final GetPrimaryService getPrimaryService,
    required final GetPrimaryServices getPrimaryServices,
    final bool connected = true,
    final Map<String, dynamic>? device,
  }) =>
      {
        "connected": connected,
        "device": device ?? Object(),
        "connect": connectFunction,
        "disconnect": disconnectFunction,
        "getPrimaryService": getPrimaryService,
        "getPrimaryServices": getPrimaryServices,
      };

  static Map<String, dynamic> createStubJSObject() =>
      createJSObject(connectFunction: () async {
        throw UnsupportedError("connect STUB");
      }, disconnectFunction: () {
        throw UnsupportedError("disconnect STUB");
      }, getPrimaryService: () {
        throw UnsupportedError("primary service STUB");
      }, getPrimaryServices: () {
        throw UnsupportedError("primary services STUB");
      });
}
