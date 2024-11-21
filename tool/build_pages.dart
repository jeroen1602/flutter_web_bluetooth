#!/bin/env dart
// ignore_for_file: avoid_print

import "dart:convert";
import "dart:io";

import "package:path/path.dart";
import "package:yaml/yaml.dart";

Future<int> main() async {
  final exampleDir =
      canonicalize(join(dirname(Platform.script.toFilePath()), "../example"));

  print("building project");
  final process = await Process.start(
      "flutter",
      [
        "build",
        "web",
        "--base-href",
        "/flutter_web_bluetooth/",
        "--release",
        "--source-maps",
        "--dart-define=redirectToHttps=true",
      ],
      workingDirectory: exampleDir);
  await Future.wait([
    process.stdout.forEach((final element) {
      stdout.write(utf8.decode(element));
    }),
    process.stderr.forEach((final element) {
      stderr.write(utf8.decode(element));
    }),
  ]);
  final exitCode = await process.exitCode;
  if (exitCode != 0) {
    return exitCode;
  }

  final buildFolder = join(exampleDir, "build/web");

  print("Updating service working");
  final serviceWorkerPath = join(buildFolder, "flutter_service_worker.js");
  final serviceWorkerFile = File(serviceWorkerPath);
  final serviceWorker = await serviceWorkerFile.readAsString();
  await serviceWorkerFile.writeAsString(
      serviceWorker.replaceFirst(
          RegExp("\"/\":"), "\"/flutter_web_bluetooth/\":"),
      flush: true);

  print("Updating provided pubspec");
  final pubspecFilePath = join(buildFolder, "assets/pubspec.lock");
  final pubspecFile = File(pubspecFilePath);
  final pubspecContent = await pubspecFile.readAsString();

  final parsed = loadYaml(pubspecContent);
  final packages = parsed["packages"];
  if (packages == null) {
    throw ArgumentError();
  }
  final library = packages["flutter_web_bluetooth"];
  if (library == null) {
    throw ArgumentError();
  }
  final version = library["version"]?.toString();
  if (version == null) {
    throw ArgumentError("Version was not set");
  }

  final flutterAndDartVersion = await getFlutterAndDartVersion();

  final newPubspecContent = """
packages:
  flutter_web_bluetooth:
    version: "$version"
  flutter:
    version: "${flutterAndDartVersion.flutter}"
  dart:
    version: "${flutterAndDartVersion.dart}"
""";

  await pubspecFile.writeAsString(newPubspecContent);

  return 0;
}

Future<({String flutter, String dart})> getFlutterAndDartVersion() async {
  final process =
      await Process.start("flutter", ["--version"], workingDirectory: "/");
  final exitCode = await process.exitCode;
  if (exitCode != 0) {
    exit(exitCode);
  }

  final text = await utf8.decodeStream(process.stdout);

  final flutterRegex = RegExp(r"Flutter (\d+\.\d+\.\d+)");
  final flutterMatch = flutterRegex.firstMatch(text);

  final flutterVersion = flutterMatch?.group(1) ?? "unknown";

  final dartRegex = RegExp(r"Dart (\d+\.\d+\.\d+)");
  final dartMatch = dartRegex.firstMatch(text);

  final dartVersion = dartMatch?.group(1) ?? "unknown";

  return (flutter: flutterVersion, dart: dartVersion);
}
