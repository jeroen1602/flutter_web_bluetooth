## 0.1.0

* Added bluetooth advertisements event to a bluetooth device. (Note this is still behind a flag in most browsers.)
* Support the newest version of logging.
* **Breaking** in `Bluetooth.requestDevice()` the `RequestOptions` are no longer nullable.
* Added `requestLEScan` to `Bluetooth` and `FlutterWebBluetooth`. You can now scan for devices advertisements without
  needing to pair with each device. However, a normal pair does need to happen before characteristics can be used.
* **Breaking** `BluetoothDevice.gatt` is no longer marked as deprecated, it is still marked as `visibleForTesting`.
* Continuing with the IOS Bluefy browser fix for characteristic properties.
    * Added `has` methods for all the fields in characteristic properties.
    * Return `false` as default value when a property doesn't exist.
    * Added `hasProperties` method to check if there are any properties at all. Use this to test if the properties are
      even reliable.
    * You can remove any try-catch logic around reading properties if you added those for the mitigation.

## 0.0.9

* Added a hotfix for the IOS Bluefy browser. As a side effect none of the characteristic properties are required
  anymore, but there are no methods yet to check if the properties exist. So add a try-catch around these methods for
  now!
* Updated dependencies to work with Flutter 3.3.0

## 0.0.8

* Added manufacturer scan filters and service scan filters

## 0.0.7

* Added `getCharacteristics` to the bluetooth service to get all the characteristics.
* Set target platform to web for [pub.dev](https://pub.dev/packages/flutter_web_bluetooth/) target platform list (it
  will still compile when used in non-native programs.)
* Added documentation to the last few public interfaces

## 0.0.6+2

* Fixed the behavior subject stream not returning the stored value causing some implementations to wait forever.

## 0.0.6+1

* Fixed the library trying to add the `availabilitychanged` event on unsupported platforms.

## 0.0.6

* Removed RxDart as a dependency
* Added Dart Meta annotations to help with avoiding methods only meant for testing
* Added a lot of documentation
* Added more error handling and descriptions for when these errors may occur and how to avoid them
* Added characteristic descriptor
* Deprecated SNAKE_CASE for default uuids. Use the camelCase version instead
* Switched to using `logger` instead of `print` statements. This allows other developers to decide what to do with the
  log messages

## 0.0.5

* Fixed typo in `characteristicvaluechanged` for the `BluetoothCharacteristic.startNotifications()`. (
  Thanks [AshTerry](https://github.com/AshTerry).)
* Fixed crash when the device name of a bluetooth device is null. (
  Thanks [alextekartik](https://github.com/alextekartik).)
* A lot of small lint fixes, but that shouldn't impact a project based on this library. (
  Thanks [alextekartik](https://github.com/alextekartik).)

## 0.0.4

* Fixed call to `navigator.bluetooth.getDevices` in browsers that don't support it.
* Added more documentation

## 0.0.3

* Forgot some Flutter dependency

## 0.0.2

* Removed Flutter as a dependency
* Added characteristic properties
* Added toLowerCase to every call that requires a UUID, because the web api expects only lower case UUIDS.
* Added Bluetooth descriptors.

## 0.0.1

* Basic support for web bluetooth api
