import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:goa/services/api_services/auth_services.dart';
import 'package:goa/src/core/utils/constants/keys.dart';
import 'package:goa/src/core/utils/helpers/helpers.dart';

class AuthController extends GetxController {
  final Dio dio;
  AuthController({required this.dio});
  late final AuthServices _services = AuthServices(dio: dio);

  Future<bool> login({required String number, required String password}) async {
    bool success = true;
    final successOrFailure =
        await _services.login(number: number, password: password);
    successOrFailure.fold((l) => debugPrint("Failure In Login $l"), (r) {
      if (r.success) {
        success = true;
        Helpers.setString(key: Keys.userData, value: jsonEncode(r.data));
        EasyLoading.showSuccess(r.message);
      } else {
        success = false;
        Helpers.deleteString(key: Keys.userData);
        EasyLoading.showError(r.message);
      }
    });
    return success;
  }
}
