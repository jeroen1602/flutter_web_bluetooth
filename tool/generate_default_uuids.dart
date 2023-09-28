#!/bin/env dart

import "dart:io";

// source: https://www.bluetooth.com/specifications/assigned-numbers/

Future<int> main() async {
  final dir = File(Platform.script.toFilePath()).parent;
  final servicesFile = File("${dir.path}/services_uuids.csv");
  final characteristicsFile = File("${dir.path}/characteristics_uuids.csv");
  final outputFile = File("${dir.path}/output.dart");

  if (await outputFile.exists()) {
    stderr.writeln("Output file already exists!");
    stderr.write("Overwrite? (Y/n)");
    final line = stdin.readLineSync();
    if (line?.toLowerCase() == "n") {
      exit(3);
    }
    await outputFile.delete();
  }

  const outputFileHeader =
      "/// This file has been automatically generated by the script\n"
      "/// scripts/generate_default_uuids.dart. If you need more uuids please change\n"
      "/// the csv files and regenerate the file.\n"
      "\n"
      "part of flutter_web_bluetooth;\n"
      "\n";

  final servicesUuidEnum = StringBuffer();
  servicesUuidEnum.write(
      "/// All the default Bluetooth low energy services are defined in this enum.\n"
      "/// See: [values] for a list of all the services.\n"
      "enum BluetoothDefaultServiceUUIDS {\n");

  bool first = true;
  await readThroughFile(servicesFile, (final holder) {
    if (first) {
      first = false;
    } else {
      servicesUuidEnum.write(",\n");
    }
    servicesUuidEnum.write("    /// The default service for ${holder.name}\n"
        "    ${holder.variableName}(\"${holder.name}\", "
        "\"${holder.uuid16}\", "
        "\"${holder.uuid}\")");
  });

  servicesUuidEnum.write(";\n\n"
      "    ///\n"
      "    /// A service UUID consists of a human readable name of the service, as well\n"
      "    /// as its uuid represented as a 16 bit uuid and a full 128 bit uuid.\n"
      "    ///\n"
      "    const BluetoothDefaultServiceUUIDS(this.name, this.uuid16, this.uuid);\n"
      "    /// The name of the service.\n"
      "    final String name;\n"
      "    /// The shorter 16 bit uuid of the service.\n"
      "    final String uuid16;\n"
      "    /// The full uuid of the service.\n"
      "    final String uuid;\n"
      "}\n\n");

  final characteristicUuidEnum = StringBuffer();
  characteristicUuidEnum.write(
      "/// All the default Bluetooth low energy characteristics are defined in this enum.\n"
      "/// See: [values] for a list of all the characteristics.\n"
      "enum BluetoothDefaultCharacteristicUUIDS {\n");

  first = true;
  await readThroughFile(characteristicsFile, (final holder) {
    if (first) {
      first = false;
    } else {
      characteristicUuidEnum.write(",\n");
    }
    characteristicUuidEnum
        .write("    /// The default characteristic for ${holder.name}\n"
            "    ${holder.variableName}(\"${holder.name}\", "
            "\"${holder.uuid16}\", "
            "\"${holder.uuid}\")");
  });

  characteristicUuidEnum.write(";\n\n"
      "    ///\n"
      "    /// A characteristic UUID consists of a human readable name of the service, as well\n"
      "    /// as its uuid represented as a 16 bit uuid and a full 128 bit uuid.\n"
      "    ///\n"
      "    const BluetoothDefaultCharacteristicUUIDS(this.name, this.uuid16, this.uuid);\n"
      "    /// The name of the characteristic.\n"
      "    final String name;\n"
      "    /// The shorter 16 bit uuid of the characteristic.\n"
      "    final String uuid16;\n"
      "    /// The full uuid of the characteristic.\n"
      "    final String uuid;\n"
      "}\n\n");

  await outputFile.create();
  await outputFile.writeAsString(outputFileHeader, mode: FileMode.writeOnly);
  await outputFile.writeAsString(servicesUuidEnum.toString(),
      mode: FileMode.writeOnlyAppend);
  await outputFile.writeAsString(characteristicUuidEnum.toString(),
      mode: FileMode.writeOnlyAppend);
  // ignore: avoid_print
  print("Done");
  return 0;
}

String camelCaseName(final String name) {
  final words =
      name.replaceAll("-", " ").replaceAll(".", " ").toLowerCase().split(" ");
  words.retainWhere((final element) => element.isNotEmpty);
  return words.reduce((final value, final element) =>
      "$value${element[0].toUpperCase()}${element.substring(1)}");
}

Future<void> readThroughFile(final File inputFile,
    final void Function(CharacteristicHolder holder) forEach) async {
  final lines = await inputFile.readAsLines();
  for (int i = 0; i < lines.length; i++) {
    final columns = lines[i].split(",");
    if (columns.length != 2) {
      stderr.writeln("There should be 2 columns at line ${i + 1}");
      exit(4);
    }
    final uuidInt = int.parse(columns[0].replaceFirst("0x", ""), radix: 16);
    final name = columns[1].replaceAll("\r", "").replaceAll("\n", "").trim();
    final variableName = camelCaseName(name);
    final uuid16 = uuidInt.toRadixString(16).toLowerCase().padLeft(4, "0");
    final uuid =
        "${uuidInt.toRadixString(16).toLowerCase().padLeft(8, "0")}-0000-1000-8000-00805f9b34fb";
    forEach(CharacteristicHolder(variableName, name, uuid16, uuid));
  }
}

class CharacteristicHolder {
  final String variableName;
  final String name;
  final String uuid16;
  final String uuid;

  CharacteristicHolder(this.variableName, this.name, this.uuid16, this.uuid);
}