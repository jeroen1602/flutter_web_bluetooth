import "dart:async";

import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:package_info_plus/package_info_plus.dart";
import "package:yaml/yaml.dart";

class InfoDialog extends StatefulWidget {
  const InfoDialog({super.key});

  @override
  State<StatefulWidget> createState() {
    return _InfoDialogState();
  }

  static Future<void> showInfoDialog(final BuildContext context) async {
    await showDialog(
        context: context,
        builder: (final BuildContext dialogContext) {
          return const InfoDialog();
        });
  }
}

class _InfoDialogState extends State<InfoDialog> {
  Future<({String flutterVersion, String dartVersion, String libVersion})>?
      _pubspecVersions;
  Future<String>? _appVersion;

  @override
  void initState() {
    super.initState();

    // ignore: discarded_futures
    _pubspecVersions = _getPubspecVersions();
    // ignore: discarded_futures
    _appVersion = _getExampleAppVersion();
  }

  @override
  Widget build(final BuildContext context) {
    return AlertDialog(
      title: const Text("Flutter web bluetooth"),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            FutureBuilder<String>(
                future: _appVersion,
                builder: (final BuildContext context,
                    final AsyncSnapshot<String> snapshot) {
                  return Text(
                      "Example app version: ${snapshot.data ?? "loading"}");
                }),
            FutureBuilder<
                    ({
                      String flutterVersion,
                      String dartVersion,
                      String libVersion
                    })>(
                future: _pubspecVersions,
                builder: (final BuildContext context,
                    final AsyncSnapshot<
                            ({
                              String flutterVersion,
                              String dartVersion,
                              String libVersion
                            })>
                        snapshot) {
                  return Column(
                    children: [
                      Text(
                          "Using library version: ${snapshot.data?.libVersion ?? "Loading"}"),
                      Text(
                          "Using Flutter version: ${snapshot.data?.flutterVersion ?? "Loading"}"),
                      Text(
                          "Using Dart version: ${snapshot.data?.dartVersion ?? "Loading"}"),
                    ],
                  );
                }),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              showLicensePage(
                  context: context,
                  applicationName: "Flutter web bluetooth example");
            },
            child: const Text("Licenses")),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Close"),
        )
      ],
    );
  }

  Future<dynamic> _getPubspecPackages() async {
    final data = await rootBundle.loadString("pubspec.lock");

    try {
      final parsed = loadYaml(data);
      final packages = parsed["packages"];
      if (packages == null) {
        throw ArgumentError();
      }
      return packages;
    } on YamlException {
      return null;
    } on ArgumentError {
      return null;
    }
  }

  String _getPackageVersion(final dynamic packages, final String packageName) {
    if (packages == null) {
      return "Could not be loaded";
    }
    try {
      final library = packages[packageName];
      if (library == null) {
        throw ArgumentError();
      }
      final version = library["version"];
      if (version == null) {
        throw ArgumentError();
      }
      return version.toString();
    } on ArgumentError {
      return "Could not be loaded";
    }
  }

  Future<({String flutterVersion, String dartVersion, String libVersion})>
      _getPubspecVersions() async {
    final packages = await _getPubspecPackages();

    final libVersion = _getPackageVersion(packages, "flutter_web_bluetooth");
    final flutterVersion = _getPackageVersion(packages, "flutter");
    final dartVersion = _getPackageVersion(packages, "dart");

    return (
      flutterVersion: flutterVersion,
      dartVersion: dartVersion,
      libVersion: libVersion
    );
  }

  Future<String> _getLibraryVersion(final dynamic packages) async {
    final data = await rootBundle.loadString("pubspec.lock");

    try {
      final library = packages["flutter_web_bluetooth"];
      if (library == null) {
        throw ArgumentError();
      }
      final version = library["version"];
      if (version == null) {
        throw ArgumentError();
      }
      return version.toString();
    } on YamlException {
      return "Could not be loaded";
    } on ArgumentError {
      return "Could not be loaded";
    }
  }

  Future<String> _getExampleAppVersion() async {
    final info = await PackageInfo.fromPlatform();

    return info.version;
  }
}
