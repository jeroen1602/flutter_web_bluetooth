import "dart:math";

import "package:flutter/material.dart";
import "package:flutter_web_bluetooth/flutter_web_bluetooth.dart";
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
  @override
  Widget build(final BuildContext context) {
    const appbarHeight = 56.0;
    final height = max(
        0.0, (MediaQuery.maybeOf(context)?.size.height ?? 0.0) - appbarHeight);
    final itemHeight = height / 2.0;

    return Scaffold(
        appBar: AppBar(
          title: SelectableText(widget.bluetoothDevice.name ?? "No name set"),
        ),
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                    constraints: BoxConstraints(minHeight: itemHeight),
                    child: BluetoothAdvertisementsWidget(
                        widget.bluetoothDevice, itemHeight)),
                Container(
                    constraints: BoxConstraints(minHeight: itemHeight),
                    child: BluetoothServicesWidget(
                        widget.bluetoothDevice, itemHeight))
              ],
            )));
  }
}
