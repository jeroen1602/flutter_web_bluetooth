part of flutter_web_bluetooth;

class RequestOptionsBuilder {
  final bool _acceptAllDevices;
  final List<RequestFilterBuilder> _requestFilters;
  final List<String>? _optionalServices;

  ///
  /// May throw [StateError] if no filters are set, consider using
  /// [RequestOptionsBuilder.acceptAllDevices].
  RequestOptionsBuilder(List<RequestFilterBuilder> requestFilters,
      {List<String>? optionalServices})
      : this._requestFilters = requestFilters,
        this._acceptAllDevices = false,
        this._optionalServices = optionalServices {
    if (this._requestFilters.isEmpty) {
      throw StateError('No filters have been set, consider using '
          'RequestOptionsBuilder.acceptAllDevices() instead.');
    }
  }

  RequestOptionsBuilder.acceptAllDevices({List<String>? optionalServices})
      : this._acceptAllDevices = true,
        this._requestFilters = [],
        this._optionalServices = optionalServices;

  RequestOptions toRequestOptions() {
    final optionalService = this._optionalServices;
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

class RequestFilterBuilder {
  final String? _name;
  final String? _namePrefix;
  final List<String>? _services;

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

  BluetoothScanFilter toScanFilter() {
    return BluetoothScanFilterHelper.createJsObject(
        _services, _name, _namePrefix) as BluetoothScanFilter;
  }
}
