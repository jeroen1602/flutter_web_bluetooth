part of js_web_bluetooth;

///
/// The [AbortController] can be used to create an [AbortSignal] this signal
/// can then be used for async tasks that may take longer like for example a
/// fetch. It can then be aborted earlier.
///
/// See:
///
/// - https://dom.spec.whatwg.org/#interface-abortcontroller
///
/// - https://developer.mozilla.org/en-US/docs/Web/API/AbortController/AbortController
///
@JS("window.AbortController")
class AbortController {
  ///
  /// Create a new instance of  the [AbortController].
  ///
  external factory AbortController();

  ///
  /// Get the [AbortSignal] that is connected to this controller.
  ///
  external AbortSignal get signal;

  ///
  /// Abort the signal with a [reason].
  /// This can be an [Error], but
  /// also a [string] or any other [Object] you may want.
  ///
  /// It is recommended to use an [Error] or a derived class of it to keep
  /// consistency.
  ///
  external void abort([final dynamic reason]);
}

///
/// The [AbortSignal] can be send with expensive calls so that they can be
/// canceled early.
///
/// See:
///
/// - https://dom.spec.whatwg.org/#abortsignal
///
/// - https://developer.mozilla.org/en-US/docs/Web/API/AbortSignal
///
@JS("window.AbortSignal")
class AbortSignal {
  ///
  /// Create a new abort signal that has already been aborted.
  /// The [reason] can be an [Error], but
  /// also a [string] or any other [Object] you may want.
  ///
  /// It is recommended to use an [Error] or a derived class of it to keep
  /// consistency
  ///
  external static AbortSignal abort([final dynamic reason]);

  ///
  /// Create a new [AbortSignal] that will automatically abort after
  /// the timeout in milliseconds.
  ///
  /// The timeout may not be negative
  external static AbortSignal timeout(final int milliseconds);

  ///
  /// If the signal has been aborted
  ///
  external bool get aborted;

  ///
  /// The reason why the signal has been aborted. This can be an [Error], but
  /// also a [string] or any other [Object] you may want.
  ///
  /// It is recommended to use an [Error] or a derived class of it to keep
  /// consistency.
  ///
  external dynamic get reason;

  ///
  /// Throw the object that is in [reason] as if it was an [Error].
  /// In JS you are allowed to throw what ever you want and it doesn't have to
  /// be an [Error] type.
  ///
  /// This may also contain an [string] if the error was caused by the rest of
  /// the js environment and it didn't happen inside of the dart environment.
  ///
  external void throwIfAborted();

  ///
  /// An event fired when the signal gets aborted.
  ///
  external void Function(dynamic) onabort;
}
