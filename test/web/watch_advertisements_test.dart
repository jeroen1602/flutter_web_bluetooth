@TestOn("browser")
library;

import "dart:async";

import "package:flutter_web_bluetooth/flutter_web_bluetooth.dart";
import "package:flutter_web_bluetooth/js_web_bluetooth.dart";
import "package:flutter_web_bluetooth/web/js/js.dart";
import "package:test/test.dart";

void _ignoreEventListener(
  final String type,
  final JSAny? listener, [
  final JSAny? options,
]) {}

WebBluetoothDevice _fakeDevice(
  final JSPromise<JSAny?> Function(WatchAdvertisementsOptions) onWatch,
) {
  final device = JSObject() as WebBluetoothDevice;
  device.setProperty("id".toJS, "TEST-ID".toJS);
  device.setProperty("addEventListener".toJS, _ignoreEventListener.toJS);
  device.setProperty("watchAdvertisements".toJS, onWatch.toJS);
  return device;
}

void main() {
  test("watchAdvertisements keeps the controller for the lifetime case",
      () async {
    AbortSignal? signal;
    final start = Completer<JSAny?>();
    final device = BluetoothDevice(_fakeDevice((final options) {
      signal = options.signal;
      return start.future.toJS;
    }));

    unawaited(device.watchAdvertisements());
    await pumpEventQueue();

    expect(signal, isNotNull,
        reason: "Should pass a signal to the native call");
    expect(signal!.aborted, false, reason: "Watch should still be running");

    await device.unwatchAdvertisements();
    expect(signal!.aborted, true,
        reason: "unwatch should abort the retained controller");
  });

  test("watchAdvertisements startupTimeout aborts and throws", () async {
    AbortSignal? signal;
    final start = Completer<JSAny?>();
    final device = BluetoothDevice(_fakeDevice((final options) {
      signal = options.signal;
      return start.future.toJS;
    }));

    await expectLater(
      device.watchAdvertisements(null, const Duration(milliseconds: 20)),
      throwsA(isA<TimeoutException>()),
    );

    expect(signal, isNotNull,
        reason: "Should pass a signal to the native call");
    expect(signal!.aborted, true,
        reason: "Timing out the startup should abort the watch");
  });

  test("watchAdvertisements startupTimeout keeps a fast start", () async {
    AbortSignal? signal;
    final device = BluetoothDevice(_fakeDevice((final options) {
      signal = options.signal;
      return Future<JSAny?>.value(null).toJS;
    }));

    await device.watchAdvertisements(null, const Duration(seconds: 5));
    await Future<void>.delayed(const Duration(milliseconds: 50));

    expect(signal, isNotNull,
        reason: "Should pass a signal to the native call");
    expect(signal!.aborted, false,
        reason: "A start within the startup timeout should not be aborted");
  });
}
