part of "../../js_web_bluetooth.dart";

///
/// This is the object that is emitted for the `availabilitychanged` event.
/// This object only has the specific fields for the event and not the fields
/// form the basic javascript [Event] (target field and all that stuff).
///
/// See:
///
/// - https://webbluetoothcg.github.io/web-bluetooth/#valueevent
///
extension type WebBluetoothValueEvent<T extends JSAny>._(JSObject _)
    implements JSObject, Event {
  ///
  /// The current value
  ///
  external T get value;
}
