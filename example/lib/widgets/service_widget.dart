import "package:flutter/material.dart";
import "package:flutter_web_bluetooth/flutter_web_bluetooth.dart";
import "package:flutter_web_bluetooth_example/widgets/characteristic_widget.dart";

class _ServiceAndCharacteristic {
  final List<BluetoothService> services;
  final List<BluetoothCharacteristic> characteristics;

  const _ServiceAndCharacteristic(this.services, this.characteristics);
}

class ServiceWidget extends StatefulWidget {
  ServiceWidget({required this.service, super.key}) {
    serviceName = BluetoothDefaultServiceUUIDS.services
        .cast<BluetoothDefaultServiceUUIDS?>()
        .firstWhere(
          (final element) => element?.uuid == service.uuid,
          orElse: () => null,
        )
        ?.name;
  }

  final BluetoothService service;
  late final String? serviceName;

  @override
  State<StatefulWidget> createState() {
    return ServiceState();
  }
}

class ServiceState extends State<ServiceWidget> {
  Future<_ServiceAndCharacteristic>? _serviceAndCharacteristics;

  @override
  void initState() {
    super.initState();
    // ignore: discarded_futures
    _serviceAndCharacteristics = _getServicesAndCharacteristics();
  }

  Future<_ServiceAndCharacteristic> _getServicesAndCharacteristics() async {
    final List<BluetoothService> services = [];
    if (widget.service.hasIncludedService) {
      for (final defaultService in BluetoothDefaultServiceUUIDS.services) {
        try {
          final service = await widget.service.getIncludedService(
            defaultService.uuid,
          );
          services.add(service);
        } catch (e) {
          if (e is NotFoundError) {
            // Don't want to spam the console.
          } else {
            debugPrint("$e");
          }
        }
      }
    }
    List<BluetoothCharacteristic> characteristics = [];
    try {
      characteristics = await widget.service.getCharacteristics();
    } catch (e) {
      debugPrint("$e");
    }

    return _ServiceAndCharacteristic(services, characteristics);
  }

  @override
  Widget build(final BuildContext context) {
    return FutureBuilder(
      future: _serviceAndCharacteristics,
      initialData: const _ServiceAndCharacteristic([], []),
      builder:
          (
            final BuildContext context,
            final AsyncSnapshot<_ServiceAndCharacteristic> snapshot,
          ) {
            final data = snapshot.requireData;

            final subServices = <Widget>[];
            for (final service in data.services) {
              subServices.addAll([
                Text("Service with uuid: ${service.uuid}"),
                const Divider(),
              ]);
            }
            if (subServices.isNotEmpty) {
              subServices.add(const Divider(thickness: 1.5));
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
                  title: const Text("Service"),
                  subtitle: SelectableText(
                    widget.serviceName == null
                        ? widget.service.uuid
                        : "${widget.service.uuid} (${widget.serviceName})",
                  ),
                ),
                const Divider(thickness: 1.5),
                ...subServices,
                ...characteristics,
                const Divider(thickness: 2.0),
              ],
            );
          },
    );
  }
}
