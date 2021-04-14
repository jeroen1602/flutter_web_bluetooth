import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_web_bluetooth/native/JSUtilsInterface.dart';
import 'package:flutter_web_bluetooth/native_web_bluetooth.dart';

import '../helper/JSUtilsTesting.dart';
import '../helper/NativeBluetoothTesting.dart';

void main() {
//  Setup the env.

  test('Available should be true', () async {
    JSUtilsInterface utils = JSUtilsTesting();

    setJSUtils(utils);

    NativeBluetooth nativeBluetooth = NativeBluetoothTesting(available: true);
    setNativeBluetooth(nativeBluetooth);

    Object object = {
      'bluetooth': Object(),
    };
    setNavigator(object);
    final available = await Bluetooth.getAvailability();
    expect(available, true, reason: 'Available should return true');
  });

  test ('Available should be false', () async {
    JSUtilsInterface utils = JSUtilsTesting();

    setJSUtils(utils);

    NativeBluetooth nativeBluetooth = NativeBluetoothTesting(available: false);
    setNativeBluetooth(nativeBluetooth);

    Object object = {
      'bluetooth': Object(),
    };
    setNavigator(object);
    final available = await Bluetooth.getAvailability();
    expect(available, false, reason: 'Available should return false');
  });

  test ('Available should be false, no bluetooth object', () async {
    JSUtilsInterface utils = JSUtilsTesting();

    setJSUtils(utils);

    NativeBluetooth nativeBluetooth = NativeBluetoothTesting(available: false);
    setNativeBluetooth(nativeBluetooth);

    Object object = {
      'no-bluetooth': Object(),
    };
    setNavigator(object);
    final available = await Bluetooth.getAvailability();
    expect(available, false, reason: 'Available should return false');
  });

}
