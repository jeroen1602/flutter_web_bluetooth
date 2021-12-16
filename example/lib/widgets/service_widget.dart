import 'package:flutter/material.dart';
import 'package:flutter_web_bluetooth/flutter_web_bluetooth.dart';
import 'package:flutter_web_bluetooth_example/widgets/characteristic_widget.dart';

class _ServiceAndCharacteristic {
  final List<BluetoothService> services;
  final List<BluetoothCharacteristic> characteristics;

  const _ServiceAndCharacteristic(this.services, this.characteristics);
}

class ServiceWidget extends StatelessWidget {
  final BluetoothService service;
  late final String? serviceName;

  ServiceWidget({Key? key, required this.service}) : super(key: key) {
    serviceName = BluetoothDefaultServiceUUIDS.VALUES
        .cast<BluetoothDefaultServiceUUIDS?>()
        .firstWhere((element) => element?.uuid == service.uuid)
        ?.name;
  }

  Future<_ServiceAndCharacteristic> getServicesAndCharacteristics() async {
    final List<BluetoothService> services = [];
    if (service.hasIncludedService) {
      for (final defaultService in BluetoothDefaultServiceUUIDS.VALUES) {
        try {
          final service =
              await this.service.getIncludedService(defaultService.uuid);
          services.add(service);
        } catch (e) {
          if (e is NotFoundError) {
            // Don't want to spam the console.
          } else {
            // ignore: avoid_print
            print(e);
          }
        }
      }
    }
    final List<BluetoothCharacteristic> characteristics = [];
    for (final defaultCharacteristics
        in BluetoothDefaultCharacteristicUUIDS.VALUES) {
      try {
        final characteristic =
            await service.getCharacteristic(defaultCharacteristics.uuid);
        characteristics.add(characteristic);
      } catch (e) {
        if (e is NotFoundError) {
          // Don't want to spam the console.
        } else {
          // ignore: avoid_print
          print(e);
        }
      }
    }

    return _ServiceAndCharacteristic(services, characteristics);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getServicesAndCharacteristics(),
        initialData: const _ServiceAndCharacteristic([], []),
        builder: (BuildContext context,
            AsyncSnapshot<_ServiceAndCharacteristic> snapshot) {
          final data = snapshot.requireData;

          final subServices = <Widget>[];
          for (final service in data.services) {
            subServices.addAll([
              Text('Service with uuid: ${service.uuid}'),
              const Divider(),
            ]);
          }
          if (subServices.isNotEmpty) {
            subServices.add(const Divider(
              thickness: 1.5,
            ));
          }

          final characteristics = <Widget>[];
          for (final characteristic in data.characteristics) {
            characteristics.addAll([
              CharacteristicWidget(characteristic: characteristic),
              const Divider(),
            ]);
          }

          return Column(
            children: [
              ListTile(
                title: const Text('Service'),
                subtitle: SelectableText(serviceName == null
                    ? service.uuid
                    : '${service.uuid} ($serviceName)'),
              ),
              const Divider(
                thickness: 1.5,
              ),
              ...subServices,
              ...characteristics,
              const Divider(
                thickness: 2.0,
              ),
            ],
          );
        });
  }
}
