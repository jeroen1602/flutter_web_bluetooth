import "package:flutter/material.dart";
import "package:flutter_web_bluetooth/flutter_web_bluetooth.dart";
import "package:flutter_web_bluetooth_example/model/main_page_device.dart";

class BluetoothDeviceWidget<D extends AdvertisementBluetoothDevice>
    extends StatefulWidget {
  final MainPageDevice<D> bluetoothDevice;
  final VoidCallback? onTap;
  final bool _canConnect;
  final bool _hasRSSI;
  final bool _hasTxPower;
  final bool _hasAppearance;

  BluetoothDeviceWidget({
    required this.bluetoothDevice,
    super.key,
    this.onTap,
  })  : _canConnect = bluetoothDevice.device is BluetoothDevice,
        _hasRSSI = bluetoothDevice.rssi != null,
        _hasTxPower = bluetoothDevice.txPower != null,
        _hasAppearance = bluetoothDevice.appearance != null;

  @override
  State<StatefulWidget> createState() {
    return BluetoothDeviceState<D>();
  }
}

class BluetoothDeviceState<D extends AdvertisementBluetoothDevice>
    extends State<BluetoothDeviceWidget<D>> {
  Stream<bool>? _connectedStream;

  @override
  void initState() {
    super.initState();
    if (widget._canConnect) {
      _connectedStream =
          (widget.bluetoothDevice.device as BluetoothDevice).connected;
    }
  }

  @override
  Widget build(final BuildContext context) {
    final cursive = Theme.of(context)
        .textTheme
        .bodyLarge
        ?.copyWith(fontStyle: FontStyle.italic);

    final IconData actionIcon;
    if (widget._canConnect) {
      actionIcon = Icons.arrow_forward_ios;
    } else {
      actionIcon = Icons.add;
    }

    return Column(
      children: [
        ListTile(
          onTap: widget.onTap,
          title: Row(
            children: [
              if (widget._canConnect)
                StreamBuilder(
                    stream: _connectedStream,
                    initialData: false,
                    builder: (final BuildContext context,
                        final AsyncSnapshot<bool> snapshot) {
                      return Icon(Icons.circle,
                          color:
                              snapshot.requireData ? Colors.green : Colors.red);
                    }),
              SelectableText(widget.bluetoothDevice.device.name ?? "null",
                  style: widget.bluetoothDevice.device.name == null
                      ? cursive
                      : null),
            ],
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(children: [
                SelectableText(widget.bluetoothDevice.device.id),
              ]),
              if (widget._hasTxPower)
                Row(
                  children: [
                    const Text("TxPower: "),
                    SelectableText(
                        widget.bluetoothDevice.txPower!.toRadixString(10)),
                  ],
                ),
              if (widget._hasRSSI)
                Row(
                  children: [
                    const Text("RSSI: "),
                    SelectableText(
                        widget.bluetoothDevice.rssi!.toRadixString(10)),
                  ],
                ),
              if (widget._hasAppearance)
                Row(children: [
                  const Text("Appearance: "),
                  SelectableText(
                      '0x${widget.bluetoothDevice.appearance!.toRadixString(16).padLeft(4, '0')}'),
                ]),
            ],
          ),
          trailing: widget.onTap != null ? Icon(actionIcon) : null,
        ),
        const Divider(),
      ],
    );
  }
}
