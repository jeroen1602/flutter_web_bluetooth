## 0.0.6

* Removed RxDart as a dependency
* Added Dart Meta annotations to help with avoiding methods only meant for testing
* Added a lot of documentation
* Added more error handling and descriptions for when these errors may occur and how to avoid them
* Added characteristic descriptor
* Deprecated SNAKE_CASE for default uuids. Use the camelCase version instead

## 0.0.5

* Fixed typo in `characteristicvaluechanged` for the `BluetoothCharacteristic.startNotifications()`. (Thanks [AshTerry](https://github.com/AshTerry).)
* Fixed crash when the device name of a bluetooth device is null. (Thanks [alextekartik](https://github.com/alextekartik).)
* A lot of small lint fixes, but that shouldn't impact a project based on this library. (Thanks [alextekartik](https://github.com/alextekartik).)

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
