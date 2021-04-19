import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_web_bluetooth/native/js/JSUtils.dart';
import 'package:flutter_web_bluetooth/native_web_bluetooth.dart';
import 'package:test/test.dart' as dartTest;

import '../helper/JSUtilsTesting.dart';
import '../helper/NativeBluetoothDeviceTesting.dart';
import '../helper/NativeBluetoothRemoteGATTServerTesting.dart';

void main() {
  JSUtilsInterface utils = JSUtilsTesting();
  setJSUtils(utils);

  test('Should parse basic jsObject', () {
    Map<String, dynamic> jsObject = {'id': 'SOME-ID'};

    expect(() {
      return NativeBluetoothDevice.fromJSObject(jsObject);
    }, returnsNormally);
  });

  test('Should throw error missing id', () {
    Map<String, dynamic> jsObject = {};

    expect(() {
      return NativeBluetoothDevice.fromJSObject(jsObject);
    }, throwsA(const dartTest.TypeMatcher<UnsupportedError>()));
  });

  final deviceJSObject = NativeBluetoothDeviceTesting.createJSObject(
      id: 'TEST-ID', uuid: [], name: 'SOME-NAME');

  test('Should get id', () {
    final device = NativeBluetoothDevice.fromJSObject(deviceJSObject);

    expect(device.id, deviceJSObject['id'], reason: 'Id should match');
  });

  test('Should get name', () {
    final device = NativeBluetoothDevice.fromJSObject(deviceJSObject);

    expect(device.name, deviceJSObject['name'], reason: 'Name should match');
  });

  test('Should not get name', () {
    final jsObject = Map.fromEntries(deviceJSObject.entries);
    jsObject.remove('name');
    final device = NativeBluetoothDevice.fromJSObject(jsObject);

    expect(device.name, null, reason: 'Should not get name');
  });

  test('Should get gatt', () {
    final jsObject = Map.fromEntries(deviceJSObject.entries);
    final device = NativeBluetoothDevice.fromJSObject(jsObject);

    jsObject['gatt'] =
        NativeBluetoothRemoteGATTServerTesting.createStubJSOBject();

    final gatt = device.gatt;
    expect(gatt, const dartTest.TypeMatcher<NativeBluetoothRemoteGATTServer>());
  });

  test('Should not get gatt', () {
    final device = NativeBluetoothDevice.fromJSObject(deviceJSObject);

    expect(device.gatt, null, reason: 'Should not get gatt');
  });
}
