@TestOn("browser")
library;

import "package:flutter_web_bluetooth/js_web_bluetooth.dart";
import "package:test/test.dart";

import "../helper/native_bluetooth_testing.dart";
import "../helper/web_fake.dart";

void main() {
  final NativeBluetoothTesting nativeBluetooth =
      NativeBluetoothTesting(available: true);
  setNativeBluetooth(nativeBluetooth);

  testingSetNavigator(NavigatorFakes.getValidNavigator());

  test("Should get device", () async {
    final available = await Bluetooth.getAvailability();
    expect(available, true, reason: "Bluetooth should be available");

    nativeBluetooth.bluetoothDevice =
        WebBluetoothDeviceFakes.getValidWebBluetoothDevice(
            id: "TEST-ID", uuids: [0x00000, 0xbbbbb, 0xaaaaa]);

    final requestOptions = RequestOptions();

    final device = await Bluetooth.requestDevice(requestOptions);
    expect(device.id, "TEST-ID", reason: "Should return the correct device");
  });
}
