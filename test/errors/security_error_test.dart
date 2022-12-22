import "package:flutter_web_bluetooth/flutter_web_bluetooth.dart";
import "package:test/test.dart";

const String exampleText =
    "SecurityError: getCharacteristic(s) called with blocklisted UUID. https://goo.gl/4NeimX";
const String justTheUrl = "https://goo.gl/4NeimX";
const String uuid = "0000FFFF-0000-1000-8000-00805f9b34fb";

void main() {
  test("SecurityError should parse url", () {
    final testError = SecurityError(uuid, exampleText);
    expect(testError.uuid, uuid, reason: "UUID should match");
    expect(testError.url, justTheUrl, reason: "The URL should match");
  });
}
