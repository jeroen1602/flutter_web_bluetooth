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
/// Get the latest Service and Characteristics UUIDs and generate default enums.
///
Future<void> generateDefaultUUIDs() async {
  final defaultUUIDSFile = normalize(
    joinAll([
      dirname(Platform.script.path),
      "../lib/src/bluetooth_default_uuids.dart",
    ]),
  );

  final serviceUUIDSUri = Uri.parse(
    "https://bitbucket.org/bluetooth-SIG/public/raw/main/assigned_numbers/uuids/service_uuids.yaml",
  );
  final characteristicUUIDSUri = Uri.parse(
    "https://bitbucket.org/bluetooth-SIG/public/raw/main/assigned_numbers/uuids/characteristic_uuids.yaml",
  );

  // final serviceUUIDSFile = File(normalize(
  //     joinAll([dirname(Platform.script.path), "./service_uuids.yaml"])));
  // final characteristicUUIDSFile = File(normalize(
  //     joinAll([dirname(Platform.script.path), "./characteristic_uuids.yaml"])));

  final services = await _getCurrentBluetoothUUIDS(serviceUUIDSUri);
  final characteristics = await _getCurrentBluetoothUUIDS(
    characteristicUUIDSUri,
  );
  services.sort();
  characteristics.sort();

  final (existingServices, existingCharacteristics) =
      await _getCurrentServiceAndCharacteristicUUIDs(defaultUUIDSFile);

  final deprecatedServices = existingServices
      .where((final x) {
        final found = services.cast<_BluetoothUUID?>().firstWhere(
          (final y) => y?.uuid16 == x.uuid16,
          orElse: () => null,
        );
        if (found == null) {
          return true;
        }
        return found.variableName != x.variableName;
      })
      .map((final x) => _DeprecatedBluetoothUUID.createFromUUID(x, services))
      .toList(growable: false);
  deprecatedServices.sort();

  final deprecatedCharacteristics = existingCharacteristics
      .where((final x) {
        final found = characteristics.cast<_BluetoothUUID?>().firstWhere(
          (final y) => y?.uuid16 == x.uuid16,
          orElse: () => null,
        );
        if (found == null) {
          return true;
        }
        return found.variableName != x.variableName;
      })
      .map(
        (final x) =>
            _DeprecatedBluetoothUUID.createFromUUID(x, characteristics),
      )
      .toList(growable: false);
  deprecatedCharacteristics.sort();

  final totalServices = [...services, ...deprecatedServices];
  final totalCharacteristics = [
    ...characteristics,
    ...deprecatedCharacteristics,
  ];
  totalServices.sort();
  totalCharacteristics.sort();

  final servicesEnumBuilder = EnumBuilder();
  servicesEnumBuilder
    ..name = "BluetoothDefaultServiceUUIDS"
    ..docs.addAll([
      "/// All the default Bluetooth low energy services are defined in this enum.",
      "/// See: [values] for a list of all the services.",
      "/// See: [services] for a list of all the non-deprecated services.",
      "/// ignore: deprecated_member_use_from_same_package",
      "/// See: [deprecatedServices] for a list of all old deprecated services.",
    ])
    ..values.addAll(
      totalServices.map(
        (final service) => EnumValue((final builder) {
          builder
            ..docs.add("/// The default service for ${service.name}")
            ..name = service.variableName
            ..arguments.addAll([
              literalStringDouble(service.name),
              literalStringDouble(service.uuid16),
              literalStringDouble(service.uuid),
              literalStringDouble(service.id),
            ]);

          if (service is _DeprecatedBluetoothUUID) {
            builder.annotations.add(
              refer(
                "Deprecated",
              ).call([literalStringDouble(service.deprecationMessage)]),
            );
          }
        }),
      ),
    )
    ..constructors.add(
      Constructor((final builder) {
        builder
          ..constant = true
          ..docs.addAll([
            "///",
            "/// A service UUID consists of a human readable name of the service,",
            "/// its uuid represented as a 16 bit uuid and a full 128 bit uuid,",
            "/// and the id assigned by the Bluetooth SIG",
            "///",
          ])
          ..requiredParameters.addAll([
            Parameter((final builder) {
              builder
                ..name = "name"
                ..toThis = true;
            }),
            Parameter((final builder) {
              builder
                ..name = "uuid16"
                ..toThis = true;
            }),
            Parameter((final builder) {
              builder
                ..name = "uuid"
                ..toThis = true;
            }),
            Parameter((final builder) {
              builder
                ..name = "id"
                ..toThis = true;
            }),
          ]);
      }),
    )
    ..fields.addAll([
      Field((final builder) {
        builder
          ..docs.add("/// The name of the service.")
          ..type = const Reference("String")
          ..name = "name"
          ..modifier = FieldModifier.final$;
      }),
      Field((final builder) {
        builder
          ..docs.add("/// The shorter 16 bit uuid of the service.")
          ..type = const Reference("String")
          ..name = "uuid16"
          ..modifier = FieldModifier.final$;
      }),
      Field((final builder) {
        builder
          ..docs.add("/// The full uuid of the service.")
          ..type = const Reference("String")
          ..name = "uuid"
          ..modifier = FieldModifier.final$;
      }),
      Field((final builder) {
        builder
          ..docs.add("/// The bluetooth ID of the service")
          ..type = const Reference("String")
          ..name = "id"
          ..modifier = FieldModifier.final$;
      }),
      Field((final builder) {
        builder
          ..docs.add("/// All non-deprecated services.")
          ..type = const Reference("List<BluetoothDefaultServiceUUIDS>")
          ..static = true
          ..name = "services"
          ..modifier = FieldModifier.constant
          ..assignment = Code(
            "[\n${services.map((final x) => x.variableName).join(",\n")}\n]",
          );
      }),
      Field((final builder) {
        builder
          ..docs.add("/// All deprecated characteristics.")
          ..type = const Reference("List<BluetoothDefaultServiceUUIDS>")
          ..static = true
          ..annotations.add(
            refer("Deprecated").call([
              literalStringDouble(
                "This contains all deprecated services and should thus not be relied on",
              ),
            ]),
          )
          ..name = "deprecatedServices"
          ..modifier = FieldModifier.constant
          ..assignment = Code(
            "[\n${deprecatedServices.map((final x) => x.variableName).join(",\n")}\n]",
          );
      }),
    ]);
  final servicesEnum = servicesEnumBuilder.build();

  final characteristicEnumBuilder = EnumBuilder();
  characteristicEnumBuilder
    ..name = "BluetoothDefaultCharacteristicUUIDS"
    ..docs.addAll([
      "/// All the default Bluetooth low energy characteristics are defined in this enum.",
      "/// See: [values] for a list of all the characteristics.",
      "/// See: [characteristics] for a list of all the non-deprecated characteristics.",
      "/// ignore: deprecated_member_use_from_same_package",
      "/// See: [deprecatedCharacteristics] for a list of all old deprecated characteristics.",
    ])
    ..values.addAll(
      totalCharacteristics.map(
        (final characteristic) => EnumValue((final builder) {
          builder
            ..docs.add(
              "/// The default characteristic for ${characteristic.name}",
            )
            ..name = characteristic.variableName
            ..arguments.addAll([
              literalStringDouble(characteristic.name),
              literalStringDouble(characteristic.uuid16),
              literalStringDouble(characteristic.uuid),
              literalStringDouble(characteristic.id),
            ]);

          if (characteristic is _DeprecatedBluetoothUUID) {
            builder.annotations.add(
              refer(
                "Deprecated",
              ).call([literalStringDouble(characteristic.deprecationMessage)]),
            );
          }
        }),
      ),
    )
    ..constructors.add(
      Constructor((final builder) {
        builder
          ..constant = true
          ..docs.addAll([
            "///",
            "/// A characteristic UUID consists of a human readable name of the characteristic,",
            "/// its uuid represented as a 16 bit uuid and a full 128 bit uuid,",
            "/// and the id assigned by the Bluetooth SIG",
            "///",
          ])
          ..requiredParameters.addAll([
            Parameter((final builder) {
              builder
                ..name = "name"
                ..toThis = true;
            }),
            Parameter((final builder) {
              builder
                ..name = "uuid16"
                ..toThis = true;
            }),
            Parameter((final builder) {
              builder
                ..name = "uuid"
                ..toThis = true;
            }),
            Parameter((final builder) {
              builder
                ..name = "id"
                ..toThis = true;
            }),
          ]);
      }),
    )
    ..fields.addAll([
      Field((final builder) {
        builder
          ..docs.add("/// The name of the characteristic.")
          ..type = const Reference("String")
          ..name = "name"
          ..modifier = FieldModifier.final$;
      }),
      Field((final builder) {
        builder
          ..docs.add("/// The shorter 16 bit uuid of the characteristic.")
          ..type = const Reference("String")
          ..name = "uuid16"
          ..modifier = FieldModifier.final$;
      }),
      Field((final builder) {
        builder
          ..docs.add("/// The full uuid of the characteristic.")
          ..type = const Reference("String")
          ..name = "uuid"
          ..modifier = FieldModifier.final$;
      }),
      Field((final builder) {
        builder
          ..docs.add("/// The bluetooth ID of the service")
          ..type = const Reference("String")
          ..name = "id"
          ..modifier = FieldModifier.final$;
      }),
      Field((final builder) {
        builder
          ..docs.add("/// All non-deprecated characteristics.")
          ..type = const Reference("List<BluetoothDefaultCharacteristicUUIDS>")
          ..static = true
          ..name = "characteristics"
          ..modifier = FieldModifier.constant
          ..assignment = Code(
            "[\n${characteristics.map((final x) => x.variableName).join(",\n")}\n]",
          );
      }),
      Field((final builder) {
        builder
          ..docs.add("/// All deprecated characteristics.")
          ..type = const Reference("List<BluetoothDefaultCharacteristicUUIDS>")
          ..static = true
          ..annotations.add(
            refer("Deprecated").call([
              literalStringDouble(
                "This contains all deprecated characteristics and should thus not be relied on",
              ),
            ]),
          )
          ..name = "deprecatedCharacteristics"
          ..modifier = FieldModifier.constant
          ..assignment = Code(
            "[\n${deprecatedCharacteristics.map((final x) => x.variableName).join(",\n")}\n]",
          );
      }),
    ]);
  final characteristicEnum = characteristicEnumBuilder.build();

  final libBuilder = LibraryBuilder();
  libBuilder.body.addAll([servicesEnum, characteristicEnum]);
  final buildLibrary = libBuilder.build();

  final emitter = DartEmitter(useNullSafetySyntax: true);
  final libraryCode =
      """// This file has been automatically generated by the script
// builder/builder.dart manufacturer-ids.
// The data is retrieved from the official repository.


// ignore: use_string_in_part_of_directives
part of flutter_web_bluetooth;

${buildLibrary.accept(emitter)}
""";

  final outFile = File(defaultUUIDSFile);
  await outFile.create();
  await outFile.writeAsString(
    DartFormatter(
      languageVersion: await getDartMinVersion(),
    ).format(libraryCode),
  );
  // await outFile.writeAsString(libraryCode);
  // ignore: avoid_print
  print("Done");
}

Future<List<_BluetoothUUID>> _getCurrentBluetoothUUIDS(
  final dynamic input,
) async {
  final yaml = await loadYamlResource(input);
  final uuids = yaml["uuids"] as YamlList;

  final parsedUUIDs = List.generate(uuids.length, (final index) {
    final uuid = uuids[index];
    final uuidInt = uuid["uuid"] as int;

    final name = uuid["name"] as String;
    final variableName = camelCaseName(name);
    final uuid16 = uuidInt.toRadixString(16).toLowerCase().padLeft(4, "0");
    final uuid128 =
        "${uuidInt.toRadixString(16).toLowerCase().padLeft(8, "0")}-0000-1000-8000-00805f9b34fb";
    final id = uuid["id"] as String;

    return _BluetoothUUID(
      variableName,
      replaceReadableName(name),
      uuid16,
      uuid128,
      id,
    );
  });

  return parsedUUIDs;
}

Future<(List<_BluetoothUUID>, List<_BluetoothUUID>)>
// ignore: non_constant_identifier_names
_getCurrentServiceAndCharacteristicUUIDs(final String UUIDsFile) async {
  final parsed = parseFile(
    path: UUIDsFile,
    featureSet: FeatureSet.latestLanguageVersion(),
  );
  final enums = parsed.unit.declarations.whereType<ast.EnumDeclaration>();

  final serviceEnum = enums.firstWhere(
    (final x) => x.name.toString() == "BluetoothDefaultServiceUUIDS",
  );
  final characteristicEnum = enums.firstWhere(
    (final x) => x.name.toString() == "BluetoothDefaultCharacteristicUUIDS",
  );

  final List<_BluetoothUUID> services = _parseExistingAstEnum(serviceEnum);
  final List<_BluetoothUUID> characteristics = _parseExistingAstEnum(
    characteristicEnum,
  );

  return (services, characteristics);
}

List<_BluetoothUUID> _parseExistingAstEnum(final ast.EnumDeclaration astEnum) {
  final List<_BluetoothUUID> output = [];

  for (final enumValue in astEnum.constants) {
    final enumName = enumValue.name.toString();
    final arguments = enumValue.arguments?.argumentList.arguments;

    final stringNameArgument = arguments?[0];
    final stringUUID16Argument = arguments?[1];
    final stringUUID128Argument = arguments?[2];
    final stringIdArgument = (arguments?.length ?? 0) > 3
        ? (arguments?[3])
        : null;

    if (stringNameArgument is! ast.SimpleStringLiteral) {
      throw Error();
    }
    if (stringUUID16Argument is! ast.SimpleStringLiteral) {
      throw Error();
    }
    if (stringUUID128Argument is! ast.SimpleStringLiteral) {
      throw Error();
    }
    if (stringIdArgument != null &&
        stringIdArgument is! ast.SimpleStringLiteral) {
      throw Error();
    }
    final stringName = stringNameArgument.stringValue;
    final stringUUID16 = stringUUID16Argument.stringValue;
    final stringUUID128 = stringUUID128Argument.stringValue;
    final stringId = stringIdArgument != null
        ? (stringIdArgument as ast.SimpleStringLiteral).stringValue
        : null;

    if (stringName == null || stringUUID16 == null || stringUUID128 == null) {
      throw Error();
    }

    output.add(
      _BluetoothUUID(
        enumName,
        stringName,
        stringUUID16,
        stringUUID128,
        stringId ?? "",
      ),
    );
  }

  return output;
}

class _BluetoothUUID implements Comparable<_BluetoothUUID> {
  final String variableName;
  final String name;
  final String uuid16;
  final String uuid;
  final String id;

  _BluetoothUUID(this.variableName, this.name, this.uuid16, this.uuid, this.id);

  @override
  int compareTo(final _BluetoothUUID other) {
    final thisUUID16 = int.parse(uuid16, radix: 16);
    final otherUUID16 = int.parse(other.uuid16, radix: 16);
    return thisUUID16 - otherUUID16;
  }
}

class _DeprecatedBluetoothUUID extends _BluetoothUUID {
  final String deprecationMessage;

  _DeprecatedBluetoothUUID(
    this.deprecationMessage,
    super.variableName,
    super.name,
    super.uuid16,
    super.uuid,
    super.id,
  );

  factory _DeprecatedBluetoothUUID.createFromUUID(
    final _BluetoothUUID deprecatedUUID,
    final List<_BluetoothUUID> existingUUIDs,
  ) {
    final (message, id) = _generateDeprecationMessage(
      deprecatedUUID,
      existingUUIDs,
    );
    return _DeprecatedBluetoothUUID(
      message,
      deprecatedUUID.variableName,
      deprecatedUUID.name,
      deprecatedUUID.uuid16,
      deprecatedUUID.uuid,
      id,
    );
  }
}

(String, String) _generateDeprecationMessage(
  final _BluetoothUUID deprecatedUUID,
  final List<_BluetoothUUID> existingUUIDs,
) {
  var id = deprecatedUUID.id;
  final found = existingUUIDs.cast<_BluetoothUUID?>().firstWhere(
    (final x) => x?.uuid16 == deprecatedUUID.uuid16,
    orElse: () => null,
  );
  if (found != null) {
    if (id == "") {
      id = found.id;
    }
    return ("UUID has been renamed; use ${found.variableName} instead", id);
  }
  return ("UUID no longer exists in the Bluetooth spec", id);
}
