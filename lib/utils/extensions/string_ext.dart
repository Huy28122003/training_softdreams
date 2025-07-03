import 'package:flutter/foundation.dart' show kDebugMode;

extension StringExt on String {
  String? get ifDebugging => kDebugMode ? this : null;

  String get capitalize {
    if (length < 1) return this;
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }

  bool equalsIgnoreCase(String other) {
    return toLowerCase() == other.toLowerCase();
  }
}
