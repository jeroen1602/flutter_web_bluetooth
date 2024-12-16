import "dart:io";

import "package:analyzer/dart/analysis/features.dart";
import "package:analyzer/dart/analysis/utilities.dart";
import "package:analyzer/dart/ast/ast.dart" as ast;
import "package:code_builder/code_builder.dart";
import "package:dart_style/dart_style.dart";
import "package:flutter_web_bluetooth_builder/helpers/custom_code_builder_literals.dart";
import "package:flutter_web_bluetooth_builder/helpers/sdk_min_version.dart";
import "package:flutter_web_bluetooth_builder/helpers/variable_name.dart";
import "package:flutter_web_bluetooth_builder/helpers/yaml_utils.dart";
import "package:path/path.dart";
import "package:yaml/yaml.dart";

///
/// Get the latest company identifiers and generate an enum
///
Future<void> generateDefaultManufacturerIdentifiers() async {
  final manufacturerIdentifiersFile = normalize(joinAll([
    dirname(Platform.script.path),
    "../lib/src/bluetooth_default_manufacturer_identifiers.dart"
  ]));

  final manufacturerIdentifiersUri = Uri.parse(
      "https://bitbucket.org/bluetooth-SIG/public/raw/main/assigned_numbers/company_identifiers/company_identifiers.yaml");

  // final localManufacturerIdentifiersFile = File(normalize(
  //     joinAll([dirname(Platform.script.path), "./company_identifiers.yaml"])));

  final identifiers =
      await _getCurrentCompanyIdentifier(manufacturerIdentifiersUri);
  identifiers.sort();

  final existingIdentifiers =
      await _getExistingEnumConstants(manufacturerIdentifiersFile);

  final deprecatedIdentifiers = existingIdentifiers
      .where((final x) {
        final found = identifiers.cast<_ManufacturerIdentifier?>().firstWhere(
            (final y) => y?.identifier == x.identifier,
            orElse: () => null);
        if (found == null) {
          return true;
        }
        return found.variableName != x.variableName;
      })
      .map((final x) => _DeprecatedManufacturerIdentifier.createFromIdentifier(
          x, identifiers))
      .toList(growable: false);
  deprecatedIdentifiers.sort();

  final totalIdentifiers = [...identifiers, ...deprecatedIdentifiers];
  totalIdentifiers.sort();

  final libBuilder = LibraryBuilder();

  final enumBuilder = EnumBuilder();
  enumBuilder
    ..name = "BluetoothDefaultManufacturerIdentifiers"
    ..docs.addAll([
      "/// All the default Bluetooth low energy manufacturer identifiers are defined in this enum.",
      "/// See: [values] for a list of all the identifiers.",
      "/// See: [manufacturerIdentifiers] for a list of all the non-deprecated identifiers.",
      "/// ignore: deprecated_member_use_from_same_package",
      "/// See: [deprecatedManufacturerIdentifiers] for a list of all old deprecated identifiers.",
    ])
    ..values.addAll(totalIdentifiers.map((final identifier) =>
        EnumValue((final builder) {
          builder
            ..docs.add("/// The manufacturer identifier for ${identifier.name}")
            ..name = identifier.variableName
            ..arguments.addAll([
              literalStringDouble(identifier.name),
              literalHex(identifier.identifier),
            ]);

          if (identifier is _DeprecatedManufacturerIdentifier) {
            builder.annotations.add(refer("Deprecated")
                .call([literalStringDouble(identifier.deprecationMessage)]));
          }
        })))
    ..constructors.add(Constructor((final builder) {
      builder
        ..constant = true
        ..docs.addAll([
          "///",
          "/// A manufacturer identifier consists of a human readable name as well as",
          "/// the manufacturer's identifier",
          "///"
        ])
        ..requiredParameters.addAll([
          Parameter((final builder) {
            builder
              ..name = "name"
              ..toThis = true;
          }),
          Parameter((final builder) {
            builder
              ..name = "identifier"
              ..toThis = true;
          }),
        ]);
    }))
    ..fields.addAll([
      Field((final builder) {
        builder
          ..docs.add("/// The name of the manufacturer")
          ..type = const Reference("String")
          ..name = "name"
          ..modifier = FieldModifier.final$;
      }),
      Field((final builder) {
        builder
          ..docs.add("/// The 16 bit identifier of the manufacturer")
          ..type = const Reference("int")
          ..name = "identifier"
          ..modifier = FieldModifier.final$;
      }),
      Field((final builder) {
        builder
          ..docs.add("/// All non-deprecated manufacturer identifiers")
          ..type =
              const Reference("List<BluetoothDefaultManufacturerIdentifiers>")
          ..static = true
          ..name = "manufacturerIdentifiers"
          ..modifier = FieldModifier.constant
          ..assignment = Code(
              "[\n${identifiers.map((final x) => x.variableName).join(",\n")}\n]");
      }),
      Field((final builder) {
        builder
          ..docs.add("/// All deprecated manufacturer identifiers")
          ..type =
              const Reference("List<BluetoothDefaultManufacturerIdentifiers>")
          ..static = true
          ..annotations.add(refer("Deprecated").call([
            literalStringDouble(
                "This contains all deprecated manufacturer identifiers and should thus not be relied on")
          ]))
          ..name = "deprecatedManufacturerIdentifiers"
          ..modifier = FieldModifier.constant
          ..assignment = Code(
              "[\n${deprecatedIdentifiers.map((final x) => x.variableName).join(",\n")}\n]");
      }),
    ]);

  libBuilder.body.add(enumBuilder.build());

  final buildLibrary = libBuilder.build();

  final emitter = DartEmitter(useNullSafetySyntax: true);
  final libraryCode =
      """// This file has been automatically generated by the script
// // builder/builder.dart default-uuids.
// The data is retrieved from the official repository.


// ignore: use_string_in_part_of_directives
part of flutter_web_bluetooth;

${buildLibrary.accept(emitter)}
""";

  final outFile = File(manufacturerIdentifiersFile);
  await outFile.create();
  await outFile.writeAsString(
      DartFormatter(languageVersion: await getDartMinVersion())
          .format(libraryCode));
  // ignore: avoid_print
  print("Done");
}

Future<List<_ManufacturerIdentifier>> _getCurrentCompanyIdentifier(
    final dynamic input) async {
  final yaml = await loadYamlResource(input);

  final identifiers = yaml["company_identifiers"] as YamlList;

  final parsedIdentifiers = List.generate(identifiers.length, (final index) {
    final identifier = identifiers[index];
    final name = identifier["name"] as String;
    final variableName = camelCaseName(name);
    final companyIdentifier = identifier["value"] as int;
    return _ManufacturerIdentifier(name, variableName, companyIdentifier);
  });

  updateDuplicates<_ManufacturerIdentifier>(
      parsedIdentifiers,
      (final identifier) => identifier.variableName,
      (final identifier, final newName) => identifier.variableName = newName);

  return parsedIdentifiers;
}

Future<List<_ManufacturerIdentifier>> _getExistingEnumConstants(
    final String manufacturerIdentifiersFile) async {
  final output = <_ManufacturerIdentifier>[];

  final parsed = parseFile(
      path: manufacturerIdentifiersFile,
      featureSet: FeatureSet.latestLanguageVersion());
  final manufacturerEnum = parsed.unit.declarations
      .firstWhere((final x) => x is ast.EnumDeclaration) as ast.EnumDeclaration;

  if (manufacturerEnum.name.toString() !=
      "BluetoothDefaultManufacturerIdentifiers") {
    throw Error();
  }

  for (final enumValue in manufacturerEnum.constants) {
    final enumName = enumValue.name.toString();
    final arguments = enumValue.arguments?.argumentList.arguments;
    final stringNameArgument = arguments?[0];
    final idArgument = arguments?[1];
    if (stringNameArgument is! ast.SimpleStringLiteral) {
      throw Error();
    }
    if (idArgument is! ast.IntegerLiteral) {
      throw Error();
    }
    final stringName = stringNameArgument.stringValue;
    final id = idArgument.value;

    if (stringName == null || id == null) {
      throw Error();
    }
    output.add(_ManufacturerIdentifier(stringName, enumName, id));
  }

  return output;
}

class _DeprecatedManufacturerIdentifier extends _ManufacturerIdentifier {
  final String deprecationMessage;

  _DeprecatedManufacturerIdentifier(this.deprecationMessage, super.name,
      super.variableName, super.identifier);

  factory _DeprecatedManufacturerIdentifier.createFromIdentifier(
      final _ManufacturerIdentifier deprecatedIdentifier,
      final List<_ManufacturerIdentifier> existingIdentifiers) {
    final message =
        _generateDeprecationMessage(deprecatedIdentifier, existingIdentifiers);
    return _DeprecatedManufacturerIdentifier(message, deprecatedIdentifier.name,
        deprecatedIdentifier.variableName, deprecatedIdentifier.identifier);
  }
}

class _ManufacturerIdentifier implements Comparable<_ManufacturerIdentifier> {
  final String name;
  String variableName;
  final int identifier;

  _ManufacturerIdentifier(this.name, this.variableName, this.identifier);

  @override
  int compareTo(final _ManufacturerIdentifier other) =>
      other.identifier - identifier;
}

String _generateDeprecationMessage(
    final _ManufacturerIdentifier deprecatedIdentifier,
    final List<_ManufacturerIdentifier> existingIdentifiers) {
  final found = existingIdentifiers.cast<_ManufacturerIdentifier?>().firstWhere(
      (final x) => x?.identifier == deprecatedIdentifier.identifier,
      orElse: () => null);
  if (found != null) {
    return "Identifier has been renamed; use ${found.variableName} instead";
  }
  return "Identifier no longer exists in the Bluetooth spec";
}
