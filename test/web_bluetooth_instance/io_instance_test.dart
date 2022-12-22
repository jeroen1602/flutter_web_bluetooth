@TestOn("vm")
import "package:flutter_web_bluetooth/flutter_web_bluetooth.dart";
import "package:flutter_web_bluetooth/js_web_bluetooth.dart";
import "package:test/fake.dart";
import "package:test/test.dart";

class FakeRequestOptions extends Fake implements RequestOptionsBuilder {}

void main() {
  test("Instance on io not available", () async {
    final available = await FlutterWebBluetooth.instance.isAvailable.first;
    expect(available, false);
  });

  test("Instance on io bluetooth not supported", () async {
    final supported = FlutterWebBluetooth.instance.isBluetoothApiSupported;
    expect(supported, false);
  });

  test("Instance on io can't get device", () async {
    expect(
        () async => await FlutterWebBluetooth.instance
            .requestDevice(FakeRequestOptions()),
        throwsA(const TypeMatcher<NativeAPINotImplementedError>()));
  });
}
