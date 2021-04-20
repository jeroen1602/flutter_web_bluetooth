import 'package:flutter/material.dart';
import 'package:flutter_web_bluetooth/flutter_web_bluetooth.dart';

class BluetoothDeviceWidget extends StatelessWidget {
  final WebBluetoothDevice bluetoothDevice;
  final VoidCallback? onTap;

  BluetoothDeviceWidget({
    Key? key,
    required this.bluetoothDevice,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cursive = Theme.of(context)
        .textTheme
        .bodyText1
        ?.copyWith(fontStyle: FontStyle.italic);

    return Column(
      children: [
        Container(
            child: ListTile(
          onTap: this.onTap,
          title: SelectableText(this.bluetoothDevice.name ?? 'null',
              style: this.bluetoothDevice.name == null ? cursive : null),
          subtitle: SelectableText(this.bluetoothDevice.id),
          trailing: this.onTap != null ? Icon(Icons.arrow_forward_ios) : null,
        )),
        Divider(),
      ],
    );
  }
}
