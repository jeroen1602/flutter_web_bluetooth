import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_web_bluetooth/flutter_web_bluetooth.dart';
import 'package:flutter_web_bluetooth/native_web_bluetooth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // try {
    platformVersion =
        await FlutterWebBluetooth.instance.isAvailable ? 'supported' : 'unsupported';
    // } on PlatformException {
    //   platformVersion = 'ERROR';
    // }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $_platformVersion\n'),
        ),
        floatingActionButton: ElevatedButton(
            onPressed: () {
              FlutterWebBluetooth.instance.requestDevice(
                      RequestOptions(acceptAllDevices: true))
                  .then((device) {
                debugPrint("Device got! ${device.name}, ${device.id}");
              });
            },
            child: Icon(Icons.search)),
      ),
    );
  }
}
