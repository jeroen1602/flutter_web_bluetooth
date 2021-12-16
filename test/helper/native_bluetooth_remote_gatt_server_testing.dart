typedef ConnectFunction = Future<Map<String, dynamic>> Function();
typedef DisconnectFunction = void Function();
typedef GetPrimaryService = Future<Map<String, dynamic>> Function();
typedef GetPrimaryServices = Future<List<Map<String, dynamic>>> Function();

abstract class NativeBluetoothRemoteGATTServerTesting {
  NativeBluetoothRemoteGATTServerTesting._();

  static Map<String, dynamic> createJSObject({
    bool connected = true,
    Map<String, dynamic>? device,
    required ConnectFunction connectFunction,
    required DisconnectFunction disconnectFunction,
    required GetPrimaryService getPrimaryService,
    required GetPrimaryServices getPrimaryServices,
  }) {
    return {
      'connected': connected,
      'device': device ?? Object(),
      'connect': connectFunction,
      'disconnect': disconnectFunction,
      'getPrimaryService': getPrimaryService,
      'getPrimaryServices': getPrimaryServices,
    };
  }

  static Map<String, dynamic> createStubJSOBject() {
    return createJSObject(connectFunction: () async {
      throw UnsupportedError('connect STUB');
    }, disconnectFunction: () {
      throw UnsupportedError('disconnect STUB');
    }, getPrimaryService: () {
      throw UnsupportedError('primary service STUB');
    }, getPrimaryServices: () {
      throw UnsupportedError('primary services STUB');
    });
  }
}
