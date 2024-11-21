#!/bin/env dart
// ignore_for_file: avoid_print

import "dart:convert";
import "dart:io";

import "package:path/path.dart";
import "package:yaml/yaml.dart";

Future<int> main() async {
  final exampleDir =
      canonicalize(join(dirname(Platform.script.toFilePath()), "../example"));
  final buildFolder = join(exampleDir, "build/web");

  final PathInformation pathInformation = (
    mainLib: canonicalize(join(dirname(Platform.script.toFilePath()), "../")),
    exampleProject: exampleDir,
    buildFolder: buildFolder,
    dartSdk: canonicalize(join(Platform.resolvedExecutable, "../../")),
    flutterWebSdk: canonicalize(
        join(Platform.resolvedExecutable, "../../../flutter_web_sdk")),
    pubCache: getPubCacheFolder(),
    flutterSdk: await getFlutterSdk(),
  );

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
      workingDirectory: pathInformation.exampleProject);
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

  print("Updating service worker");
  final serviceWorkerPath =
      join(pathInformation.buildFolder, "flutter_service_worker.js");
  final serviceWorkerFile = File(serviceWorkerPath);
  final serviceWorker = await serviceWorkerFile.readAsString();
  await serviceWorkerFile.writeAsString(
      serviceWorker.replaceFirst(
          RegExp("\"/\":"), "\"/flutter_web_bluetooth/\":"),
      flush: true);

  print("Updating provided pubspec");
  final pubspecFilePath =
      join(pathInformation.buildFolder, "assets/pubspec.lock");
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

  print("Updating source maps");
  await handleSourceMaps(pathInformation);

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

Future<void> handleSourceMaps(final PathInformation pathInformation) async {
  final dir = Directory(pathInformation.buildFolder);
  final mapFiles = await dir.list().where((final entry) {
    if (entry.path.endsWith(".map")) {
      return true;
    }
    return false;
  }).toList();

  await Future.wait(mapFiles.map((final fileEntry) {
    final mapFile = File(fileEntry.path);
    return handleSingleSourceMap(mapFile, pathInformation);
  }));
}

Future<void> handleSingleSourceMap(
    final File mapFile, final PathInformation pathInformation) async {
  final data = await mapFile.readAsString();

  final parsedData = jsonDecode(data);

  final sources = parsedData["sources"] as List<dynamic>;

  final sourcesParsed = sources
      .whereType<String>()
      .map(Uri.parse)
      .map((final x) {
        if (x.scheme == "org-dartlang-sdk") {
          var path = x.path;
          if (path.startsWith("/")) {
            path = path.substring(1);
          }
          if (path.startsWith("dart-sdk")) {
            path = canonicalize(join(pathInformation.dartSdk, "../", path));
          } else {
            path = canonicalize(join(pathInformation.flutterWebSdk, path));
          }
          final fileExists = File(path).existsSync();
          if (fileExists) {
            return Uri.parse(path);
          } else {
            print("Could not find $path original: $x");
          }
        } else {
          final path = x.path;
          final String joined;
          if (path == "web_plugin_registrant.dart") {
            joined = canonicalize(join(
                pathInformation.exampleProject, ".dart_tool", "dartpad", path));
          } else if (path == "main.dart") {
            joined =
                canonicalize(join(pathInformation.exampleProject, "lib", path));
          } else {
            joined = canonicalize(
                join(pathInformation.buildFolder, "canvaskit", path));
          }
          final fileExists = File(joined).existsSync();
          if (fileExists) {
            return Uri.parse(joined);
          } else {
            print("Could not find $joined original: $path");
          }
        }

        return x;
      })
      .where((final x) => x.scheme == "")
      .toList(growable: false);

  final updatedSources =
      sourcesParsed.map((final x) => x.toString()).map((final path) {
    if (path.startsWith(pathInformation.dartSdk)) {
      return "dart-sdk://${path.substring(pathInformation.dartSdk.length)}";
    } else if (path.startsWith(pathInformation.flutterWebSdk)) {
      return "flutter-web-sdk://${path.substring(pathInformation.flutterWebSdk.length)}";
    } else if (path.startsWith(pathInformation.pubCache)) {
      return "packages/${convertPackageSource(path.substring(pathInformation.pubCache.length + 1))}";
    } else if (path.startsWith(pathInformation.flutterSdk)) {
      return "flutter-sdk://${path.substring(pathInformation.flutterSdk.length)}";
    } else if (path.startsWith(pathInformation.exampleProject)) {
      return "packages/flutter_web_bluetooth_example${path.substring(pathInformation.exampleProject.length)}";
    } else if (path.startsWith(pathInformation.mainLib)) {
      return "packages/flutter_web_bluetooth${path.substring(pathInformation.mainLib.length)}";
    }
    print("dunno: $path");
    return path;
  }).toList(growable: false);

  final sourceContent = await Future.wait(sourcesParsed.map((final x) async {
    try {
      return await File(x.toString()).readAsString();
    } catch (_) {
      print("Could not read $x");
      return "";
    }
  }));

  parsedData["sourcesContent"] = sourceContent;
  parsedData["sources"] = updatedSources;

  final output = mapFile.absolute;
  if (await output.exists()) {
    await output.delete();
  }
  await output.create();
  await output.writeAsString(jsonEncode(parsedData));
  print("Writen sourcemap file ${output.path}");
}

typedef PathInformation = ({
  String mainLib,
  String exampleProject,
  String buildFolder,
  String dartSdk,
  String flutterWebSdk,
  String pubCache,
  String flutterSdk,
});

// region HELPERS

String getPubCacheFolder() {
  final pubCacheEnv = Platform.environment["PUB_CACHE"];
  if (pubCacheEnv != null) {
    return absolute(canonicalize(pubCacheEnv));
  }
  if (Platform.isLinux || Platform.isMacOS) {
    return absolute(
        canonicalize(join(Platform.environment["HOME"] ?? "/", ".pub-cache")));
  } else if (Platform.isWindows) {
    return absolute(canonicalize(join("%LOCALAPPDATA%", "Pub", "Cache")));
  } else {
    throw UnsupportedError("Platform is not supported");
  }
}

Future<String> getFlutterSdk() async {
  final result = await Process.run(
      Platform.isWindows ? "where" : "which", ["flutter"],
      runInShell: true,
      workingDirectory: "/",
      stdoutEncoding: Encoding.getByName("UTF-8"));

  if (result.exitCode != 0) {
    throw ArgumentError("Could not find flutter executable path");
  }
  var flutterBin = (result.stdout as String).trim();

  try {
    final file = File(flutterBin);
    flutterBin = await file.resolveSymbolicLinks();
  } on Error {
    // nothing
  }

  return absolute(canonicalize(join(flutterBin, "../../")));
}

String convertPackageSource(final String packageSource) {
  final parts = split(packageSource);
  if (parts[0] != "hosted") {
    throw UnsupportedError("Not a hosted package $packageSource");
  }

  final regex = RegExp(r"^(.+)-\d+\.\d+\.\d+$");

  final package = regex.firstMatch(parts[2])?.group(1) ?? parts[2];
  return joinAll([package, ...parts.skip(3)]);
}

// endregion
