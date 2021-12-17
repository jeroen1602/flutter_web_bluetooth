import 'package:flutter_web_bluetooth/js_web_bluetooth.dart';
import 'package:flutter_web_bluetooth/web/js/js_utils.dart';
import 'package:test/test.dart';

import '../helper/js_utils_testing.dart';
import '../helper/native_bluetooth_device_testing.dart';
import '../helper/native_bluetooth_remote_gatt_server_testing.dart';

void main() {
  JSUtilsInterface utils = JSUtilsTesting();
  testingSetJSUtils(utils);

  test('Should parse basic jsObject', () {
    Map<String, dynamic> jsObject = {'id': 'SOME-ID'};

    expect(() {
      return WebBluetoothDevice.fromJSObject(jsObject);
    }, returnsNormally);
  });

  test('Should throw error missing id', () {
    Map<String, dynamic> jsObject = {};

    expect(() {
      return WebBluetoothDevice.fromJSObject(jsObject);
    }, throwsA(const TypeMatcher<UnsupportedError>()));
  });

  final deviceJSObject = NativeBluetoothDeviceTesting.createJSObject(
      id: 'TEST-ID', uuid: [], name: 'SOME-NAME');

  test('Should get id', () {
    final device = WebBluetoothDevice.fromJSObject(deviceJSObject);

    expect(device.id, deviceJSObject['id'], reason: 'Id should match');
  });

  test('Should get name', () {
    final device = WebBluetoothDevice.fromJSObject(deviceJSObject);

    expect(device.name, deviceJSObject['name'], reason: 'Name should match');
  });

  test('Should not get name', () {
    final jsObject = Map.fromEntries(deviceJSObject.entries);
    jsObject.remove('name');
    final device = WebBluetoothDevice.fromJSObject(jsObject);

    expect(device.name, null, reason: 'Should not get name');
  });

  test('Should get gatt', () {
    final jsObject = Map.fromEntries(deviceJSObject.entries);
    final device = WebBluetoothDevice.fromJSObject(jsObject);

    jsObject['gatt'] =
        NativeBluetoothRemoteGATTServerTesting.createStubJSOBject();

    final gatt = device.gatt;
    expect(gatt, const TypeMatcher<NativeBluetoothRemoteGATTServer>());
  });

  test('Should not get gatt', () {
    final device = WebBluetoothDevice.fromJSObject(deviceJSObject);

    expect(device.gatt, null, reason: 'Should not get gatt');
  });
}
