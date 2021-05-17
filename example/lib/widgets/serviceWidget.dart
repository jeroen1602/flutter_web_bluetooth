import 'package:flutter/material.dart';
import 'package:flutter_web_bluetooth/flutter_web_bluetooth.dart';

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
        .firstWhere((element) => element?.uuid == this.service.uuid)
        ?.name;
  }

  Future<_ServiceAndCharacteristic> getServicesAndCharacteristics() async {
    final List<BluetoothService> services = [];
    if (this.service.hasIncludedService) {
      for (final defaultService in BluetoothDefaultServiceUUIDS.VALUES) {
        try {
          final service =
              await this.service.getIncludedService(defaultService.uuid);
          services.add(service);
        } catch (e) {
          if (e is NotFoundError) {
            // Don't want to spam the console.
          } else {
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
            await this.service.getCharacteristic(defaultCharacteristics.uuid);
        characteristics.add(characteristic);
      } catch (e) {
        if (e is NotFoundError) {
          // Don't want to spam the console.
        } else {
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
        initialData: _ServiceAndCharacteristic([], []),
        builder: (BuildContext context,
            AsyncSnapshot<_ServiceAndCharacteristic> snapshot) {
          final data = snapshot.requireData;

          final subServices = <Widget>[];
          for (final service in data.services) {
            subServices.addAll([
              Text('Service with uuid: ${service.uuid}'),
              Divider(),
            ]);
          }
          if (subServices.isNotEmpty) {
            subServices.add(Divider(
              thickness: 1.5,
            ));
          }

          final characteristics = <Widget>[];
          for (final characteristic in data.characteristics) {
            characteristics.addAll([
              Text('Characteristic with uuid: ${characteristic.uuid}'),
              Divider(),
            ]);
          }

          return Column(
            children: [
              ListTile(
                title: Text('Service'),
                subtitle: SelectableText(serviceName == null
                    ? service.uuid
                    : '${service.uuid} ($serviceName)'),
              ),
              Divider(
                thickness: 1.5,
              ),
              ...subServices,
              ...characteristics,
              Divider(
                thickness: 2.0,
              ),
            ],
          );
        });
  }
}
