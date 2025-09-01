/// camelCase a name given from an input.
String camelCaseName(final String name) {
  var convertedName = name
      .replaceAll("-", " ")
      .replaceAll(".", " ")
      .replaceAll(",", " ")
      .replaceAll("&", "And")
      .replaceAll("/", " ")
      .replaceAll("+", " ")
      .replaceAll("(", " ")
      .replaceAll(")", " ")
      .replaceAll("（", " ")
      .replaceAll("）", " ")
      .replaceAll("\"", "")
      .replaceAll("“", "")
      .replaceAll("'", "")
      .replaceAll("|", " ")
      .replaceAll("!", " ")
      .replaceAll("¤", " ")
      .toLowerCase();

  convertedName = convertedName.replaceAllMapped(_textSubscript, (final match) {
    final number = match.group(1);
    return "$number";
  });

  convertedName = convertedName.replaceAllMapped(_numberRegex, (final match) {
    final number = int.parse(match.group(0)!, radix: 10);
    final asText = _numberMap[number];
    if (asText == null) {
      throw UnimplementedError("Could not convert $number to a string");
    }
    return "$asText ";
  });

  convertedName = convertedName.replaceAllMapped(_nonAscii, (final match) {
    final matchedText = match.group(0)!;
    final newText = _nonAsciiMap[matchedText];
    if (newText == null) {
      throw UnimplementedError(
        "Could not convert $matchedText to an ascii string",
      );
    }
    return newText;
  });

  final words = convertedName.split(" ");
  words.retainWhere((final element) => element.isNotEmpty);
  return words.reduce(
    (final value, final element) =>
        "$value${element[0].toUpperCase()}${element.substring(1)}",
  );
}

/// Remove commands like \\textsubscript{2} for just 2
String replaceReadableName(final String name) {
  final convertedName = name.replaceAllMapped(_textSubscript, (final match) {
    final number = match.group(1);
    return "$number";
  });

  return convertedName;
}

final _numberRegex = RegExp(r"(^\d+)");
final _nonAscii = RegExp(r"([^\x00-\x7F])");
final _textSubscript = RegExp(r"\\textsubscript{(\d+)}");

const _numberMap = {
  0: "zero",
  1: "one",
  2: "two",
  3: "three",
  4: "four",
  5: "five",
  6: "six",
  7: "seven",
  8: "eight",
  9: "nine",
  10: "ten",
  11: "eleven",
  12: "twelve",
  13: "thirteen",
  14: "fourteen",
  15: "fifteen",
  16: "sixteen",
  17: "seventeen",
  18: "eighteen",
  19: "nineteen",
  20: "twenty",
  70: "seventy",
  701: "seven hundred one",
  9313: "nine thousand three hundred thirteen",
  9374: "nine thousand three hundred seventy four",
  9512: "nine thousand five hundred twelve",
  2048450: "two million forty eight thousand four hundred fifty",
  2587702:
      "two million five hundred eighty seven thousand seven hundred and two",
  9974091: "nine million nine hundred seventy four thousand ninety one",
};

const _nonAsciiMap = {
  "ö": "o",
  "ó": "o",
  "ä": "a",
  "ã": "a",
  "é": "e",
  "ü": "u",
  "¶": "p",
  "©": "c",
};
