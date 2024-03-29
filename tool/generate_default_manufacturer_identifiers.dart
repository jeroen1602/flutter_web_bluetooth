#!/bin/env dart

import "dart:convert";
import "dart:io";

import "package:http/http.dart" as http;
import "package:yaml/yaml.dart";

Future<int> main() async {
  final dir = File(Platform.script.toFilePath()).parent;
  final outputFile = File("${dir.path}/manufacturer_output.dart");

  if (await outputFile.exists()) {
    stderr.writeln("Output file already exists!");
    stderr.writeln("Overwrite? (Y/n)");
    final line = stdin.readLineSync();
    if (line?.toLowerCase() == "n") {
      exit(3);
    }
    await outputFile.delete();
  }

  final manufacturerIdentifiersUri = Uri.parse(
      "https://bitbucket.org/bluetooth-SIG/public/raw/main/assigned_numbers/company_identifiers/company_identifiers.yaml");

  // final localManufacturerIdentifiersFile = File("${dir.path}/company_identifiers.yaml");

  final manufacturerIdentifiers =
      await createManufacturerIdentifier(manufacturerIdentifiersUri);

  const outputFileHeader =
      "// This file has been automatically generated by the script\n"
      "// scripts/generate_default_manufacturer_identifiers.dart.\n"
      "// The data is retrieved from the official repository.\n"
      "\n"
      "// ignore: use_string_in_part_of_directives\n"
      "part of flutter_web_bluetooth;\n"
      "\n";

  await outputFile.create();
  await outputFile.writeAsString(outputFileHeader, mode: FileMode.writeOnly);
  await outputFile.writeAsString(manufacturerIdentifiers,
      mode: FileMode.writeOnlyAppend);
  // ignore: avoid_print
  print("Done");
  return 0;
}

Future<String> createManufacturerIdentifier(final dynamic input) async {
  final yaml = await loadYamlResource(input);
  final identifiers = yaml["company_identifiers"] as YamlList;

  final parsedIdentifiers = List.generate(identifiers.length, (final index) {
    final identifier = identifiers[index];
    final name = identifier["name"] as String;
    final escapedName = name.replaceAll("\"", "\\\"");
    final variableName = camelCaseName(name);
    final manufacturerIdentifier = identifier["value"] as int;
    return ManufacturerIdentifier(
        name, escapedName, variableName, manufacturerIdentifier);
  });

  updateDuplicates<ManufacturerIdentifier>(
      parsedIdentifiers,
      (final identifier) => identifier.variableName,
      (final identifier, final newName) => identifier.variableName = newName);

  final manufacturerIdentifiers = StringBuffer();
  manufacturerIdentifiers.write(
      "/// All the default Bluetooth low energy manufacturer identifiers are defined in this enum.\n"
      "/// See : [values] for a list of all the identifiers.\n"
      "enum BluetoothDefaultManufacturerIdentifiers {\n");

  bool first = true;
  for (final identifier in parsedIdentifiers) {
    if (first) {
      first = false;
    } else {
      manufacturerIdentifiers.write(",\n");
    }

    manufacturerIdentifiers
        .write("    /// The manufacturer identifier for ${identifier.name}\n"
            "    ${identifier.variableName}(\"${identifier.escapedName}\", "
            "0x${identifier.identifier.toRadixString(16).toUpperCase()})");
  }

  manufacturerIdentifiers.write(";\n\n"
      "    ////\n"
      "    //// A manufacturer identifier consists of a human readable name as well as\n"
      "    //// the manufacturer's identifier\n"
      "    ////\n"
      "    const BluetoothDefaultManufacturerIdentifiers(this.name, this.identifier);\n"
      "    /// The name of the manufacturer\n"
      "    final String name;\n"
      "    /// The 16 bit identifier of the manufacturer\n"
      "    final int identifier;\n"
      "}\n");

  return manufacturerIdentifiers.toString();
}

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

class ManufacturerIdentifier {
  final String name;
  final String escapedName;
  String variableName;
  final int identifier;

  ManufacturerIdentifier(
      this.name, this.escapedName, this.variableName, this.identifier);
}

void updateDuplicates<T>(final List<T> input, final String Function(T) getName,
    final void Function(T, String) setName) {
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

//region CONVERT_NAME
final numberRegex = RegExp(r"(^\d+)");
final nonAscii = RegExp(r"([^\x00-\x7F])");

String camelCaseName(final String name) {
  var convertedName = name
      .replaceAll("-", " ")
      .replaceAll(".", " ")
      .replaceAll(",", " ")
      .replaceAll("&", "And")
      .replaceAll("/", " ")
      .replaceAll("+", " ")
      .replaceAll("(", " ")
      .replaceAll(")", " ")
      .replaceAll("（", " ")
      .replaceAll("）", " ")
      .replaceAll("\"", "")
      .replaceAll("“", "")
      .replaceAll("'", "")
      .replaceAll("|", " ")
      .replaceAll("!", " ")
      .replaceAll("¤", " ")
      .toLowerCase();

  convertedName = convertedName.replaceAllMapped(numberRegex, (final match) {
    final number = int.parse(match.group(0)!, radix: 10);
    final asText = numberMap[number];
    if (asText == null) {
      throw UnimplementedError("Could not convert $number to a string");
    }
    return "$asText ";
  });

  convertedName = convertedName.replaceAllMapped(nonAscii, (final match) {
    final matchedText = match.group(0)!;
    final newText = nonAsciiMap[matchedText];
    if (newText == null) {
      throw UnimplementedError(
          "Could not convert $matchedText to an ascii string");
    }
    return newText;
  });

  final words = convertedName.split(" ");
  words.retainWhere((final element) => element.isNotEmpty);
  return words.reduce((final value, final element) =>
      "$value${element[0].toUpperCase()}${element.substring(1)}");
}

const numberMap = {
  0: "zero",
  1: "one",
  2: "two",
  3: "three",
  4: "four",
  5: "five",
  6: "six",
  7: "seven",
  8: "eight",
  9: "nine",
  10: "ten",
  11: "eleven",
  12: "twelve",
  13: "thirteen",
  14: "fourteen",
  15: "fifteen",
  16: "sixteen",
  17: "seventeen",
  18: "eighteen",
  19: "nineteen",
  20: "twenty",
  70: "seventy",
  701: "seven hundred one",
  9374: "nine thousand three hundred seventy four",
  2048450: "two million forty eight thousand four hundred fifty",
  2587702:
      "two million five hundred eighty seven thousand seven hundred and two",
  9974091: "nine million nine hundred seventy four thousand ninety one",
};

const nonAsciiMap = {
  "ö": "o",
  "ó": "o",
  "ä": "a",
  "ã": "a",
  "é": "e",
  "ü": "u",
  "¶": "p",
  "©": "c",
};
// endregion
