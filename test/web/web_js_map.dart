@TestOn("browser")
library;

import "package:flutter_web_bluetooth/web/js/js.dart";
import "package:flutter_web_bluetooth/web/js/js_map.dart";
import "package:test/test.dart";

void main() {
  test("Should create js map", () {
    final map = JSMap();
    expect(map.isDefinedAndNotNull, true,
        reason: "creating map should be truthy");
    expect(map.size.toDartInt, 0, reason: "new map should be empty");
  });

  test("Should convert map to js", () {
    final dartMap = {
      "first".toJS: 1.toJS,
      "second".toJS: 2.toJS,
    };

    final map = dartMap.toJS;
    expect(map.isDefinedAndNotNull, true,
        reason: "creating map should be truthy");
    expect(map.size.toDartInt, 2, reason: "new map should be empty");

    final convertedBack = map.toDart;
    expect(convertedBack, dartMap,
        reason: "Map converted back should be the same");
  });
}
