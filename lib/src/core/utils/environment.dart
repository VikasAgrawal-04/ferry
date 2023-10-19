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

  static String get paytmBaseUrl =>
      dotenv.env['PAYTM_BASE_URL'] ?? "PAYTM_BASE_URL NOT FOUND";

  static String get mid {
    return dotenv.env['PAYTM_MERCHANT_ID'] ?? "PAYTM_MERCHANT_ID NOT FOUND";
  }

  static String get mkey =>
      dotenv.env['PAYTM_MERCHANT_KEY'] ?? "PAYTM_MERCHANT_KEY NOT FOUND";
}
