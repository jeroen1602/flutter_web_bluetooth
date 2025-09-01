import "dart:convert";
import "dart:io";

import "package:http/http.dart" as http;
import "package:yaml/yaml.dart";

///
/// Load a yaml resource
///
Future<YamlMap> loadYamlResource(final dynamic input) async {
  final String body;
  if (input is Uri) {
    final response = await http.get(input);
    body = utf8.decode(response.bodyBytes);
  } else if (input is File) {
    body = await input.readAsString();
  } else {
    throw UnimplementedError("Unknown input type ${input.runtimeType}");
  }
  return loadYaml(body);
}

///
/// Update the name of possible duplicates in a list
///
void updateDuplicates<T>(
  final List<T> input,
  final String Function(T) getName,
  final void Function(T, String) setName,
) {
  for (var i = 0; i < input.length; i++) {
    final foundIndex = [i];
    final name = getName(input[i]);
    for (var j = i + 1; j < input.length; j++) {
      if (name == getName(input[j])) {
        foundIndex.add(j);
      }
    }
    if (foundIndex.length > 1) {
      for (var k = 0; k < foundIndex.length; k++) {
        setName(input[foundIndex[k]], "$name${k + 1}");
      }
    }
  }
}
