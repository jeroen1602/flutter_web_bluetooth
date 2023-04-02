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
  Future<String>? _libraryVersion;
  Future<String>? _appVersion;

  @override
  void initState() {
    super.initState();

    // ignore: discarded_futures
    _libraryVersion = _getLibraryVersion();
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
            FutureBuilder<String>(
                future: _libraryVersion,
                builder: (final BuildContext context,
                    final AsyncSnapshot<String> snapshot) {
                  return Text(
                      "Using library version: ${snapshot.data ?? "Loading"}");
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

  Future<String> _getLibraryVersion() async {
    final data = await rootBundle.loadString("pubspec.lock");

    try {
      final parsed = loadYaml(data);
      final packages = parsed["packages"];
      if (packages == null) {
        throw ArgumentError();
      }
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
