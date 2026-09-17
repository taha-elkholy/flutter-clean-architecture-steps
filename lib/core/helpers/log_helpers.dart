import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';

/// `dart:developer` gives [name] its own column in the console, so one source
/// can be filtered out of the noise, and it does not truncate a long message.
void debugLog(String name, String message) {
  if (!kDebugMode) return;
  developer.log(message, name: name);
}
