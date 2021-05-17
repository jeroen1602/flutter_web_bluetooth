import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_web_bluetooth/flutter_web_bluetooth.dart';

const String EXAMPLE_TEXT =
    "SecurityError: getCharacteristic(s) called with blocklisted UUID. https://goo.gl/4NeimX";
const String JUST_THE_URL = "https://goo.gl/4NeimX";
const String UUID = "0000FFFF-0000-1000-8000-00805f9b34fb";

void main() {
  test('SecurityError should parse url', () {
    final testError = SecurityError(UUID, EXAMPLE_TEXT);
    expect(testError.uuid, UUID, reason: 'UUID should match');
    expect(testError.url, JUST_THE_URL, reason: 'The URL should match');
  });
}
