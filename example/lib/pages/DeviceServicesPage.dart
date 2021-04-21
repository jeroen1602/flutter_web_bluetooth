import 'package:flutter/material.dart';
import 'package:flutter_web_bluetooth/flutter_web_bluetooth.dart';

class DeviceServicesPage extends StatefulWidget {
  DeviceServicesPage({Key? key, required this.bluetoothDevice})
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
            title: SelectableText(widget.bluetoothDevice.name ?? 'No name set'),
            actions: [
              Builder(
                builder: (BuildContext context) {
                  return ElevatedButton(
                    onPressed: () async {
                      if (!widget.bluetoothDevice.hasGATT) {
                        ScaffoldMessenger.maybeOf(context)
                            ?.showSnackBar(SnackBar(
                          content: Text('This device has no gatt'),
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
          body: Center(
            child: Text('Center!'),
          ),
        );
      },
    );
  }
}
