import "package:flutter/material.dart";
import "package:flutter_web_bluetooth/flutter_web_bluetooth.dart";
import "package:rxdart/rxdart.dart";

class BluetoothAdvertisementsWidget extends StatefulWidget {
  BluetoothAdvertisementsWidget(this.device, this.minHeight, {super.key})
      : updateAdvertisingStream =
            BehaviorSubject.seeded(device.watchingAdvertisements);

  final BluetoothDevice device;
  final double minHeight;
  static const appbarHeight = 56.0;

  @override
  State<StatefulWidget> createState() {
    return _BluetoothAdvertisementsState();
  }

  final BehaviorSubject<bool> updateAdvertisingStream;

  Stream<bool> _isWatchingAdvertisements() {
    return MergeStream<bool>([
      Stream<bool>.value(device.watchingAdvertisements),
      Stream.periodic(const Duration(seconds: 2)).map((final event) {
        return device.watchingAdvertisements;
      }),
      updateAdvertisingStream.stream
    ]).distinct();
  }
}

class _BluetoothAdvertisementsState
    extends State<BluetoothAdvertisementsWidget> {
  Future<void> advertisingPressed() async {
    final theme = Theme.of(context);
    final errorColor = theme.colorScheme.error;
    if (!widget.device.hasWatchAdvertisements()) {
      ScaffoldMessenger.maybeOf(context)?.showSnackBar(SnackBar(
        content:
            const Text("Advertisements are not supported for this browser"),
        backgroundColor: errorColor,
      ));
    } else {
      if (widget.device.watchingAdvertisements) {
        await widget.device.unwatchAdvertisements();
      } else {
        await widget.device.watchAdvertisements();
      }
      widget.updateAdvertisingStream.add(widget.device.watchingAdvertisements);
    }
  }

  Stream<bool>? _isWatchingAdvertisements;

  @override
  void initState() {
    super.initState();
    _isWatchingAdvertisements = widget._isWatchingAdvertisements();
  }

  @override
  Widget build(final BuildContext context) {
    return StreamBuilder(
      initialData: widget.device.watchingAdvertisements,
      stream: _isWatchingAdvertisements,
      builder: (final context, final snapshot) {
        final isWatching = snapshot.data ?? false;

        return Column(
          children: [
            AppBar(
                automaticallyImplyLeading: false,
                title: const Text("Advertisements"),
                actions: [
                  ElevatedButton(
                      onPressed: advertisingPressed,
                      child:
                          Text(isWatching ? "Stop watching" : "Start watching"))
                ]),
            Container(
                constraints: BoxConstraints(
                    minHeight: widget.minHeight -
                        BluetoothAdvertisementsWidget.appbarHeight),
                child: BluetoothAdvertisementsBody(widget.device,
                    isWatching: isWatching)),
          ],
        );
      },
    );
  }
}

class BluetoothAdvertisementsBody extends StatefulWidget {
  const BluetoothAdvertisementsBody(
    this.device, {
    required this.isWatching,
    super.key,
  });

  final bool isWatching;
  final BluetoothDevice device;

  @override
  State<StatefulWidget> createState() {
    return BluetoothAdvertisementsBodySate();
  }
}

class BluetoothAdvertisementsBodySate
    extends State<BluetoothAdvertisementsBody> {
  Stream<AdvertisementReceivedEvent>? _advertisements;

  @override
  void initState() {
    super.initState();
    if (widget.device.hasWatchAdvertisements()) {
      _advertisements = widget.device.advertisements;
    }
  }

  @override
  Widget build(final BuildContext context) {
    if (widget.device.hasWatchAdvertisements()) {
      return StreamBuilder(
        stream: _advertisements,
        initialData: null,
        builder: (final context, final snapshot) {
          final event = snapshot.data;
          if (event == null) {
            return const Center(
              child: Text("First click on start watching!"),
            );
          }
          return BluetoothAdvertisementsCard(event);
        },
      );
    } else {
      return const BluetoothAdvertisementsNotSupported();
    }
  }
}

class BluetoothAdvertisementsNotSupported extends StatelessWidget {
  const BluetoothAdvertisementsNotSupported({super.key});

  @override
  Widget build(final BuildContext context) {
    return const Expanded(
      child: Center(
        child: Card(
          child: ListTile(
            title: SelectableText(
                "Bluetooth advertisements are not supported on this browser"),
            subtitle: SelectableText(
                "Enable the chrome://flags/#enable-experimental-web-platform-features flag to enable support."),
          ),
        ),
      ),
    );
  }
}

class BluetoothAdvertisementsCard extends StatefulWidget {
  const BluetoothAdvertisementsCard(this.event, {super.key});

  final AdvertisementReceivedEvent event;

  @override
  State<StatefulWidget> createState() {
    return BluetoothAdvertisementsCardState();
  }
}

class BluetoothAdvertisementsCardState
    extends State<BluetoothAdvertisementsCard> {
  final List<bool> _openPanels = List.generate(3, (final index) => false);

  void _expansionCallback(final int index, final bool isExpanded) {
    setState(() {
      _openPanels[index] = isExpanded;
    });
  }

  @override
  Widget build(final BuildContext context) {
    return Card(
      child: Column(
        children: [
          Row(
            children: [
              SelectableText(widget.event.name ?? "not set"),
              const VerticalDivider(),
              Text(DateTime.now().toIso8601String()),
            ],
          ),
          const Divider(),
          Row(
            children: [
              const Text("tx power"),
              const VerticalDivider(),
              SelectableText(widget.event.txPower?.toString() ?? "not set"),
              const VerticalDivider(),
              const Text("RSSI"),
              const VerticalDivider(),
              SelectableText(widget.event.rssi?.toString() ?? "not set")
            ],
          ),
          const Divider(),
          Row(
            children: [
              const Text("Appearance"),
              const VerticalDivider(),
              SelectableText(
                  '0x${widget.event.appearance?.toRadixString(16).padLeft(4, '0') ?? 'not set'}')
            ],
          ),
          const Divider(),
          ExpansionPanelList(
            expansionCallback: _expansionCallback,
            children: [
              ExpansionPanel(
                  headerBuilder:
                      (final BuildContext context, final bool isExpanded) {
                    return ListTile(
                      title: const Text("UUIDS"),
                      subtitle: Text("Size: ${widget.event.uuids.length}"),
                    );
                  },
                  body: Column(
                    children: widget.event.uuids
                        .map((final e) => ListTile(
                              title: Text(e),
                            ))
                        .toList(),
                  ),
                  isExpanded: _openPanels[0]),
              ExpansionPanel(
                  headerBuilder:
                      (final BuildContext context, final bool isExpanded) {
                    return ListTile(
                      title: const Text("Service data"),
                      subtitle:
                          Text("Size: ${widget.event.serviceData.length}"),
                    );
                  },
                  body: Column(
                    children: widget.event.serviceData.entries.map((final e) {
                      return ListTile(
                          title: Text(e.key),
                          subtitle: Text(e.value.toString()));
                    }).toList(),
                  ),
                  isExpanded: _openPanels[1]),
              ExpansionPanel(
                  headerBuilder:
                      (final BuildContext context, final bool isExpanded) {
                    return ListTile(
                      title: const Text("Manufacturer data"),
                      subtitle:
                          Text("Size: ${widget.event.manufacturerData.length}"),
                    );
                  },
                  body: Column(
                    children:
                        widget.event.manufacturerData.entries.map((final e) {
                      return ListTile(
                          title: Text("0x${e.key.toRadixString(16)}"),
                          subtitle: Text(e.value.toString()));
                    }).toList(),
                  ),
                  isExpanded: _openPanels[2])
            ],
          )
        ],
      ),
    );
  }
}
