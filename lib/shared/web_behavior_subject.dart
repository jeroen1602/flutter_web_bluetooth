import 'dart:async';

///
/// A custom implementation for rxdart's behavior subject.
/// This is here to allow the project to remove Rxdart as a dependency.
/// It's also not a complete implementation that is ready for just anyone to use.
///
/// This should not be used in your own project!.
///
class WebBehaviorSubject<T> {
  final StreamController<T> controller = StreamController.broadcast();
  T? _value;

  T? get value => _value;

  WebBehaviorSubject.seeded(T seed) {
    add(seed);
  }

  WebBehaviorSubject();

  void add(T event) {
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

  bool get hasValue => _value != null;
}
