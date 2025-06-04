import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_web_bluetooth/flutter_web_bluetooth.dart";
import "package:flutter_web_bluetooth_example/business/bluetooth_business.dart";
import "package:flutter_web_bluetooth_example/model/main_page_device.dart";
import "package:flutter_web_bluetooth_example/pages/device_services_page.dart";
import "package:flutter_web_bluetooth_example/web_helpers/web_helpers.dart";
import "package:flutter_web_bluetooth_example/widgets/bluetooth_device_widget.dart";
import "package:flutter_web_bluetooth_example/widgets/floating_action_buttons.dart";
import "package:flutter_web_bluetooth_example/widgets/info_dialog.dart";

const redirect = bool.fromEnvironment("redirectToHttps", defaultValue: false);

void main() {
  if (redirect) {
    WebHelpers.redirectToHttps();
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    return StreamBuilder<bool>(
      stream: FlutterWebBluetooth.instance.isAvailable,
      initialData: false,
      builder:
          (final BuildContext context, final AsyncSnapshot<bool> snapshot) {
            final available = snapshot.requireData;
            return MaterialApp(
              home: Scaffold(
                appBar: AppBar(
                  title: const SelectableText("Bluetooth web example app"),
                  actions: [
                    Builder(
                      builder: (final BuildContext context) {
                        return IconButton(
                          onPressed: () async {
                            await InfoDialog.showInfoDialog(context);
                          },
                          icon: const Icon(Icons.info),
                        );
                      },
                    ),
                  ],
                ),
                body: MainPage(isBluetoothAvailable: available),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.endDocked,
                floatingActionButton: const FABS(),
              ),
            );
          },
    );
  }
}

class MainPage extends StatefulWidget {
  final bool isBluetoothAvailable;

  const MainPage({required this.isBluetoothAvailable, super.key});

  @override
  State<StatefulWidget> createState() {
    return MainPageState();
  }
}

class MainPageState extends State<MainPage> {
  Stream<Set<MainPageDevice>>? _devicesStream;

  Color? _getErrorColor() {
    if (!mounted) {
      return null;
    }
    final theme = Theme.of(context);
    return theme.colorScheme.error;
  }

  @override
  void initState() {
    super.initState();

    _devicesStream = BluetoothBusiness.createDeviceStream();
  }

  Future<void> handleDeviceTap(final MainPageDevice device) async {
    DeviceServicesPage? page;
    if (device is MainPageDevice<BluetoothDevice>) {
      page = DeviceServicesPage(bluetoothDevice: device.device);
    } else {
      final state = await BluetoothBusiness.requestAdvertisementDevice(
        device.device,
      );

      late String message;
      switch (state.state) {
        case RequestDeviceState.adapterNotAvailable:
          message = "No bluetooth adapter available";
          break;
        case RequestDeviceState.userCancelled:
          message = "User canceled the dialog";
          break;
        case RequestDeviceState.deviceNotFound:
          message = "No devices found";
          break;
        case RequestDeviceState.ok:
          message = "";
          break;
        case RequestDeviceState.other:
        default:
          message = "Unknown error";
          break;
      }

      if (state.state == RequestDeviceState.ok && state.device == null) {
        message = "Unknown error";
      }

      if (message.isNotEmpty && mounted) {
        ScaffoldMessenger.maybeOf(context)?.showSnackBar(
          SnackBar(content: Text(message), backgroundColor: _getErrorColor()),
        );
      } else {
        page = DeviceServicesPage(bluetoothDevice: state.device!);
      }
    }

    if (page != null && mounted) {
      final finalPage = page;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (final BuildContext context) {
            return finalPage;
          },
        ),
      );
    } else {
      debugPrint("Could not open the page because not mounted anymore");
    }
  }

  @override
  Widget build(final BuildContext context) {
    return Column(
      children: [
        MainPageHeader(isBluetoothAvailable: widget.isBluetoothAvailable),
        const Divider(),
        Expanded(
          child: StreamBuilder(
            stream: _devicesStream,
            initialData: const {},
            builder:
                (final BuildContext context, final AsyncSnapshot snapshot) {
                  final devices = snapshot.requireData;
                  return ListView.builder(
                    itemCount: devices.length,
                    itemBuilder: (final BuildContext context, final int index) {
                      final device = devices.toList()[index];

                      return BluetoothDeviceWidget(
                        bluetoothDevice: device,
                        onTap: () async {
                          await handleDeviceTap(device);
                        },
                      );
                    },
                  );
                },
          ),
        ),
      ],
    );
  }
}

class MainPageHeader extends StatelessWidget {
  const MainPageHeader({required this.isBluetoothAvailable, super.key});

  final bool isBluetoothAvailable;

  @override
  Widget build(final BuildContext context) {
    final text = isBluetoothAvailable ? "supported" : "unsupported";

    final screenWidth = MediaQuery.of(context).size.width;
    final phoneSize = screenWidth <= 620.0;

    final children = <Widget>[
      SizedBox(
        width: phoneSize ? screenWidth : screenWidth * 0.5,
        child: ListTile(
          title: const SelectableText("Bluetooth api available"),
          subtitle: SelectableText(
            FlutterWebBluetooth.instance.isBluetoothApiSupported
                ? "true"
                : "false",
          ),
        ),
      ),
      SizedBox(
        width: phoneSize ? screenWidth : screenWidth * 0.5,
        child: ListTile(
          title: const SelectableText("Bluetooth available"),
          subtitle: SelectableText(text),
        ),
      ),
    ];

    if (phoneSize) {
      children.insert(1, const Divider());
      return Column(children: children);
    } else {
      return Row(children: children);
    }
  }
}
