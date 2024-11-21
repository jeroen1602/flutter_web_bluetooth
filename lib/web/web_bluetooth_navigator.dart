part of "../js_web_bluetooth.dart";

///
/// An extension on the [Navigator] from the dart web package.
///
/// This extension adds bluetooth to the navigator for this program to use.
///
extension on Navigator {
  @JS("bluetooth")
  external _NativeBluetooth get _bluetooth;
}
