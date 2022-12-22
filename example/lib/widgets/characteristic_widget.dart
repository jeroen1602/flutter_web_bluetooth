import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_web_bluetooth/flutter_web_bluetooth.dart';
import 'package:flutter_web_bluetooth_example/widgets/characteristic_actions.dart';

class CharacteristicWidget extends StatefulWidget {
  CharacteristicWidget({required this.characteristic, Key? key})
      : super(key: key) {
    characteristicName = BluetoothDefaultCharacteristicUUIDS.values
        .cast<BluetoothDefaultCharacteristicUUIDS?>()
        .firstWhere((element) => element?.uuid == characteristic.uuid)
        ?.name;
  }

  final BluetoothCharacteristic characteristic;
  late final String? characteristicName;

  @override
  State<StatefulWidget> createState() {
    return CharacteristicWidgetState();
  }
}

class CharacteristicWidgetState extends State<CharacteristicWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(widget.characteristicName == null
              ? 'Characteristic'
              : 'Characteristic (${widget.characteristicName})'),
          subtitle: SelectableText(widget.characteristicName == null
              ? widget.characteristic.uuid
              : '${widget.characteristic.uuid} (${widget.characteristicName})'),
        ),
        StreamBuilder<ByteData>(
            stream: widget.characteristic.value,
            builder: (BuildContext context, AsyncSnapshot<ByteData> snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error.toString()}');
              }
              final data = snapshot.data;
              if (data != null) {
                return DataWidget(data: data);
              }
              return const Text('No data retrieved!');
            }),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ActionsWidget(widget.characteristic.properties,
              CharacteristicActions(widget.characteristic)),
        ),
      ],
    );
  }
}

class DataWidget extends StatelessWidget {
  const DataWidget({required this.data, Key? key}) : super(key: key);

  final ByteData data;

  String _toHex() {
    var output = '0x';
    for (var i = 0; i < data.lengthInBytes; i++) {
      output += data.getUint8(i).toRadixString(16).toUpperCase();
    }
    return output;
  }

  String _asUTF8String() {
    final list =
        List.generate(data.lengthInBytes, (index) => data.getUint8(index));
    try {
      return const Utf8Decoder().convert(list);
    } on FormatException {
      // ignore: avoid_print
      print('COULD NOT CONVERT');
      return '';
    } catch (e) {
      // ignore: avoid_print
      print('COULD NOT CONVERT $e');
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              const Text('Data as hex:'),
              const VerticalDivider(),
              SelectableText(_toHex())
            ],
          ),
          Row(
            children: [
              const Text('Data as UTF-8 String:'),
              const VerticalDivider(),
              SelectableText(_asUTF8String())
            ],
          ),
        ],
      ),
    );
  }
}
