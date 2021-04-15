abstract class NativeBluetoothDeviceTesting {
  NativeBluetoothDeviceTesting._();

  static Map<String, dynamic> createJSObject(
      {required String id,
      String? name,
      Map<String, dynamic>? gatt,
      required List<dynamic> uuid}) {
    return {
      'id': id,
      'name': name,
      'gatt': gatt,
      'uuid': uuid,
    };
  }
}
