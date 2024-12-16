import "dart:io";

import "package:flutter_web_bluetooth_builder/helpers/yaml_utils.dart";
import "package:path/path.dart";
import "package:pub_semver/pub_semver.dart";

///
/// Get the minimum allowed version of the dart SDK of the main project.
///
/// This is required for the dart formatter.
///
Future<Version> getDartMinVersion() async {
  final pubSpectYamlFile = File(
      normalize(joinAll([dirname(Platform.script.path), "../pubspec.yaml"])));

  final pubSpectYaml = await loadYamlResource(pubSpectYamlFile);

  final environment = pubSpectYaml["environment"];

  final sdk = environment["sdk"] as String;

  final range = VersionConstraint.parse(sdk);

  if (range is Version) {
    return range;
  } else if (range is VersionRange) {
    final min = range.min;
    if (min != null) {
      if (range.includeMin) {
        return min;
      } else {
        return Version(min.major, min.minor, min.patch + 1);
      }
    }
    return Version.none;
  } else {
    throw ArgumentError("Could not get min dart version");
  }
}
