import 'package:rxdart/rxdart.dart';
export 'package:rxdart/rxdart.dart';

/// Extensions to have consistent behavior for rxdart 0.26 and 0.27
extension TempRxValueStreamExtensions<T> on ValueStream<T> {
  /// Same as 0.26 [value], returns null if value is not set or null.
  ///
  /// Temp until rxdart 0.27 lands
  T? get valueOrNullCompat => hasValue ? value : null;

  /// Same as 0.27 [value], throws if no value is set.
  ///
  /// Temp until rxdart 0.27 lands
  T get valueCompat =>
      hasValue ? valueOrNullCompat! : throw ValueStreamError.hasNoValue();
}
