import 'package:flutter/foundation.dart' show debugPrintThrottled;

class Logger {
  static void d(String? message) {
    _log("DEBUG: $message");
  }

  static void e(Object? error) {
    _log("Error: $error");
  }

  static void _log(String? message) {
    debugPrintThrottled(message, wrapWidth: 70);
  }
}