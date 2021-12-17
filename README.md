# Introduction

Flutter web bluetooth is a ~~Flutter~~ [Dart](https://dart.dev/) plugin to add support for the 
[web bluetooth api](https://developer.mozilla.org/en-US/docs/Web/API/Web_Bluetooth_API).

The library doesn't require Flutter at all giving you the option to use it with projects like 
[AngularDart](https://angulardart.xyz/).

It is also written in such a way that it will play nicely with Dart native projects. 
So if you have a cross-platform app and want to add web support you don't have to use conditional exports to exclude 
the library in native releases.

For example: 

```dart
export 'src/unsupported_library.dart'
    if (dart.library.html) 'src/web_library.dart';
```

It will (of course) not work when not used in a browser, but it will compile! 

The example code in this project is hosted on Github pages. Checkout 
[jeroen1602.github.io/flutter_web_bluetooth/](https://jeroen1602.github.io/flutter_web_bluetooth/) for a proof of 
concept.

# Limited support

The web bluetooth is still a draft, because of this it is not (yet) supported in every browser. 
Check [canIUse.com](https://caniuse.com/web-bluetooth) for information about browser support.

Some parts of the api aren't available in every version of the browser.

# Requirements

The device and browser you're testing on needs to support the web api. For Chrome on Linux this is hidden behind a flag.
I've created a patch file which you can use to launch Google Chrome, from `flutter run` with the required flag enabled.
Check the [chrome-experimental-launch](./chrome-experimental-launch) folder's README for more information.

You will also need a secure context or else the api will not be available. So either https, or localhost.

# Usage

First check if the current browser supports the web bluetooth api.

```dart
// The bluetooth api exists in this user agent.
final supported = FlutterWebBluetooth.instance.isBluetoothApiSupported;
```

After this we will need to check if bluetooth is available

```dart
// A stream that says if a bluetooth adapter is available to the browser.
final available = FlutterWebBluetooth.instance.isAvailable;
```

Now request a device from the browser.
You must beforehand specify which services you want to connect to! If you do not request
access to a specific service then you won't be able to discover the service!

Some services are also part of a so called blocklist. This is different per browsers and these services are just off 
limit.

```dart
// Define the services you want to communicate with here!
final requestOptions = RequestOptionsBuilder.acceptAllDevices(optionalServices: [
  BluetoothDefaultServiceUUIDS.DEVICE_INFORMATION.uuid
]);

try {
  final device = await FlutterWebBluetooth.instance.requestDevice(requestOptions);
} on UserCancelledDialogError {
  // The user cancelled the dialog
} on DeviceNotFoundError {
  // There is no device in range for the options defined above
}
```

Now that you have a device, you can go through the services and then find the characteristics you want to read.

```dart
await device.connect();
final services = await device.discoverServices();
final service = services.firstWhere((service) => service.uuid == BluetoothDefaultServiceUUIDS.DEVICE_INFORMATION.uuid);
// Now get the characteristic
final characteristic = await service.getCharacteristic(BluetoothDefaultCharacteristicUUIDS.MANUFACTURER_NAME_STRING.uuid);
final value = characteristic.readValue();
// Now we have a [ByteData] object with the manufacturer name in it.
device.disconnect();
```

Once you have paired to a device you can communicate with it again without the user needing to pair to it again. Get a
reference back to all the connected devices by listening to the devices stream.


**Note:** This feature will only work if the "Experimental Web Platform features" flag is enabled.

```dart
// A stream with a [Set] of all the devices that the user has paired, and given permission for.
FlutterWebBluetooth.instance.devices;
```
