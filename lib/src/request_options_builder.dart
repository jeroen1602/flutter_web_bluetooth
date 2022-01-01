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
/// A helper to help create a [BluetoothScanFilter].
///
/// A device needs to match all the items in this filter before the browser
/// will allow it.
///
class RequestFilterBuilder {
  final String? _name;
  final String? _namePrefix;
  final List<String>? _services;

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
  /// May throw [StateError] if all the parameters are null or services list is
  /// empty.
  ///
  /// TODO: change this API to force the developer to enter at least one filter item
  RequestFilterBuilder(
      {String? name, String? namePrefix, List<String>? services})
      : _name = name,
        _namePrefix = namePrefix,
        _services = services {
    if (_name == null &&
        _namePrefix == null &&
        (_services == null || _services?.isEmpty == true)) {
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
    return BluetoothScanFilterHelper.createJsObject(
        _services, _name, _namePrefix) as BluetoothScanFilter;
  }
}
