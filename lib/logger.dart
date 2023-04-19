import 'package:flutter/foundation.dart';

class Logger {
  static log(String message) {
    if (kDebugMode) {
      print("======LOGS START======");
      print(message);
    }
  }
}
