#!/usr/bin/env dart

import "dart:async";

import "package:args/command_runner.dart";
import "package:flutter_web_bluetooth_builder/default_manufacturer_identifiers.dart";
import "package:flutter_web_bluetooth_builder/default_uuids.dart";

Future<void> main(final List<String> args) async {
  final manufacturerIdRunner =
      CommandRunner(
          "builder",
          "Generate enums based on Bluetooth assigned numbers",
        )
        ..addCommand(_ManufacturerIdentifierCommand())
        ..addCommand(_DefaultUUIDSCommand());

  manufacturerIdRunner.run(args);
}

class _ManufacturerIdentifierCommand extends Command {
  @override
  final name = "manufacturer-ids";
  @override
  final description = "Generate default manufacturer identifiers";

  @override
  FutureOr<void> run() async => generateDefaultManufacturerIdentifiers();
}

class _DefaultUUIDSCommand extends Command {
  @override
  final name = "default-uuids";
  @override
  final description = "Generate default service and characteristics UUIDS";

  @override
  FutureOr<void> run() async => generateDefaultUUIDs();
}
