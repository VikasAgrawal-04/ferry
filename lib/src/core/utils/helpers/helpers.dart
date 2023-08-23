import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:goa/src/core/utils/errors/exception.dart';
import 'package:goa/src/core/utils/errors/failures.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum RequestType { get, post, delete }

enum LoggerType { d, e, i, f, t, w }

enum ProgressLabourType { prw, labour }

enum SnagsType { n, o, c }

enum AreaType { pending, resolved, read }

class Helpers {
  static SharedPreferences? prefs;

  static validateEmail(String value) {
    if (value.isEmpty) {
      return "Field Required";
    }
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@'
        r'((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]'
        r'+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(p);
    if (regExp.hasMatch(value)) {
      return null;
    }
    return 'invalid email';
  }

  static validateField(String value) {
    if (value.isEmpty || value == 'null') {
      return "Field Required";
    }
    return null;
  }

  static validatePhone(String value) {
    if (value.length < 10 || value.length > 10) {
      return 'Please Enter Valid Mobile Number';
    } else {
      return null;
    }
  }

  static validatePassword(String value) {
    if (value.length < 4) {
      return 'Password should be minimum 4 characters long';
    } else {
      return null;
    }
  }

  static validateDate(DateTime? value) {
    if (value == null) {
      return "Please select date";
    }
    return null;
  }

  static validateTime(DateTime? value) {
    if (value == null) {
      return "Please select time";
    }
    return null;
  }

  static logger({required LoggerType type, required String message}) {
    var logger = Logger(
        printer: PrettyPrinter(
      methodCount: 5,
      errorMethodCount: 8,
      lineLength: 5000,
      colors: true,
      printEmojis: true,
      printTime: false,
    ));

    switch (type) {
      case LoggerType.d:
        logger.d(message);
        break;
      case LoggerType.e:
        logger.e(message);
        break;
      case LoggerType.i:
        logger.i(message);
        break;
      case LoggerType.f:
        logger.f(message);
        break;
      case LoggerType.t:
        logger.t(message);
        break;
      case LoggerType.w:
        logger.w(message);
        break;
    }
  }

  static Future<Map<String, dynamic>?> sendRequest(
      Dio dio, RequestType type, String path,
      {Map<String, dynamic>? queryParams,
      Map<String, dynamic>? headers,
      bool encoded = false,
      dynamic data,
      dynamic listData,
      FormData? formData}) async {
    var logger = Logger(
      printer: PrettyPrinter(
          methodCount: 2,
          errorMethodCount: 8,
          lineLength: 50,
          colors: true,
          printEmojis: true,
          printTime: false),
    );
    logger.d("PayLoad ${queryParams ?? data ?? listData}");
    try {
      Response response;

      switch (type) {
        case RequestType.get:
          response = (await dio.get(path,
              queryParameters: queryParams,
              options: Options(headers: headers)));
          break;
        case RequestType.post:
          response = (await dio.post(
            path,
            options: Options(
                headers: headers,
                contentType:
                    encoded == true ? Headers.formUrlEncodedContentType : null,
                validateStatus: (code) => true),
            data: queryParams ?? listData ?? formData ?? FormData.fromMap(data),
          ));
          break;

        case RequestType.delete:
          response = (await dio.delete(path,
              queryParameters: queryParams,
              options: Options(headers: headers)));
          break;
        default:
          return null;
      }

      logger.d(
          "$path response status code ${response.statusCode} message is ${response.statusMessage}");

      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      } else if (response.statusCode == 400 || response.statusCode == 202) {
        logger.e(
            "Failed response ${response.data} and ${response.statusMessage} and ${response.statusCode} ");
        throw ServerException(
            code: response.statusCode, message: response.statusMessage);
      } else {
        debugPrint("I go here 1");
        debugPrint("statuscode${response.statusCode.toString()}");
        debugPrint(response.statusMessage.toString());
        throw ServerException(
            message:
                response.data['message'] ?? response.data['errors']['message'],
            code: response.statusCode);
      }
    } on ServerException catch (e) {
      debugPrint("I go here 2");
      throw ServerException(message: e.message, code: e.code);
    } on DioError catch (e) {
      if (e.error == "Http status error [401]") {
        debugPrint("I go here 3 ${e.error == "Http status error [401]"}");
      } else {
        throw ServerException(
            message: e.error is SocketException
                ? "No Internet"
                : e.error.toString());
      }
    }
    return null;
  }

  static String convertFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return failure.message;
    }
    return "Unknown error occured";
  }

  static setString({required String key, required String value}) async {
    await prefs?.setString(key, value);
  }

  static deleteString({required key}) {
    prefs?.remove(key);
  }

  static String? getString({required String key}) {
    return prefs?.getString(key);
  }

  static Image imgFromBase64(String base64) {
    return Image.memory(base64Decode(base64));
  }

  static String formattedDate(DateTime date) {
    final formattedDate = DateFormat('dd MMM yyyy').format(date);
    return formattedDate;
  }
}

class NumberInputFormat extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.contains('.')) {
      return oldValue;
    } else if (newValue.text.contains(RegExp(r'[^\d]'))) {
      return oldValue;
    }
    return newValue;
  }
}
