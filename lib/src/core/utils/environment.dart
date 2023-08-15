import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String get fileName {
    if (kReleaseMode) {
      log("Running on Production");
      return 'development.env';
    } else {
      log("Running on Development");
      return 'development.env';
    }
  }

  static String get apiBaseUrl {
    log("Running on ${dotenv.env['API_BASE_URL']}");
    return dotenv.env['API_BASE_URL'] ??
        "API_BASE_URL not found in environment";
  }
}
