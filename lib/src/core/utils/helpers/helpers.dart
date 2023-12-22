import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:goa/src/core/errors/exception.dart';
import 'package:goa/src/core/errors/failures.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

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

      if (response.statusCode == 200) {
        print(response.data.runtimeType);
        return response.data as Map<String, dynamic>;
      } else if (response.statusCode == 400 || response.statusCode == 202) {
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

  static Future<void> downloadQrImage(qrImg, String amount) async {
    final deviceInfo = await DeviceInfoPlugin().androidInfo;
    final directory;
    if (Platform.isAndroid) {
      directory = Directory('/storage/emulated/0/Download');
    } else {
      directory = await getDownloadsDirectory();
    }

    // Check for permissions
    if (Platform.isAndroid && deviceInfo.version.sdkInt > 32) {
      if (await Permission.photos.isGranted) {
        final file = await File(
                '${directory?.path}/₹$amount&time=${formatDateTime(DateTime.now())}.png')
            .create();

        // Write the base64 image to the file
        await file.writeAsBytes(
            Uint8List.fromList(base64Decode(qrImg.split(',').last)));

        // Show a snackbar to the user
        EasyLoading.showSuccess(
            'QR image downloaded successfully! \n Please Check Your Downloads For The QR');
      } else {
        EasyLoading.showError(
            'Storage permission is required to download the QR image.');
        await Permission.photos.request();
      }
    } else if (Platform.isAndroid && deviceInfo.version.sdkInt < 32) {
      if (await Permission.storage.request().isGranted) {
        final file = await File(
                '${directory?.path}/₹$amount&time=${formatDateTime(DateTime.now())}.png')
            .create();

        // Write the base64 image to the file
        await file.writeAsBytes(
            Uint8List.fromList(base64Decode(qrImg.split(',').last)));

        // Show a snackbar to the user
        EasyLoading.showSuccess(
            'QR image downloaded successfully! \n Please Check Your Downloads For The QR');
      } else {
        EasyLoading.showError(
            'Storage permission is required to download the QR image.');
        await Permission.storage.request();
      }
    }
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
    return Image.memory(
      base64Decode(base64),
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) return child;
        return AnimatedOpacity(
          opacity: frame == null ? 0 : 1,
          duration: const Duration(seconds: 2),
          curve: Curves.easeOut,
          child: child,
        );
      },
    );
  }

  static String subtractVersion(String version1, String version2) {
    List<int> v1Parts = version1.split('.').map(int.parse).toList();
    List<int> v2Parts = version2.split('.').map(int.parse).toList();

    int majorDiff = v1Parts[0] - v2Parts[0];
    int minorDiff = v1Parts[1] - v2Parts[1];
    int patchDiff = v1Parts[2] - v2Parts[2];

    String result = '$majorDiff.$minorDiff.$patchDiff';
    return result;
  }

  static bool isVersionGreater(String version1, String version2) {
    List<int> v1Parts = version1.split('.').map(int.parse).toList();
    List<int> v2Parts = version2.split('.').map(int.parse).toList();

    if (v1Parts[1] >= v2Parts[1]) {
      return true;
    } else {
      return false;
    }
  }

  static String formattedDate(DateTime date) {
    final formattedDate = DateFormat('dd MMM yyyy').format(date);
    return formattedDate;
  }

  static String formatTimeDate(DateTime date) {
    final formattedDate = DateFormat('dd MMM yyyy HH:mm:ss').format(date);
    return formattedDate;
  }

  static String formatDateTime(DateTime now) {
    DateFormat formatter = DateFormat("dd-MM-yy_HH_mm_ss");
    return formatter.format(now);
  }

  static Future<void> makeCall(String number) async {
    final url = Uri.parse('tel:$number');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  static Future<void> email(String email) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      query: encodeQueryParameters(<String, String>{
        'subject': 'Regarding return/refund',
      }),
    );
    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      throw 'Could not launch $emailLaunchUri';
    }
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
