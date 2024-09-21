import 'dart:convert';

import 'package:flutter/foundation.dart';

const JsonDecoder _decoder = JsonDecoder();
const JsonEncoder _encoder = JsonEncoder.withIndent('  ');

/// Print a message if in debug mode
void debug(Object? message) {
  if (kDebugMode) {
    print(message);
  }
}

/// Pretty print a JSON object with multiple print lines.
void prettyDebugJson(String input) {
  var object = _decoder.convert(input);
  String prettyString = _encoder.convert(object);
  prettyString.split('\n').forEach((element) => debug(element));
}
