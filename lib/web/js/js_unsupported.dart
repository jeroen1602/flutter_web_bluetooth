///
/// A stub implementation of @JS from dart js to make sure that the code
/// will at least compile for native builds.
///
class JS {
  ///
  /// The name of the javascript object. If left out the name of the class
  /// will be used.
  ///
  /// The name could for example be `navigator.Bluetooth` if it is nested
  /// inside another global variable.
  ///
  final String? name;

  ///
  /// Construct a new annotation
  ///
  const JS([this.name]);
}

///
/// A stub implementation of @anonymous from dart js to make sure that the code
/// will at least compile for native builds.
///
class _Anonymous {
  const _Anonymous();
}

///
/// A stub implementation of @anonymous from dart js to make sure that the code
/// will at least compile for native builds.
/// ignore: library_private_types_in_public_api
const _Anonymous anonymous = _Anonymous();
