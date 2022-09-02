import 'package:flutter/material.dart';
import 'package:flutter_web_bluetooth/flutter_web_bluetooth.dart';
import 'package:flutter_web_bluetooth/js_web_bluetooth.dart';
import 'package:flutter_web_bluetooth_example/pages/device_services_page.dart';
import 'package:flutter_web_bluetooth_example/web_helpers/web_helpers.dart';
import 'package:flutter_web_bluetooth_example/widgets/bluetooth_device_widget.dart';
import 'package:flutter_web_bluetooth_example/widgets/browser_not_supported_alert_widget.dart';

const redirect = bool.fromEnvironment('redirectToHttps', defaultValue: false);

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
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: FlutterWebBluetooth.instance.isAvailable,
      initialData: false,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        final available = snapshot.requireData;
        return MaterialApp(
            home: Scaffold(
          appBar: AppBar(
            title: const SelectableText('Bluetooth web example app'),
          ),
          body: MainPage(
            isBluetoothAvailable: available,
          ),
          floatingActionButton: Builder(
            builder: (BuildContext context) {
              final theme = Theme.of(context);
              final errorColor = theme.errorColor;
              return ElevatedButton(
                  onPressed: () async {
                    if (!FlutterWebBluetooth.instance.isBluetoothApiSupported) {
                      BrowserNotSupportedAlertWidget.showCustomDialog(context);
                    } else {
                      try {
                        final device = await FlutterWebBluetooth.instance
                            .requestDevice(
                                RequestOptionsBuilder.acceptAllDevices(
                                    optionalServices:
                                        BluetoothDefaultServiceUUIDS.VALUES
                                            .map((e) => e.uuid)
                                            .toList()));
                        debugPrint("Device got! ${device.name}, ${device.id}");
                      } on BluetoothAdapterNotAvailable {
                        ScaffoldMessenger.maybeOf(context)
                            ?.showSnackBar(SnackBar(
                          content: const Text('No bluetooth adapter available'),
                          backgroundColor: errorColor,
                        ));
                      } on UserCancelledDialogError {
                        ScaffoldMessenger.maybeOf(context)
                            ?.showSnackBar(SnackBar(
                          content: const Text('User canceled the dialog'),
                          backgroundColor: errorColor,
                        ));
                      } on DeviceNotFoundError {
                        ScaffoldMessenger.maybeOf(context)
                            ?.showSnackBar(SnackBar(
                          content: const Text('No devices found'),
                          backgroundColor: errorColor,
                        ));
                      }
                    }
                  },
                  child: const Icon(Icons.search));
            },
          ),
        ));
      },
    );
  }
}

class MainPage extends StatefulWidget {
  final bool isBluetoothAvailable;

  const MainPage({
    Key? key,
    required this.isBluetoothAvailable,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MainPageState();
  }
}

class MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      MainPageHeader(
        isBluetoothAvailable: widget.isBluetoothAvailable,
      ),
      const Divider(),
      Expanded(
        child: StreamBuilder(
          stream: FlutterWebBluetooth.instance.devices,
          initialData: const <BluetoothDevice>{},
          builder: (BuildContext context,
              AsyncSnapshot<Set<BluetoothDevice>> snapshot) {
            final devices = snapshot.requireData;
            return ListView.builder(
              itemCount: devices.length,
              itemBuilder: (BuildContext context, int index) {
                final device = devices.toList()[index];
                return BluetoothDeviceWidget(
                  bluetoothDevice: device,
                  onTap: () async {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return DeviceServicesPage(bluetoothDevice: device);
                    }));
                  },
                );
              },
            );
          },
        ),
      ),
    ]);
  }
}

class MainPageHeader extends StatelessWidget {
  const MainPageHeader({Key? key, required this.isBluetoothAvailable})
      : super(key: key);

  final bool isBluetoothAvailable;

  @override
  Widget build(BuildContext context) {
    final text = isBluetoothAvailable ? 'supported' : 'unsupported';

    final screenWidth = MediaQuery.of(context).size.width;
    final phoneSize = screenWidth <= 620.0;

    final children = <Widget>[
      SizedBox(
          width: phoneSize ? screenWidth : screenWidth * 0.5,
          child: ListTile(
            title: const SelectableText('Bluetooth api available'),
            subtitle: SelectableText(
                FlutterWebBluetooth.instance.isBluetoothApiSupported
                    ? 'true'
                    : 'false'),
          )),
      SizedBox(
          width: phoneSize ? screenWidth : screenWidth * 0.5,
          child: ListTile(
            title: const SelectableText('Bluetooth available'),
            subtitle: SelectableText(text),
          )),
    ];

    if (phoneSize) {
      children.insert(1, const Divider());
      return Column(
        children: children,
      );
    } else {
      return Row(children: children);
    }
  }
}
