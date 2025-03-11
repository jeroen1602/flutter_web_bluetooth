import "dart:math";

import "package:flutter/material.dart";
import "package:flutter_web_bluetooth/flutter_web_bluetooth.dart";
import "package:flutter_web_bluetooth/js_web_bluetooth.dart";
import "package:flutter_web_bluetooth_example/widgets/bluetooth_advertisements_widget.dart";
import "package:flutter_web_bluetooth_example/widgets/bluetooth_services_widget.dart";

class DeviceServicesPage extends StatefulWidget {
  const DeviceServicesPage({required this.bluetoothDevice, super.key});

  final BluetoothDevice bluetoothDevice;

  @override
  State<StatefulWidget> createState() {
    return DeviceServicesState();
  }
}

class DeviceServicesState extends State<DeviceServicesPage> {
  Color? _getErrorColor() {
    if (!mounted) {
      return null;
    }
    final theme = Theme.of(context);
    return theme.colorScheme.error;
  }

  @override
  Widget build(final BuildContext context) {
    const appbarHeight = 56.0;
    final height = max(
      0.0,
      (MediaQuery.maybeOf(context)?.size.height ?? 0.0) - appbarHeight,
    );
    final itemHeight = height / 2.0;

    return Scaffold(
      appBar: AppBar(
        title: SelectableText(widget.bluetoothDevice.name ?? "No name set"),
        actions: [
          ElevatedButton(
            onPressed: () async {
              late String message;
              try {
                await widget.bluetoothDevice.forget();
                debugPrint(
                  "Forgot device: ${widget.bluetoothDevice.name}, ${widget.bluetoothDevice.id}",
                );
                message = "";
              } on NativeAPINotImplementedError {
                message = "Forget is not implemented in this browser";
              } catch (e, s) {
                debugPrint("$e\n$s");
                message = "Unknown error: $e";
              }

              if (context.mounted) {
                if (message.isNotEmpty) {
                  ScaffoldMessenger.maybeOf(context)?.showSnackBar(
                    SnackBar(
                      content: Text(message),
                      backgroundColor: _getErrorColor(),
                    ),
                  );
                } else {
                  Navigator.pop(context);
                }
              }
            },
            child: const Text("Forget"),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              constraints: BoxConstraints(minHeight: itemHeight),
              child: BluetoothAdvertisementsWidget(
                widget.bluetoothDevice,
                itemHeight,
              ),
            ),
            Container(
              constraints: BoxConstraints(minHeight: itemHeight),
              child: BluetoothServicesWidget(
                widget.bluetoothDevice,
                itemHeight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
