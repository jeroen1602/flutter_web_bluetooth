import "package:flutter_web_bluetooth/js_web_bluetooth.dart";
import "package:flutter_web_bluetooth/web/js/js.dart";

abstract class NavigatorFakes {
  static Navigator getValidNavigator() {
    final fakeNavigator = JSObject() as Navigator;
    fakeNavigator.setProperty("bluetooth".toJS, JSObject());
    return fakeNavigator;
  }

  static Navigator getNavigatorNoBluetooth() {
    final fakeNavigator = JSObject() as Navigator;
    fakeNavigator.setProperty("no-bluetooth".toJS, JSObject());
    return fakeNavigator;
  }
}

abstract class WebBluetoothDeviceFakes {
  static WebBluetoothDevice getValidWebBluetoothDevice({
    required final String id,
    required final List<int> uuids,
    final String? name,
    final NativeBluetoothRemoteGATTServer? gatt,
  }) {
    final fakeDevice = JSObject() as WebBluetoothDevice;
    fakeDevice.setProperty("id".toJS, id.toJS);

    fakeDevice.setProperty("_uuids".toJS,
        uuids.map((final x) => x.toJS).toList(growable: false).toJS);

    if (name != null) {
      fakeDevice.setProperty("name".toJS, name.toJS);
    }

    if (gatt != null) {
      fakeDevice.setProperty("gatt".toJS, gatt);
    }

    return fakeDevice;
  }
}
