import 'package:flutter/material.dart';
import 'package:flutter_web_bluetooth/flutter_web_bluetooth.dart';

class BluetoothDeviceWidget extends StatelessWidget {
  final BluetoothDevice bluetoothDevice;
  final VoidCallback? onTap;

  const BluetoothDeviceWidget({
    Key? key,
    required this.bluetoothDevice,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cursive = Theme.of(context)
        .textTheme
        .bodyLarge
        ?.copyWith(fontStyle: FontStyle.italic);

    return Column(
      children: [
        ListTile(
          onTap: onTap,
          title: Row(
            children: [
              StreamBuilder(
                  stream: bluetoothDevice.connected,
                  initialData: false,
                  builder:
                      (BuildContext context, AsyncSnapshot<bool> snapshot) {
                    return Icon(Icons.circle,
                        color:
                            snapshot.requireData ? Colors.green : Colors.red);
                  }),
              SelectableText(bluetoothDevice.name ?? 'null',
                  style: bluetoothDevice.name == null ? cursive : null),
            ],
          ),
          subtitle: SelectableText(bluetoothDevice.id),
          trailing: onTap != null ? const Icon(Icons.arrow_forward_ios) : null,
        ),
        const Divider(),
      ],
    );
  }
}
