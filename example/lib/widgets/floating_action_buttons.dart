import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_web_bluetooth_example/business/bluetooth_business.dart';
import 'package:flutter_web_bluetooth_example/widgets/browser_not_supported_alert_widget.dart';

///
/// The floating action buttons that are used inside of the web app.
///
class FABS extends StatefulWidget {
  const FABS({super.key});

  @override
  State<StatefulWidget> createState() {
    return FABSState();
  }
}

class FABSState extends State<FABS> {
  bool isScanning = false;

  Color? _getErrorColor() {
    if (!mounted) {
      return null;
    }
    final theme = Theme.of(context);
    return theme.colorScheme.error;
  }

  Future<void> _clickRequestDevice() async {
    final state = await BluetoothBusiness.requestDevice();

    if (state == RequestDeviceState.notSupported) {
      if (mounted) {
        BrowserNotSupportedAlertWidget.showCustomDialog(context);
      }
      return;
    }

    late String message;
    switch (state) {
      case RequestDeviceState.adapterNotAvailable:
        message = 'No bluetooth adapter available';
        break;
      case RequestDeviceState.userCancelled:
        message = 'User canceled the dialog';
        break;
      case RequestDeviceState.deviceNotFound:
        message = 'No devices found';
        break;
      case RequestDeviceState.ok:
        message = '';
        break;
      case RequestDeviceState.other:
      default:
        message = 'Unknown error';
        break;
    }

    if (message.isNotEmpty && mounted) {
      ScaffoldMessenger.maybeOf(context)?.showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: _getErrorColor(),
      ));
    }
  }

  Future<void> _clickRequestLEScan() async {
    final state = await BluetoothBusiness.requestLEScan();

    if (state == RequestLEState.notSupported) {
      if (mounted) {
        BrowserNotSupportedAlertWidget.showCustomDialog(context);
      }
      return;
    }

    late String message;
    switch (state) {
      case RequestLEState.apiNotSupported:
        message = 'Request LE scan is not implemented in this browser';
        break;
      case RequestLEState.adapterNotAvailable:
        message = 'No bluetooth adapter available';
        break;
      case RequestLEState.userCancelled:
        message = 'User canceled the dialog';
        break;
      case RequestLEState.deviceNotFound:
        message = 'No devices found';
        break;
      case RequestLEState.permissionError:
        message = 'Permission denied';
        break;
      case RequestLEState.timeoutException:
        message =
            'Scan did not start within the timeout; it may not be fully supported on this platform.';
        break;
      case RequestLEState.stopped:
      case RequestLEState.ok:
        message = '';
        break;
      case RequestLEState.other:
      default:
        message = 'Unknown error';
        break;
    }

    setState(() {
      isScanning = state == RequestLEState.ok;
    });

    if (message.isNotEmpty && mounted) {
      ScaffoldMessenger.maybeOf(context)?.showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: _getErrorColor(),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
              tooltip: 'Pair a new device',
              heroTag: null,
              onPressed: _clickRequestDevice,
              child: const Icon(Icons.add)),
          const SizedBox(
            height: 12.0,
          ),
          if (isScanning)
            FloatingActionButton(
              tooltip: 'Stop watching advertisements',
              heroTag: null,
              onPressed: _clickRequestLEScan,
              backgroundColor: _getErrorColor(),
              child: const Icon(Icons.bluetooth_disabled),
            )
          else
            FloatingActionButton(
              tooltip: 'Start watching advertisements',
              heroTag: null,
              onPressed: _clickRequestLEScan,
              child: const Icon(Icons.bluetooth_searching),
            ),
        ],
      ),
    );
  }
}
