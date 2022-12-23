import "dart:async";

///
/// A custom implementation for rxdart's behavior subject.
/// This is here to allow the project to remove Rxdart as a dependency.
/// It's also not a complete implementation that is ready for just anyone to use.
///
/// This should not be used in your own project!.
///
class WebBehaviorSubject<T> {
  ///
  /// The underlying stream controller that goes with this [WebBehaviorSubject].
  ///
  final StreamController<T> controller = StreamController.broadcast();
  T? _value;

  ///
  /// The last value that was emitted.
  ///
  T? get value => _value;

  ///
  /// Create a new [WebBehaviorSubject] with a starting value [seed].
  /// Otherwise it would start without a value.
  ///
  WebBehaviorSubject.seeded(final T seed) {
    add(seed);
  }

  ///
  /// Create a new [WebBehaviorSubject] without a starting value.
  /// See [WebBehaviorSubject.seeded] to start with an existing value.
  ///
  WebBehaviorSubject();

  ///
  /// Add a new value to emit.
  ///
  /// The old value will be replaced.
  ///
  void add(final T event) {
    _value = event;
    controller.add(event);
  }

  ///
  /// Will return the [Stream] from the [StreamController]
  ///
  /// Will also first return the stored value in [value] before returning the
  /// actual stream.
  ///
  Stream<T> get stream async* {
    if (_value != null) {
      yield _value!;
    }
    yield* controller.stream;
  }

  ///
  /// Check to see if the [WebBehaviorSubject] has a value in [value].
  ///
  bool get hasValue => _value != null;
}
