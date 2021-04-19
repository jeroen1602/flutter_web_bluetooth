part of native_web_bluetooth;

class NativeAPINotImplementedError extends UnsupportedError {
  NativeAPINotImplementedError(String method)
      : super('$method not supported in this user agent');
}
