## 1.1.0

* **Breaking-ish** Requesting devices or scans now no longer checks if a bluetooth device is available.
  The browser will return a `DeviceNotFoundError` if the bluetooth adapter was unavailable while a scan was requested.
    * If you want the old behaviour then set `checkingAvailability` to `true` for `requestDevice`,
      `requestAdvertisementDevice`, and/ or `requestLEScan`.
* You can now call `getAvailability` to get a (new) `Future` that will check if there is currently a bluetooth adapter
  available.
* Updated list of manufacturer identifiers

## 1.0.0

* Changed from `dart:html` to `dart:js_interop` to support wasm builds.
* Dependencies:
    * Updated min dart version to `3.3.0`
    * No longer require [js](https://pub.dev/packages/js)
    * Require [web](https://pub.dev/packages/web) package `0.5.0` or higher
* Bluetooth advertisements
    * **Breaking:** `src/AdvertisementReceivedEvent` no longer extends `web/AdvertisementReceivedEventInterface`
    * `src/AdvertisementReceivedEvent` now has a `withMemory` constructor
    * **Breaking:** `web/AdvertisementReceivedEventInterface` no longer exists
    * **Breaking:** `web/WebAdvertisementReceivedEvent` has been renamed to `web/BluetoothAdvertisementReceivedEvent`
    * **Breaking:** `web/WebAdvertisementReceivedEvent.fromJSObject` constructor no longer exists
    * **Breaking:** `web/WebAdvertisementReceivedEvent.withMemory` constructor no longer exists
* Bluetooth filters:
    * `web/BluetoothScanFilterHelper` is now deprecated. Use `web/BluetoothManufacturerDataFilter.create()`,
      `web/BluetoothServiceDataFilter.create()`, and `web/BluetoothScanFilter.create()` instead.
    * **Breaking:** `web/BluetoothServiceDataFilter` now requires a service UUID. Following spec
    * **Breaking:** `web/BluetoothManufacturerDataFilter` now requires a company identifier. Following spec
    * **Breaking:** `src/ServiceDataFilterBuilder` now requires a service UUID. Following spec
    * **Breaking:** `src/ManufacturerDataFilterBuilder` now requires a company identifier. Following spec
* **Breaking:** `web/js/AbortController` has been removed in favor of the implementation form the `web` package
* **Breaking:** `web/js/JSUtils` has been removed (this was an internal library so it shouldn't have any impact on most
  projects)
* **Breaking:** `web/NativeBluetooth` now returns `JSPromises` and other native objects instead of `object`
* **Breaking:** `web/testingSetNavigator()` now requires that you set a `web` navigator object.
* **Breaking:** `web/*` all `addEventListener` and `removeEventListener` functions now extend from `web/EventTarget`
* **Breaking:** `web/*` all objects now implement `JSObject` and have been marked with `@JS`. This also removes all
  `fromJSObject` constructors.
* **Breaking:** removed `web/WebBluetoothConverters`
* `web/WatchAdvertisementsOptions` the signal property is now nullable. Following the spec.
* `web/*` created event streams using `BluetoothEventStreamProviders`.
* created `web/WebBluetoothValueEvent` for the `availabilitychanged` event.
* Changed example project to also use `dart:js_interop` instead of `dart:html`.
* **Breaking:** Removed all deprecated `BluetoothDefaultManufacturerIdentifiers` cases. That were deprecated pre this
  release.
* **Breaking:** Removed all deprecated `BluetoothDefaultServiceUUIDS` cases. That were deprecated pre this release.

## 0.2.4

* Updated `BluetoothDefaultManufacturerIdentifiers`, some identifiers have been renamed, the old names have been marked
  as deprecated.
    * Use `BluetoothDefaultManufacturerIdentifiers.manufacturerIdentifiers` to get a list of all the non-deprecated
      identifiers.
* Updated `BluetoothDefaultServiceUUIDS` with the latest service UUIDS. Some services now use the official name from the
  Bluetooth SIG, the old names have been marked as deprecated.
    * Use `BluetoothDefaultServiceUUIDS.services` to get a list of all the non-deprecated service UUIDS.
    * Added the `id` field to the enum, this contains the official Bluetooth SIG id of the UUID.
* Updated `BluetoothDefaultCharacteristicUUIDS` with the latest characteristic UUIDS. Some characteristic now use the
  official name from the Bluetooth SIG, some characteristics no longer exist in the spec. The old names and values have
  been marked as deprecated
    * Use `BluetoothDefaultCharacteristicUUIDS.characteristics` to get a list of all the non-deprecated characteristic
      UUIDS.
    * Added the `id` field to the enum, this contains the official Bluetooth SIG id of the UUID.
* Updated docs to link to the current version of the `service`, `characteristic`, and `manufacturer data` blocklists
    * https://github.com/WebBluetoothCG/registries/blob/master/gatt_blocklist.txt
    * https://github.com/WebBluetoothCG/registries/blob/master/manufacturer_data_blocklist.txt

## 0.2.3

* Added `optionalManufacturerData` to `RequestOptions`. This is needed to get the manufacture data when watching
  advertisements.
* Added `BluetoothDefaultManufacturerIdentifiers` enum with all the registered manufacturer identifiers
* Fixed the conversion from a JS map to a dart map for manufacturer data and service data.
  If you are listening to advertisements then these values will now be returned correctly.
* Update dependencies.

## 0.2.2

* Added `exclusionFilters` to `RequestOptionsBuilder`.
* Added new MissingUserGestureError that you may need to handle.
* Updated dependencies to be more broad. (The minimum versions are still supported.)

## 0.2.1

* Updated dependencies.

## 0.2.0

* **Breaking** Removed SNAKE_CASE uuids.
    * The default uuids are now an enum since dart supports enums with values.
    * If you were using `defaultUuid.ordinal` then you should now use `defaultUuid.index`.
    * Some names may slightly differ.
* **Breaking** Upgraded minimum dart sdk to `2.17`
* Added `forget` to a `BluetoothDevice`, to forget a device.

## 0.1.0

* **Breaking** in `Bluetooth.requestDevice()` the `RequestOptions` are no longer nullable.
* **Breaking** `BluetoothDevice.gatt` is no longer marked as deprecated, it is still marked as `visibleForTesting`.
* Added bluetooth advertisements event to a bluetooth device. (Note this is still behind a flag in most browsers.)
* Support the newest version of logging.
* Added `requestLEScan` to `Bluetooth` and `FlutterWebBluetooth`. You can now scan for devices advertisements without
  needing to pair with each device. However, a normal pair does need to happen before characteristics can be used.
* Continuing with the IOS Bluefy browser fix for characteristic properties.
    * Added `has` methods for all the fields in characteristic properties.
    * Return `false` as default value when a property doesn't exist.
    * Added `hasProperties` method to check if there are any properties at all. Use this to test if the properties are
      even reliable.
    * You can remove any try-catch logic around reading properties if you added those for the mitigation.
* The next version of the library will probably upgrade the minimum SDK from `2.12` to `2.17` to keep up with other
  packages. If there are any good reasons to not do this then please create an issue on Github.

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
