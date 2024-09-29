import "dart:mirrors";

import "package:code_builder/code_builder.dart";

///
/// Write a value as a hex value.
///
LiteralExpression literalHex(final int input) {
  final mirror = reflectClass(LiteralExpression);
  final entry = mirror.declarations.entries.firstWhere((final x) =>
      x.value is MethodMirror && (x.value as MethodMirror).isConstructor);
  final constructor = entry.value as MethodMirror;

  return mirror.newInstance(constructor.constructorName,
      ["0x${input.toRadixString(16).toUpperCase()}"]).reflectee;
}

///
/// A string, but it uses double quotes!
///
Expression literalStringDouble(final String value) {
  final escaped = value.replaceAll("\"", "\\\"").replaceAll("\n", "\\n");
  final mirror = reflectClass(LiteralExpression);
  final entry = mirror.declarations.entries.firstWhere((final x) =>
      x.value is MethodMirror && (x.value as MethodMirror).isConstructor);
  final constructor = entry.value as MethodMirror;

  return mirror
      .newInstance(constructor.constructorName, ["\"$escaped\""]).reflectee;
}
