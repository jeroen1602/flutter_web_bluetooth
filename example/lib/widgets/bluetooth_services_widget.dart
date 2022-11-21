import 'package:flutter/material.dart';
import 'package:flutter_web_bluetooth/flutter_web_bluetooth.dart';
import 'package:flutter_web_bluetooth_example/widgets/service_widget.dart';

class BluetoothServicesWidget extends StatefulWidget {
  const BluetoothServicesWidget(this.device, this.minHeight, {super.key});

  final BluetoothDevice device;
  final double minHeight;
  static const appbarHeight = 56.0;

  @override
  State<StatefulWidget> createState() {
    return _BluetoothServicesState();
  }
}

class _BluetoothServicesState extends State<BluetoothServicesWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.device.connected,
      builder: (context, connectedSnapshot) {
        final connected = connectedSnapshot.data ?? false;

        return Column(children: [
          AppBar(
              automaticallyImplyLeading: false,
              title: const Text('Services'),
              actions: [
                ElevatedButton(
                    onPressed: () async {
                      if (connected) {
                        widget.device.disconnect();
                      } else {
                        await widget.device.connect();
                      }
                    },
                    child: Text(connected ? 'Disconnect' : 'Connect'))
              ]),
          Container(
              constraints: BoxConstraints(
                  minHeight:
                      widget.minHeight - BluetoothServicesWidget.appbarHeight),
              child: BluetoothServiceBody(connected, widget.device))
        ]);
      },
    );
  }
}

class BluetoothServiceBody extends StatelessWidget {
  const BluetoothServiceBody(this.isConnected, this.device, {super.key});

  final BluetoothDevice device;
  final bool isConnected;

  @override
  Widget build(BuildContext context) {
    if (isConnected) {
      return BluetoothServicesOverview(device);
    } else {
      return const Center(child: Text('Click connect first'));
    }
  }
}

class BluetoothServicesOverview extends StatelessWidget {
  const BluetoothServicesOverview(this.device, {super.key});

  final BluetoothDevice device;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: device.services,
      builder: (context, servicesSnapshot) {
        if (servicesSnapshot.hasError) {
          final error = servicesSnapshot.error.toString();
          debugPrint('Error: $error');
          return Center(child: Text(error));
        }
        final services = servicesSnapshot.data;
        if (services == null) {
          return const Center(
            child: Text('Loading services!'),
          );
        }
        if (services.isEmpty) {
          return const Center(
            child: Text('No services found!'),
          );
        }

        final serviceWidgets = List.generate(services.length,
            (index) => ServiceWidget(service: services[index]));

        return Column(
          children: serviceWidgets,
        );
      },
    );
  }
}
