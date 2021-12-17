import 'package:flutter/material.dart';
import 'package:flutter_web_bluetooth/flutter_web_bluetooth.dart';
import 'package:flutter_web_bluetooth_example/widgets/service_widget.dart';

class DeviceServicesPage extends StatefulWidget {
  const DeviceServicesPage({Key? key, required this.bluetoothDevice})
      : super(key: key);

  final BluetoothDevice bluetoothDevice;

  @override
  State<StatefulWidget> createState() {
    return DeviceServicesState();
  }
}

class DeviceServicesState extends State<DeviceServicesPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: widget.bluetoothDevice.connected,
      initialData: false,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        final connected = snapshot.requireData;
        final theme = Theme.of(context);

        return Scaffold(
            appBar: AppBar(
              title:
                  SelectableText(widget.bluetoothDevice.name ?? 'No name set'),
              actions: [
                Builder(
                  builder: (BuildContext context) {
                    return ElevatedButton(
                      onPressed: () async {
                        if (!widget.bluetoothDevice.hasGATT) {
                          ScaffoldMessenger.maybeOf(context)
                              ?.showSnackBar(SnackBar(
                            content: const Text('This device has no gatt'),
                            backgroundColor: theme.errorColor,
                          ));
                          return;
                        }
                        if (connected) {
                          widget.bluetoothDevice.disconnect();
                        } else {
                          await widget.bluetoothDevice.connect();
                        }
                      },
                      child: Text(connected ? 'Disconnect' : 'Connect'),
                    );
                  },
                ),
              ],
            ),
            body: Builder(builder: (BuildContext context) {
              if (connected) {
                return StreamBuilder<List<BluetoothService>>(
                  stream: widget.bluetoothDevice.services,
                  initialData: const [],
                  builder: (BuildContext context,
                      AsyncSnapshot<List<BluetoothService>> serviceSnapshot) {
                    if (serviceSnapshot.hasError) {
                      final error = serviceSnapshot.error.toString();
                      debugPrint('Error!: $error');
                      return Center(
                        child: Text(error),
                      );
                    }
                    final services = serviceSnapshot.requireData;
                    if (services.isEmpty) {
                      return const Center(
                        child: Text('No services found!'),
                      );
                    }

                    final serviceWidgets = List.generate(services.length,
                        (index) => ServiceWidget(service: services[index]));

                    return ListView(
                      children: serviceWidgets,
                    );
                  },
                );
              } else {
                return const Center(
                  child: Text('Click connect first'),
                );
              }
            }));
      },
    );
  }
}
