///
/// This is where all the log messages of the library end up.
///
/// by default the messages will be printed to the web console/ terminal,
/// but if you want to do something special then you can overwrite the logger
/// using [setWebBluetoothLogger].
///
library web_bluetooth_logger;

import "dart:async";

import "package:logging/logging.dart";

///
/// The logger for messages generated by [js_web_bluetooth] and
/// [flutter_web_bluetooth].
///
/// This should only be used for these two libraries.
///
/// If no [Logger] has been set using [setWebBluetoothLogger] then it will
/// create a new default logger using [initWebBluetoothLogger].
///
Logger get webBluetoothLogger {
  if (_webLogger == null) {
    initWebBluetoothLogger();
  }
  return _webLogger!;
}

///
/// Overwrite the logger used so you can decide where the log messages go.
///
/// If you want to go back to the default logger at a later date then just call
/// [initWebBluetoothLogger] to overwrite the user set logger for the default one.
///
void setWebBluetoothLogger(final Logger logger) {
  _webLogger = logger;
  Future.sync(() async => await _subscription?.cancel());
  _subscription = null;
}

///
/// Initialize a default instance of [webBluetoothLogger]. This will be done
/// automatically the first time the logger is used. Unless [setWebBluetoothLogger] is
/// used to overwrite the default created logger.
///
void initWebBluetoothLogger() {
  final logger = Logger("flutter_web_bluetooth");
  Future.sync(() async => await _subscription?.cancel());
  _subscription = logger.onRecord.listen((final event) {
    // ignore: avoid_print
    print("${event.loggerName}: ${event.time}: ${event.message}");
  });
  _webLogger = logger;
}

///
/// The actual logger currently used.
///
/// Will start out as `null` but will be set by either [initWebBluetoothLogger]
/// or [setWebBluetoothLogger].
///
Logger? _webLogger;

///
/// The subscription that currently listens for new records being added to
/// the logger.
///
/// This is stored here to stop the subscription if [setWebBluetoothLogger]
/// is used.
///
StreamSubscription<LogRecord>? _subscription;
