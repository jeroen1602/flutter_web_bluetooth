import 'package:flutter_web_bluetooth/js_web_bluetooth.dart';
import 'package:flutter_web_bluetooth/web/js/js_utils.dart';
import 'package:test/test.dart';

import '../helper/js_utils_testing.dart';
import '../helper/native_bluetooth_testing.dart';

void main() {
  JSUtilsInterface utils = JSUtilsTesting();
  testingSetJSUtils(utils);

  test('Available should be true', () async {
    NativeBluetooth nativeBluetooth = NativeBluetoothTesting(available: true);
    setNativeBluetooth(nativeBluetooth);

    Object object = {
      'bluetooth': Object(),
    };
    testingSetNavigator(object);
    final available = await Bluetooth.getAvailability();
    expect(available, true, reason: 'Available should return true');
  });

  test('Available should be false', () async {
    NativeBluetooth nativeBluetooth = NativeBluetoothTesting(available: false);
    setNativeBluetooth(nativeBluetooth);

    Object object = {
      'bluetooth': Object(),
    };
    testingSetNavigator(object);
    final available = await Bluetooth.getAvailability();
    expect(available, false, reason: 'Available should return false');
  });

  test('Available should be false, no bluetooth object', () async {
    NativeBluetooth nativeBluetooth = NativeBluetoothTesting(available: true);
    setNativeBluetooth(nativeBluetooth);

    Object object = {
      'no-bluetooth': Object(),
    };
    testingSetNavigator(object);
    final available = await Bluetooth.getAvailability();
    expect(available, false, reason: 'Available should return false');
  });
}
