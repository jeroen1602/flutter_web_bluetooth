// ignore_for_file: avoid_unused_constructor_parameters

import "dart:typed_data";

///
/// A stub implementation of @JS from dart  js_interop to make sure that the code
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
/// A stub implementation of @anonymous from dart js_interop to make sure that the code
/// will at least compile for native builds.
///
class _Anonymous {
  const _Anonymous();
}

///
/// A stub implementation of @anonymous from dart js_interop to make sure that the code
/// will at least compile for native builds.
/// ignore: library_private_types_in_public_api
const _Anonymous anonymous = _Anonymous();

///
/// A stub implementation for [JSAny] from dart js_interop to make sure that the code
/// will at least compile for native builds.
///
abstract class JSAny extends Object {
  ///
  /// A stub implementation for [isUndefinedOrNull] from dart js_interop to make sure that the code
  /// will at least compile for native builds.
  ///
  bool get isUndefinedOrNull => true;

  ///
  /// A stub implementation for [isDefinedAndNotNull] from dart js_interop to make sure that the code
  /// will at least compile for native builds.
  ///
  bool get isDefinedAndNotNull => !isUndefinedOrNull;
}

///
/// A stub implementation for [JSObject] from dart js_interop to make sure that the code
/// will at least compile for native builds.
///
abstract class JSObject extends JSAny {
  ///
  /// A stub implementation for [setProperty] from dart js_interop_unsafe to make sure that the code
  /// will at least compile for native builds.
  ///
  void setProperty(final JSAny property, final JSAny? value) {
    throw UnimplementedError();
  }

  ///
  /// A stub implementation for [hasProperty] from dart js_interop_unsafe to make sure that the code
  /// will at least compile for native builds.
  ///
  JSBoolean hasProperty(final JSAny property) {
    throw UnimplementedError();
  }

  ///
  /// A stub implementation for [has] from dart js_interop_unsafe to make sure that the code
  /// will at least compile for native builds.
  ///
  bool has(final String property) => hasProperty(property.toJS).toDart;

  ///
  /// A stub implementation for [getProperty] from dart js_interop_unsafe to make sure that the code
  /// will at least compile for native builds.
  ///
  T getProperty<T extends JSAny?>(final JSAny property) {
    throw UnimplementedError();
  }

  ///
  /// A stub implementation for [JSObject] from dart js_interop to make sure that the code
  /// will at least compile for native builds.
  ///
  factory JSObject() {
    throw UnimplementedError();
  }
}

///
/// A stub implementation for [JSNumber] from dart js_interop to make sure that the code
/// will at least compile for native builds.
///
abstract class JSNumber extends JSAny {
  ///
  /// A stub implementation for [toDartDouble] from dart js_interop to make sure that the code
  /// will at least compile for native builds.
  ///
  double get toDartDouble {
    throw UnimplementedError();
  }

  ///
  /// A stub implementation for [toDartInt] from dart js_interop to make sure that the code
  /// will at least compile for native builds.
  ///
  int get toDartInt {
    throw UnimplementedError();
  }
}

///
/// A stub implementation for [JSBoolean] from dart js_interop to make sure that the code
/// will at least compile for native builds.
///
abstract class JSBoolean extends JSAny {
  ///
  /// A stub implementation for [toDart] from dart js_interop to make sure that the code
  /// will at least compile for native builds.
  ///
  bool get toDart {
    throw UnimplementedError();
  }
}

///
/// A stub implementation for [JSString] from dart js_interop to make sure that the code
/// will at least compile for native builds.
///
abstract class JSString extends JSAny {
  ///
  /// A stub implementation for [toDart] from dart js_interop to make sure that the code
  /// will at least compile for native builds.
  ///
  String get toDart {
    throw UnimplementedError();
  }
}

///
/// A stub implementation for [JSArray] from dart js_interop to make sure that the code
/// will at least compile for native builds.
///
abstract class JSArray<T extends JSAny?> extends JSAny {
  ///
  /// A stub implementation for [toDart] from dart js_interop to make sure that the code
  /// will at least compile for native builds.
  ///
  List<T> get toDart {
    throw UnimplementedError();
  }
}

///
/// A stub implementation for [JSArrayBuffer] from dart js_interop to make sure that the code
/// will at least compile for native builds.
///
abstract class JSArrayBuffer extends JSObject {
  ///
  /// A stub implementation for [toDart] from dart js_interop to make sure that the code
  /// will at least compile for native builds.
  ///
  ByteBuffer get toDart {
    throw UnimplementedError();
  }

  ///
  /// A stub implementation for [JSArrayBuffer] from dart js_interop to make sure that the code
  /// will at least compile for native builds.
  ///
  factory JSArrayBuffer() {
    throw UnimplementedError();
  }
}

///
/// A stub implementation for [JSDataView] from dart js_interop to make sure that the code
/// will at least compile for native builds.
///
abstract class JSDataView extends JSObject {
  ///
  /// A stub implementation for [toDart] from dart js_interop to make sure that the code
  /// will at least compile for native builds.
  ///
  ByteData get toDart {
    throw UnimplementedError();
  }

  ///
  /// A stub implementation for [JSDataView] from dart js_interop to make sure that the code
  /// will at least compile for native builds.
  ///
  factory JSDataView() {
    throw UnimplementedError();
  }
}

///
/// A stub implementation for [JSPromise] from dart js_interop to make sure that the code
/// will at least compile for native builds.
///
abstract class JSPromise<T extends JSAny?> implements JSObject {
  ///
  /// A stub implementation for [JSPromise] from dart js_interop to make sure that the code
  /// will at least compile for native builds.
  ///
  factory JSPromise(final JSFunction executor) {
    throw UnimplementedError();
  }

  ///
  /// A stub implementation for [toDart] from dart js_interop to make sure that the code
  /// will at least compile for native builds.
  ///
  Future<T> get toDart {
    throw UnimplementedError();
  }
}

///
/// A stub implementation for [JSFunction] from dart js_interop to make sure that the code
/// will at least compile for native builds.
///
abstract class JSFunction extends JSObject {
  ///
  /// A stub implementation for [JSFunction] from dart js_interop to make sure that the code
  /// will at least compile for native builds.
  ///
  factory JSFunction() {
    throw UnimplementedError();
  }
}

///
/// A stub implementation for [ListToJSArray] from dart js_interop to make sure that the code
/// will at least compile for native builds.
///
extension ListToJSArray<T extends JSAny?> on List<T> {
  ///
  /// A stub implementation for [toJS] from dart js_interop to make sure that the code
  /// will at least compile for native builds.
  ///
  JSArray<T> get toJS {
    throw UnimplementedError();
  }
}

///
/// A stub implementation for [StringToJSString] from dart js_interop to make sure that the code
/// will at least compile for native builds.
///
extension StringToJSString on String {
  ///
  /// A stub implementation for [toJS] from dart js_interop to make sure that the code
  /// will at least compile for native builds.
  ///
  JSString get toJS {
    throw UnimplementedError();
  }
}

///
/// A stub implementation for [IntToJSNumber] from dart js_interop to make sure that the code
/// will at least compile for native builds.
///
extension IntToJSNumber on int {
  ///
  /// A stub implementation for [toJS] from dart js_interop to make sure that the code
  /// will at least compile for native builds.
  ///
  JSNumber get toJS {
    throw UnimplementedError();
  }
}

///
/// A stub implementation for [DoubleToJSNumber] from dart js_interop to make sure that the code
/// will at least compile for native builds.
///
extension DoubleToJSNumber on double {
  ///
  /// A stub implementation for [toJS] from dart js_interop to make sure that the code
  /// will at least compile for native builds.
  ///
  JSNumber get toJS {
    throw UnimplementedError();
  }
}

///
/// A stub implementation for [BoolToJSBoolean] from dart js_interop to make sure that the code
/// will at least compile for native builds.
///
extension BoolToJSBoolean on bool {
  ///
  /// A stub implementation for [toJS] from dart js_interop to make sure that the code
  /// will at least compile for native builds.
  ///
  JSBoolean get toJS {
    throw UnimplementedError();
  }
}

///
/// A stub implementation for [NullableUndefineableJSAnyExtension] from dart js_interop to make sure that the code
/// will at least compile for native builds.
///
extension NullableUndefineableJSAnyExtension on JSAny? {
  ///
  /// A stub implementation for [isUndefinedOrNull] from dart js_interop to make sure that the code
  /// will at least compile for native builds.
  ///
  bool get isUndefinedOrNull => this == null;

  ///
  /// A stub implementation for [isDefinedAndNotNull] from dart js_interop to make sure that the code
  /// will at least compile for native builds.
  ///
  bool get isDefinedAndNotNull => !isUndefinedOrNull;
}

///
/// A stub implementation for [ByteBufferToJSArrayBuffer] from dart js_interop to make sure that the code
/// will at least compile for native builds.
///
extension ByteBufferToJSArrayBuffer on ByteBuffer {
  ///
  /// A stub implementation for [toJS] from dart js_interop to make sure that the code
  /// will at least compile for native builds.
  ///
  JSArrayBuffer get toJS {
    throw UnimplementedError();
  }
}

///
/// A stub implementation for [FutureToJSPromise] from dart js_interop to make sure that the code
/// will at least compile for native builds.
///
extension FutureToJSPromise<T extends JSAny?> on Future<T> {
  ///
  /// A stub implementation for [toJS] from dart js_interop to make sure that the code
  /// will at least compile for native builds.
  ///
  JSPromise<T> get toJS {
    throw UnimplementedError();
  }
}

///
/// A stub implementation for [FutureToJSPromise2] from dart js_interop to make sure that the code
/// will at least compile for native builds.
///
extension FutureToJSPromise2<T> on Future<T> {
  ///
  /// A stub implementation for [toJS] from dart js_interop to make sure that the code
  /// will at least compile for native builds.
  ///
  JSPromise get toJS {
    throw UnimplementedError();
  }
}

///
/// A stub implementation for [FunctionToJSFunction] from dart js_interop to make sure that the code
/// will at least compile for native builds.
///
extension FunctionToJSFunction on Function {
  ///
  /// A stub implementation for [toJS] from dart js_interop to make sure that the code
  /// will at least compile for native builds.
  ///
  JSFunction get toJS {
    throw UnimplementedError();
  }
}

// region WEB:

///
/// A stub implementation for [EventListener] from the dart web package to make sure that the code
/// will at least compile for native builds.
///
typedef EventListener = JSFunction;

///
/// A stub implementation for [window] from the dart web package to make sure that the code
/// will at least compile for native builds.
///
Window get window {
  throw UnimplementedError();
}

///
/// A stub implementation for [Window] from the dart web package to make sure that the code
/// will at least compile for native builds.
///
extension type Window._(JSObject _) implements JSObject {
  ///
  /// A stub implementation for [navigator] from the dart web package to make sure that the code
  /// will at least compile for native builds.
  ///
  Navigator get navigator {
    throw UnimplementedError();
  }
}

///
/// A stub implementation for [Navigator] from the dart web package to make sure that the code
/// will at least compile for native builds.
///
extension type Navigator._(JSObject _) implements JSObject {}

///
/// A stub implementation for [EventTarget] from the dart web package to make sure that the code
/// will at least compile for native builds.
///
extension type EventTarget._(JSObject _) implements JSObject {
  ///
  /// A stub implementation for [addEventListener] from the dart web package to make sure that the code
  /// will at least compile for native builds.
  ///
  void addEventListener(
    final String type,
    final EventListener? callback, [
    final JSAny? options,
  ]) {
    throw UnimplementedError();
  }

  ///
  /// A stub implementation for [removeEventListener] from the dart web package to make sure that the code
  /// will at least compile for native builds.
  ///
  void removeEventListener(
    final String type,
    final EventListener? callback, [
    final JSAny? options,
  ]) {
    throw UnimplementedError();
  }
}

///
/// A stub implementation for [EventListenerOptions] from the dart web package to make sure that the code
/// will at least compile for native builds.
///
abstract class EventListenerOptions implements JSObject {
  ///
  /// A stub implementation for [EventListenerOptions] from the dart web package to make sure that the code
  /// will at least compile for native builds.
  ///
  factory EventListenerOptions({final bool? capture}) {
    throw UnimplementedError();
  }

  ///
  /// A stub implementation for [capture] from the dart web package to make sure that the code
  /// will at least compile for native builds.
  ///
  bool capture = false;
}

///
/// A stub implementation for [AddEventListenerOptions] from the dart web package to make sure that the code
/// will at least compile for native builds.
///
abstract class AddEventListenerOptions extends EventListenerOptions
    implements JSObject {
  ///
  /// A stub implementation for [AddEventListenerOptions] from the dart web package to make sure that the code
  /// will at least compile for native builds.
  ///
  factory AddEventListenerOptions({
    final bool? capture,
    final bool? passive,
    final bool? once,
    final AbortSignal? signal,
  }) {
    throw UnimplementedError();
  }

  ///
  /// A stub implementation for [passive] from the dart web package to make sure that the code
  /// will at least compile for native builds.
  ///
  bool passive = false;

  ///
  /// A stub implementation for [once] from the dart web package to make sure that the code
  /// will at least compile for native builds.
  ///
  bool once = false;

  ///
  /// A stub implementation for [signal] from the dart web package to make sure that the code
  /// will at least compile for native builds.
  ///
  AbortSignal? signal;
}

///
/// A stub implementation for [AbortController] from the dart web package to make sure that the code
/// will at least compile for native builds.
///
abstract class AbortController implements JSObject {
  ///
  /// A stub implementation for [abort] from the dart web package to make sure that the code
  /// will at least compile for native builds.
  ///
  void abort([final JSAny? reason]) {
    throw UnimplementedError();
  }

  ///
  /// A stub implementation for [signal] from the dart web package to make sure that the code
  /// will at least compile for native builds.
  ///
  AbortSignal get signal {
    throw UnimplementedError();
  }

  ///
  /// A stub implementation for [AbortController] from the dart web package to make sure that the code
  /// will at least compile for native builds.
  ///
  factory AbortController() {
    throw UnimplementedError();
  }
}

///
/// A stub implementation for [AbortSignal] from the dart web package to make sure that the code
/// will at least compile for native builds.
///
extension type AbortSignal._(JSObject _) implements EventTarget, JSObject {
  ///
  /// A stub implementation for [abort] from the dart web package to make sure that the code
  /// will at least compile for native builds.
  ///
  static AbortSignal abort([final JSAny? reason]) {
    throw UnimplementedError();
  }

  ///
  /// A stub implementation for [timeout] from the dart web package to make sure that the code
  /// will at least compile for native builds.
  ///
  static AbortSignal timeout(final int timeout) {
    throw UnimplementedError();
  }

  ///
  /// A stub implementation for [any] from the dart web package to make sure that the code
  /// will at least compile for native builds.
  ///
  static AbortSignal any(final JSArray<AbortSignal> signals) {
    throw UnimplementedError();
  }

  ///
  /// A stub implementation for [aborted] from the dart web package to make sure that the code
  /// will at least compile for native builds.
  ///
  bool get aborted => true;

  ///
  /// A stub implementation for [reason] from the dart web package to make sure that the code
  /// will at least compile for native builds.
  ///
  JSAny? get reason => null;
}

///
/// A stub implementation for [Event] from the dart web package to make sure that the code
/// will at least compile for native builds.
///
extension type Event._(JSObject _) implements JSObject {}

///
/// A stub implementation for [EventStreamProvider] from the dart web package to make sure that the code
/// will at least compile for native builds.
///
class EventStreamProvider<T extends Event> {
  // ignore: unused_field
  final String _eventType;

  ///
  /// A stub implementation for [EventStreamProvider] from the dart web package to make sure that the code
  /// will at least compile for native builds.
  ///
  const EventStreamProvider(this._eventType);

  ///
  /// A stub implementation for [forTarget] from the dart web package to make sure that the code
  /// will at least compile for native builds.
  ///
  Stream<T> forTarget(final EventTarget? e, {final bool useCapture = false}) {
    throw UnimplementedError();
  }
}

// endregion
