import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_web_bluetooth/flutter_web_bluetooth.dart";

abstract class Actions {
  Future<void> readValue();

  Future<void> toggleNotify();

  bool get isNotifying;

  Future<void> writeValue(final BuildContext? context);
}

class CharacteristicActions extends Actions {
  CharacteristicActions(final BluetoothCharacteristic characteristic)
    : _characteristic = characteristic;

  final BluetoothCharacteristic _characteristic;

  @override
  bool get isNotifying => _characteristic.isNotifying;

  @override
  Future<void> readValue() {
    return _characteristic.readValue();
  }

  @override
  Future<void> toggleNotify() {
    if (isNotifying) {
      return _characteristic.stopNotifications();
    } else {
      return _characteristic.startNotifications();
    }
  }

  @override
  Future<void> writeValue(final BuildContext? context) async {
    if (context != null) {
      ScaffoldMessenger.maybeOf(context)?.showSnackBar(
        const SnackBar(
          content: Text(
            "Write is supported just not implemented in the example",
          ),
        ),
      );
    }
  }
}

///
/// A widget to handle the different actions for a characteristic.
///
/// It reads from the [properties] to see if the actions is supported and
/// then adds it to the list, or it leaves it out.
///
class ActionsWidget extends StatefulWidget {
  const ActionsWidget(this.properties, this.actions, {super.key});

  final Actions actions;
  final BluetoothCharacteristicProperties properties;

  @override
  State<StatefulWidget> createState() {
    return ActionsSate();
  }
}

class ActionsSate extends State<ActionsWidget> {
  Color? _getErrorColor() {
    if (!mounted) {
      return null;
    }
    final theme = Theme.of(context);
    return theme.colorScheme.error;
  }

  Widget? getReadValueAction() {
    if (!widget.properties.hasProperties || widget.properties.read) {
      return OutlinedButton(
        onPressed: handlePressed(widget.actions.readValue),
        child: const Text("Read value"),
      );
    }
    return null;
  }

  Widget? getNotifyAction() {
    if (!widget.properties.hasProperties || widget.properties.notify) {
      return OutlinedButton(
        onPressed: handlePressed(widget.actions.toggleNotify),
        child: Text(
          widget.actions.isNotifying ? "Stop notifying" : "Start notifying",
        ),
      );
    }
    return null;
  }

  Widget? getWriteAction() {
    if (!widget.properties.hasProperties || widget.properties.write) {
      return OutlinedButton(
        onPressed: handlePressedWithContext(widget.actions.writeValue),
        child: const Text("Write value"),
      );
    }
    return null;
  }

  FutureOr<void> Function() handlePressed(
    final FutureOr<void> Function() method,
  ) {
    return () async {
      try {
        await method.call();
        setState(() {
          // Make sure `isNotifying` is updated.
        });
      } catch (e, s) {
        debugPrint("$e\n$s");
        if (mounted) {
          ScaffoldMessenger.maybeOf(context)?.showSnackBar(
            SnackBar(
              content: Text("Something went wrong: $e"),
              backgroundColor: _getErrorColor(),
            ),
          );
        }
      }
    };
  }

  FutureOr<void> Function() handlePressedWithContext(
    final FutureOr<void> Function(BuildContext?) method,
  ) {
    return () async {
      try {
        if (mounted) {
          await method.call(context);
        } else {
          await method.call(null);
        }
      } catch (e, s) {
        debugPrint("$e\n$s");
        if (mounted) {
          ScaffoldMessenger.maybeOf(context)?.showSnackBar(
            SnackBar(
              content: Text("Something went wrong: $e"),
              backgroundColor: _getErrorColor(),
            ),
          );
        }
      }
    };
  }

  bool _hasValueSet<T>([final List<T?> args = const []]) {
    for (final arg in args) {
      if (arg != null) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(final BuildContext context) {
    final actionReadValue = getReadValueAction();
    final actionNotify = getNotifyAction();
    final actionWrite = getWriteAction();

    final hasAction = _hasValueSet([
      actionReadValue,
      actionNotify,
      actionWrite,
    ]);

    if (hasAction) {
      return Row(
        children: [
          if (actionReadValue != null) actionReadValue,
          if (actionNotify != null) actionNotify,
          if (actionWrite != null) actionWrite,
        ],
      );
    } else {
      return const Row(children: [Text("No actions for this characteristic")]);
    }
  }
}
