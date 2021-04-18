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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: StreamBuilder<bool>(
            stream: FlutterWebBluetooth.instance.isAvailable,
            initialData: false,
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              final text = snapshot.requireData ? 'supported' : 'unsupported';
              return Text('Bleutooth is: $text');
            },
          ),
        ),
        floatingActionButton: ElevatedButton(
            onPressed: () {
              FlutterWebBluetooth.instance.requestDevice(
                      RequestOptions(acceptAllDevices: true))
                  .then((device) {
                // debugPrint("Device got! ${device.name}, ${device.id}");
              });
            },
            child: Icon(Icons.search)),
      ),
    );
  }
}
