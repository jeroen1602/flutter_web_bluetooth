import 'package:flutter/material.dart';
import 'package:flutter_web_bluetooth/flutter_web_bluetooth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
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
            floatingActionButton: ElevatedButton(
                onPressed: () {
                  FlutterWebBluetooth.instance
                      .requestDevice(RequestOptionsBuilder.acceptAllDevices())
                      .then((device) {
                    debugPrint("Device got! ${device.name}, ${device.id}");
                  });
                },
                child: Icon(Icons.search)),
          ),
        );
      },
    );
  }
}

class MainPage extends StatefulWidget {
  final bool isBluetoothAvailable;

  const MainPage({Key? key, required this.isBluetoothAvailable})
      : super(key: key);

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
      Divider(),
    ]);
  }
}

class MainPageHeader extends StatelessWidget {
  MainPageHeader({Key? key, required this.isBluetoothAvailable})
      : super(key: key);

  final bool isBluetoothAvailable;

  @override
  Widget build(BuildContext context) {
    final text = isBluetoothAvailable ? 'supported' : 'unsupported';

    final screenWidth = MediaQuery.of(context).size.width;
    final phoneSize = screenWidth <= 620.0;

    final children = <Widget>[
      Container(
          width: phoneSize ? screenWidth : screenWidth * 0.5,
          child: ListTile(
            title: SelectableText('Bluetooth api avialable'),
            subtitle: SelectableText(
                FlutterWebBluetooth.instance.isBluetoothApiSupported
                    ? 'true'
                    : 'false'),
          )),
      Container(
          width: phoneSize ? screenWidth : screenWidth * 0.5,
          child: ListTile(
            title: SelectableText('Bluetooth available'),
            subtitle: SelectableText(text),
          )),
    ];

    if (phoneSize) {
      children.insert(1, Divider());
      return Column(
        children: children,
      );
    } else {
      return Row(children: children);
    }
  }
}
