@TestOn("browser")
library;

import "package:flutter_web_bluetooth/js_web_bluetooth.dart";
import "package:test/test.dart";

import "../helper/native_bluetooth_testing.dart";
import "../helper/web_fake.dart";

void main() {
  test("Available should be true", () async {
    final NativeBluetooth nativeBluetooth =
        NativeBluetoothTesting(available: true);
    setNativeBluetooth(nativeBluetooth);

    testingSetNavigator(NavigatorFakes.getValidNavigator());
    final available = await Bluetooth.getAvailability();
    expect(available, true, reason: "Available should return true");
  });

  test("Available should be false", () async {
    final NativeBluetooth nativeBluetooth =
        NativeBluetoothTesting(available: false);
    setNativeBluetooth(nativeBluetooth);

    testingSetNavigator(NavigatorFakes.getValidNavigator());
    final available = await Bluetooth.getAvailability();
    expect(available, false, reason: "Available should return false");
  });

  test("Available should be false, no bluetooth object", () async {
    final NativeBluetooth nativeBluetooth =
        NativeBluetoothTesting(available: true);
    setNativeBluetooth(nativeBluetooth);

    testingSetNavigator(NavigatorFakes.getNavigatorNoBluetooth());
    final available = await Bluetooth.getAvailability();
    expect(available, false, reason: "Available should return false");
  });
}
