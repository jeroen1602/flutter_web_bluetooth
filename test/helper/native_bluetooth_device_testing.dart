abstract class NativeBluetoothDeviceTesting {
  NativeBluetoothDeviceTesting._();

  static Map<String, dynamic> createJSObject({
    required final String id,
    required final List<dynamic> uuid,
    final String? name,
    final Map<String, dynamic>? gatt,
  }) =>
      {
        "id": id,
        "name": name,
        "gatt": gatt,
        "uuid": uuid,
      };
}
