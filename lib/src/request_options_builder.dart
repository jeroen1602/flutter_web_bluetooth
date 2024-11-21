// ignore: use_string_in_part_of_directives
part of flutter_web_bluetooth;

///
/// A builder to help setup the correct request options for a new device.
///
/// See: [FlutterWebBluetooth.requestDevice].
///
class RequestOptionsBuilder {
  final bool _acceptAllDevices;
  final List<RequestFilterBuilder> _requestFilters;
  final List<RequestFilterBuilder>? _exclusionFilters;
  final List<String>? _optionalServices;
  final List<int>? _optionalManufacturerData;

  ///
  /// Tell the browser to only accept device matching the [requestFilters].
  /// A device has to only match one filter, so if you support multiple device
  /// types then you add a filter for each device type.
  ///
  /// A device may not have enough distinct information. To solve this you may
  /// add [exclusionFilters]. These are the same as the [requestFilters], if a
  /// device matches **ANY** of these filters then it will not be available.
  ///
  /// [optionalServices] is a list of services that are a nice to have. If a
  /// device doesn't have this service then the browser won't reject it.
  ///
  /// **NOTE:** For [optionalServices]\: Some services are on a block list,
  /// and are thus not available. The complete blocklist can be found here:
  /// https://github.com/WebBluetoothCG/registries/blob/master/gatt_blocklist.txt
  ///
  /// [optionalManufacturerData] is a list of manufacturer codes. These codes
  /// are then used to grand access to specific manufacturer data. This can
  /// be a list of either strings in hexadecimal or ints. **NOTE** these values
  /// can be a maximum of unsigned 16 bits.
  ///
  /// **NOTE:** For [optionalManufacturerData]\: Some manufacturer data is on a
  /// block list, and is thus not available. The complete blocklist can be found here:
  /// https://github.com/WebBluetoothCG/registries/blob/master/manufacturer_data_blocklist.txt
  ///
  /// **NOTE:** You **NEED** to define a service in either the [requestFilters]
  /// or [optionalServices] if you want to be able to communicate with a
  /// characteristic in it.
  ///
  /// **NOTE:** You **NEED** to define [optionalManufacturerData] if you want
  /// to get this manufacturer data later.
  ///
  /// **NOTE:** [exclusionFilters] are only supported from Chrome 114 and above
  /// as well other browsers based on chromium.
  ///
  /// May throw [StateError] if no filters are set, consider using
  /// [RequestOptionsBuilder.acceptAllDevices].
  ///
  RequestOptionsBuilder(
    final List<RequestFilterBuilder> requestFilters, {
    final List<RequestFilterBuilder>? exclusionFilters,
    final List<String>? optionalServices,
    final List<dynamic>? optionalManufacturerData,
  })  : _requestFilters = requestFilters,
        _acceptAllDevices = false,
        _exclusionFilters = exclusionFilters,
        _optionalServices = optionalServices,
        _optionalManufacturerData =
            RequestOptionsBuilder._convertOptionalManufacturerData(
                optionalManufacturerData) {
    if (_requestFilters.isEmpty) {
      throw StateError("No filters have been set, consider using "
          "RequestOptionsBuilder.acceptAllDevices() instead.");
    }
  }

  ///
  /// Tell the browser to just accept all devices.
  ///
  /// [optionalServices] is a list of services that are a nice to have. If a
  /// device doesn't have this service then the browser won't reject it.
  ///
  /// **NOTE:** For [optionalServices]\: Some services are on a block list,
  /// and are thus not available. The complete blocklist can be found here:
  /// https://github.com/WebBluetoothCG/registries/blob/master/gatt_blocklist.txt
  ///
  /// [optionalManufacturerData] is a list of manufacturer codes. These codes
  /// are then used to grand access to specific manufacturer data. This can
  /// be a list of either strings in hexadecimal or ints. **NOTE** these values
  /// can be a maximum of unsigned 16 bits.
  ///
  /// **NOTE:** For [optionalManufacturerData]\: Some manufacturer data is on a
  /// block list, and is thus not available. The complete blocklist can be found here:
  /// https://github.com/WebBluetoothCG/registries/blob/master/manufacturer_data_blocklist.txt
  ///
  /// **NOTE:** You **NEED** to define a service in [optionalServices] if you
  /// want to be able to communicate communicate with a
  /// characteristic in it.
  ///
  /// **NOTE:** You **NEED** to define [optionalManufacturerData] if you want
  /// to get this manufacturer data later.
  ///
  RequestOptionsBuilder.acceptAllDevices({
    final List<String>? optionalServices,
    final List<dynamic>? optionalManufacturerData,
  })  : _acceptAllDevices = true,
        _requestFilters = [],
        _exclusionFilters = null,
        _optionalServices = optionalServices,
        _optionalManufacturerData =
            RequestOptionsBuilder._convertOptionalManufacturerData(
                optionalManufacturerData);

  static List<int>? _convertOptionalManufacturerData(
          final List<dynamic>? optionalManufacturerData) =>
      optionalManufacturerData?.map((final manufacturer) {
        if (manufacturer is String) {
          var code = manufacturer.toLowerCase();
          if (code.startsWith("0x")) {
            code = code.substring(2);
          }
          if (code.isEmpty) {
            throw ArgumentError("manufacturer code is an empty string");
          }
          return int.parse(code, radix: 16);
        } else if (manufacturer is int) {
          return manufacturer;
        } else {
          throw ArgumentError("Unsupported type in optional manufacturer data");
        }
      }).map((final manufacturer) {
        if (manufacturer < 0) {
          throw ArgumentError(
              "manufacturer code in optional manufacturer data cannot be negative");
        }
        if (manufacturer & ~0xFFFF != 0) {
          throw ArgumentError(
              "manufacturer code in optional manufacturer data does not fit in 1 bits");
        }
        return manufacturer;
      }).toList(growable: false);

  ///
  /// Convert the input requests to a [RequestOptions] object needed for the
  /// web navigator request.
  ///
  RequestOptions toRequestOptions() {
    final filters = _requestFilters
        .map((final e) => e.toScanFilter())
        .toList(growable: false);
    final exclusionFilters = _exclusionFilters?.isNotEmpty ?? false
        ? _exclusionFilters
            ?.map((final e) => e.toScanFilter())
            .toList(growable: false)
        : null;
    final optionalServices = _optionalServices?.isNotEmpty ?? false
        ? _optionalServices
            ?.map((final e) => e.toLowerCase())
            .toList(growable: false)
        : null;
    final optionalManufacturerData =
        _optionalManufacturerData?.isNotEmpty ?? false
            ? _optionalManufacturerData
            : null;

    return RequestOptions.create(
      filters: filters,
      exclusionFilters: exclusionFilters,
      optionalServices: optionalServices,
      optionalManufacturerData: optionalManufacturerData,
      acceptAllDevices: _acceptAllDevices,
    );
  }
}

///
/// A filter to match on service data.
/// This can be used to define the services that the device should have before
/// being able to communicate with it.
///
@Deprecated(
    "These filters are not yet stable, so may change or not work at all")
class ServiceDataFilterBuilder {
  final String _service;
  final Uint8List? _dataPrefix;
  final Uint8List? _mask;

  ///
  /// Create a new service filter.
  ///
  /// [service] must be a UUID of the service that should exist.
  ///
  /// [dataPrefix] is a uint8 (or byte) array of the first n bytes of the UUID
  /// that should exist for the service. For example if you have the UUID
  /// `D273346A-...` then the prefix of `D273` should match
  ///
  /// [mask] is a uint8 (or byte) array of the bits that should be matched against.
  /// The original UUID will be bit wise and (&) as well as the [dataPrefix] to
  /// the same [mask]. These two will then be compared to be equal.
  ///
  @Deprecated(
      "These filters are not yet stable, so may change or not work at all")
  ServiceDataFilterBuilder(
      {required final String service,
      final Uint8List? dataPrefix,
      final Uint8List? mask})
      : _service = service,
        _dataPrefix = dataPrefix,
        _mask = mask;

  ///
  /// Convert the filter to an actual [BluetoothServiceDataFilter] for the
  /// [RequestOptions].
  ///
  BluetoothServiceDataFilter toServiceDataFilter() =>
      BluetoothServiceDataFilter.create(
          service: _service, dataPrefix: _dataPrefix, mask: _mask);
}

///
/// A filter for matching the manufacturer data of the device.
/// This can be used to define the services that the device should have before
/// being able to communicate with it.
///
///
///  **NOTE:** Some manufacturer data is on a block list, and is thus not available.
///  The complete blocklist can be found here:
///  https://github.com/WebBluetoothCG/registries/blob/master/manufacturer_data_blocklist.txt
///
class ManufacturerDataFilterBuilder {
  ///
  /// The 16 bit identifier of the company that either made the device, or more
  /// often the bluetooth chip that the device uses.
  ///
  /// See the full list of company identifiers
  /// [here](https://www.bluetooth.com/specifications/assigned-numbers/company-identifiers/).
  ///
  final int _companyIdentifier;
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
      {required final int companyIdentifier,
      final Uint8List? dataPrefix,
      final Uint8List? mask})
      : _companyIdentifier = companyIdentifier,
        _dataPrefix = dataPrefix,
        _mask = mask {
    if (companyIdentifier < 0 || companyIdentifier > 0xFFFF) {
      throw ArgumentError(
          "The company identifier must fit in 16-bits, so greater than 0 and smaller than 0xFFFF (65535)",
          "companyIdentifier");
    }
  }

  ///
  /// Convert the filter to an actual [BluetoothManufacturerDataFilter] for the
  /// [RequestOptions].
  ///
  BluetoothManufacturerDataFilter toManufacturerDataFilter() =>
      BluetoothManufacturerDataFilter.create(
          companyIdentifier: _companyIdentifier,
          dataPrefix: _dataPrefix,
          mask: _mask);
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
  /// **NOTE:** For [services]\: Some services are on a block list,
  /// and are thus not available. The complete blocklist can be found here:
  /// https://github.com/WebBluetoothCG/registries/blob/master/gatt_blocklist.txt
  ///
  /// [manufacturerData] is a list of [ManufacturerDataFilterBuilder]
  /// for what the manufacture data of the device should match before it shows
  /// up in the available devices list. Note that if you set multiple manufacturer
  /// data filters then a single device must match all of them.
  ///
  ///  **NOTE:** For [manufacturerData]\: Some manufacturer data is on a
  ///  block list, and is thus not available. The complete blocklist can be found here:
  ///  https://github.com/WebBluetoothCG/registries/blob/master/manufacturer_data_blocklist.txt
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
      {final String? name,
      final String? namePrefix,
      final List<String>? services,
      final List<ManufacturerDataFilterBuilder>? manufacturerData,
      //ignore: deprecated_member_use_from_same_package
      final List<ServiceDataFilterBuilder>? serviceData})
      : _name = name,
        _namePrefix = namePrefix,
        _services = services,
        _manufacturerData = manufacturerData,
        _serviceData = serviceData {
    if (_name == null &&
        _namePrefix == null &&
        (_services == null || _services.isEmpty) &&
        (_manufacturerData == null || _manufacturerData.isEmpty) &&
        (_serviceData == null || _serviceData.isEmpty)) {
      throw StateError(
          "No filter parameters have been set, you may want to use "
          "[RequestOptionsBuilder.acceptAllDevices()]!");
    }
    if (_services?.isEmpty ?? false) {
      throw StateError(
          "Filter service is empty, consider setting it to null instead.");
    }
  }

  ///
  /// convert to an actual [BluetoothScanFilter] Javascript object for the web
  /// api call.
  ///
  BluetoothScanFilter toScanFilter() => BluetoothScanFilter.create(
      services: _services,
      name: _name,
      namePrefix: _namePrefix,
      manufacturerData: _manufacturerData
          ?.map((final e) => e.toManufacturerDataFilter())
          .toList(),
      serviceData:
          _serviceData?.map((final e) => e.toServiceDataFilter()).toList());
}
