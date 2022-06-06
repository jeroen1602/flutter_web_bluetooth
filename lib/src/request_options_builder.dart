part of flutter_web_bluetooth;

///
/// A builder to help setup the correct request options for a new device.
///
/// See: [FlutterWebBluetooth.requestDevice].
///
class RequestOptionsBuilder {
  final bool _acceptAllDevices;
  final List<RequestFilterBuilder> _requestFilters;
  final List<String>? _optionalServices;

  ///
  /// Tell the browser to only accept device matching the [requestFilters].
  /// A device has to only match one filter, so if you support multiple device
  /// types then you add a filter for each device type.
  ///
  /// [optionalServices] is a list of services that are a nice to have. If a
  /// device doesn't have this service then the browser won't reject it.
  ///
  /// **NOTE:** You **NEED** to define a service in either the [requestFilters]
  /// or [optionalServices] if you want to be able to communicate with a
  /// characteristic in it.
  ///
  /// May throw [StateError] if no filters are set, consider using
  /// [RequestOptionsBuilder.acceptAllDevices].
  ///
  RequestOptionsBuilder(List<RequestFilterBuilder> requestFilters,
      {List<String>? optionalServices})
      : _requestFilters = requestFilters,
        _acceptAllDevices = false,
        _optionalServices = optionalServices {
    if (_requestFilters.isEmpty) {
      throw StateError('No filters have been set, consider using '
          'RequestOptionsBuilder.acceptAllDevices() instead.');
    }
  }

  ///
  /// Tell the browser to just accept all devices.
  ///
  /// **NOTE:** You **NEED** to define a service in [optionalServices] if you
  /// want to be able to communicate communicate with a
  /// characteristic in it.
  ///
  RequestOptionsBuilder.acceptAllDevices({List<String>? optionalServices})
      : _acceptAllDevices = true,
        _requestFilters = [],
        _optionalServices = optionalServices;

  ///
  /// Convert the input requests to a [RequestOptions] object needed for the
  /// web navigator request.
  ///
  RequestOptions toRequestOptions() {
    final optionalService = _optionalServices;
    if (_acceptAllDevices) {
      if (optionalService == null) {
        return RequestOptions(acceptAllDevices: true);
      } else {
        return RequestOptions(
            acceptAllDevices: true,
            optionalServices:
                optionalService.map((e) => e.toLowerCase()).toList());
      }
    } else {
      if (optionalService == null) {
        return RequestOptions(
            filters: _requestFilters.map((e) => e.toScanFilter()).toList());
      } else {
        return RequestOptions(
            filters: _requestFilters.map((e) => e.toScanFilter()).toList(),
            optionalServices:
                optionalService.map((e) => e.toLowerCase()).toList());
      }
    }
  }
}

///
/// A filter to match on service data.
/// This can be used to define the services that the device should have before
/// being able to communicate with it.
///
@Deprecated(
    'These filters are not yet stable, so may change or not work at all')
class ServiceDataFilterBuilder {
  final String? _service;
  final Uint8List? _dataPrefix;
  final Uint8List? _mask;

  ///
  /// Create a new service filter.
  ///
  /// [service] may be a UUID of the service that should exist.
  ///
  /// [dataPrefix] is a uint8 (or byte) array of the first n bytes of the UUID
  /// that should exist for the service. For example if you have the UUID
  /// `D273346A-...` then the prefix of `D273` should match
  ///
  /// [mask] is a uint8 (or byte) array of the bits that should be matched against.
  /// The original UUID will be bit wise and (&) as well as the [dataPrefix] to
  /// the same [mask]. These two will then be compared to be equal.
  ///
  ServiceDataFilterBuilder(
      {String? service, Uint8List? dataPrefix, Uint8List? mask})
      : _service = service,
        _dataPrefix = dataPrefix,
        _mask = mask {
    if (_service == null && _dataPrefix == null && _mask == null) {
      throw StateError(
          'service, dataPrefix, and mask have not been set. Set at least one of them');
    }
  }

  ///
  /// Convert the filter to an actual [BluetoothServiceDataFilter] for the
  /// [RequestOptions].
  ///
  BluetoothServiceDataFilter toServiceDataFilter() {
    return BluetoothScanFilterHelper.createServiceDataObject(
        _service, _dataPrefix, _mask) as BluetoothServiceDataFilter;
  }
}

///
/// A filter for matching the manufacturer data of the device.
/// This can be used to define the services that the device should have before
/// being able to communicate with it.
///
class ManufacturerDataFilterBuilder {
  ///
  /// The 16 bit identifier of the company that either made the device, or more
  /// often the bluetooth chip that the device uses.
  ///
  /// See the full list of company identifiers
  /// [here](https://www.bluetooth.com/specifications/assigned-numbers/company-identifiers/).
  ///
  final int? _companyIdentifier;
  final Uint8List? _dataPrefix;
  final Uint8List? _mask;

  ///
  /// Create a new manufacturer data filter.
  ///
  /// [companyIdentifier] is a 16 bit identifier of the company that either made
  /// the device, or made the bluetooth chip that the device uses.
  ///
  /// See the full list of company identifiers
  /// [here](https://www.bluetooth.com/specifications/assigned-numbers/company-identifiers/).
  ///
  /// [dataPrefix] is a uint8 (or byte) array of the first n bytes of the
  /// manufacturer data of the device. For example if you have the UUID
  /// `D273346A-...` then the prefix of `D273` should match
  ///
  /// [mask] is a uint8 (or byte) array of the bits that should be matched against.
  /// The manufacturer data will be bit wise and (&) as well as the [dataPrefix] to
  /// the same [mask]. These two will then be compared to be equal.
  ///
  ManufacturerDataFilterBuilder(
      {int? companyIdentifier, Uint8List? dataPrefix, Uint8List? mask})
      : _companyIdentifier = companyIdentifier,
        _dataPrefix = dataPrefix,
        _mask = mask {
    if (companyIdentifier != null &&
        (companyIdentifier < 0 || companyIdentifier > 0xFFFF)) {
      throw ArgumentError(
          'The company identifier must fit in 16-bits, so greater than 0 and smaller than 0xFFFF (65535)',
          'companyIdentifier');
    }
    if (_companyIdentifier == null && _dataPrefix == null && _mask == null) {
      throw StateError(
          'companyIdentifier, dataPrefix, and mask have not been set. Set at least one of them');
    }
  }

  ///
  /// Convert the filter to an actual [BluetoothManufacturerDataFilter] for the
  /// [RequestOptions].
  ///
  BluetoothManufacturerDataFilter toManufacturerDataFilter() {
    return BluetoothScanFilterHelper.createManufacturerDataObject(
            _companyIdentifier, _dataPrefix, _mask)
        as BluetoothManufacturerDataFilter;
  }
}

///
/// A helper to help create a [BluetoothScanFilter].
///
/// A device needs to match all the items in this filter before the browser
/// will allow it.
///
class RequestFilterBuilder {
  final String? _name;
  final String? _namePrefix;
  final List<String>? _services;
  final List<ManufacturerDataFilterBuilder>? _manufacturerData;
  //ignore: deprecated_member_use_from_same_package
  final List<ServiceDataFilterBuilder>? _serviceData;

  ///
  /// [name] is the name of the device. The name must match exactly for
  /// the device to be accepted.
  ///
  /// [namePrefix] is the a prefix of the name. The name of the device must
  /// have the same prefix. For example: a device with the name "ABCDEF" will
  /// be allowed with the prefix "ABC" and not with the prefix "DEF".
  ///
  /// [services] is a list of service UUIDS. The device must have all the
  /// services advertised in the list or it won't be allowed access.
  ///
  /// [manufacturerData] is a list of [ManufacturerDataFilterBuilder]
  /// for what the manufacture data of the device should match before it shows
  /// up in the available devices list. Note that if you set multiple manufacturer
  /// data filters then a single device must match all of them.
  ///
  /// [serviceData] **Note** this is not stable yet and my not be implemented.
  /// ignore: deprecated_member_use_from_same_package
  /// A list of [ServiceDataFilterBuilder]s for the services that the
  /// device should support.
  ///
  /// May throw [StateError] if all the parameters are null or services list is
  /// empty.
  ///
  /// TODO: change this API to force the developer to enter at least one filter item
  RequestFilterBuilder(
      {String? name,
      String? namePrefix,
      List<String>? services,
      List<ManufacturerDataFilterBuilder>? manufacturerData,
      //ignore: deprecated_member_use_from_same_package
      List<ServiceDataFilterBuilder>? serviceData})
      : _name = name,
        _namePrefix = namePrefix,
        _services = services,
        _manufacturerData = manufacturerData,
        _serviceData = serviceData {
    if (_name == null &&
        _namePrefix == null &&
        (_services == null || _services?.isEmpty == true) &&
        (_manufacturerData == null || _manufacturerData?.isEmpty == true) &&
        (_serviceData == null || _serviceData?.isEmpty == true)) {
      throw StateError(
          'No filter parameters have been set, you may want to use '
          '[RequestOptionsBuilder.acceptAllDevices()]!');
    }
    if (_services?.isEmpty == true) {
      throw StateError(
          'Filter service is empty, consider setting it to null instead.');
    }
  }

  ///
  /// convert to an actual [BluetoothScanFilter] Javascript object for the web
  /// api call.
  ///
  BluetoothScanFilter toScanFilter() {
    return BluetoothScanFilterHelper.createScanFilterObject(
        _services,
        _name,
        _namePrefix,
        _manufacturerData?.map((e) => e.toManufacturerDataFilter()).toList(),
        _serviceData
            ?.map((e) => e.toServiceDataFilter())
            .toList()) as BluetoothScanFilter;
  }
}
