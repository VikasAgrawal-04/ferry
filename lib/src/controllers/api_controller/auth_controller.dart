import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:goa/services/api_services/auth_services.dart';
import 'package:goa/src/core/utils/constants/keys.dart';
import 'package:goa/src/core/utils/helpers/helpers.dart';

import '../../../services/routing_services/routes.dart';

class AuthController extends GetxController {
  final Dio dio;
  AuthController({required this.dio});
  late final AuthServices _services = AuthServices(dio: dio);

  Future<bool> login({required String number, required String password}) async {
    bool success = true;
    final successOrFailure =
        await _services.login(number: number, password: password);
    successOrFailure.fold((l) => debugPrint("Failure In Login $l"), (r) async {
      if (r.success) {
        if (r.data?.isotpverified == "1") {
          EasyLoading.showSuccess(r.message);
          await Helpers.setString(
              key: Keys.userData, value: jsonEncode(r.data));
          await Helpers.setString(
              key: Keys.userId, value: r.data!.userid.toString());
          Get.offAndToNamed(AppRoutes.dashboard);
        } else {
          EasyLoading.showInfo("Please Complete OTP Verification");
          Get.toNamed(AppRoutes.otp, arguments: number);
        }
        success = true;
      } else {
        success = false;
        Helpers.deleteString(key: Keys.userData);
        EasyLoading.showError(r.message);
      }
    });
    return success;
  }

  Future<bool> register(
      {required String name,
      required String number,
      required String password}) async {
    bool success = true;
    final successOrFailure = await _services.register(
        name: name, number: number, password: password);
    successOrFailure.fold((l) => debugPrint("Failure In Login $l"), (r) async {
      if (r.success) {
        EasyLoading.showSuccess("OTP Sent!");
        Get.toNamed(AppRoutes.otp, arguments: number);
      } else {
        success = false;
        EasyLoading.showError(r.message);
        Get.back();
      }
    });
    return success;
  }

  Future<bool> verfiyOtp(
      {required String number,
      required String otp,
      bool forgot = false}) async {
    EasyLoading.show();
    bool success = true;
    final successOrFailure =
        await _services.verfiyOtp(number: number, otp: otp);
    successOrFailure.fold((l) => debugPrint("Failure In Login $l"), (r) {
      if (r['success']) {
        success = true;
        EasyLoading.showSuccess(r['message']);
        if (forgot == false) {
          Get.offAllNamed(AppRoutes.login);
        } else {
          Get.toNamed(AppRoutes.newPass, arguments: number);
        }
      } else {
        success = false;
        EasyLoading.showError(r['message']);
      }
    });
    EasyLoading.dismiss();
    return success;
  }

  Future<bool> resendOtp({required String number}) async {
    bool success = false;
    final failureOrSuccess = await _services.resendOtp(number: number);
    failureOrSuccess.fold((l) => debugPrint("Failure In Login $l"), (r) {
      if (r['success']) {
        success = true;
        EasyLoading.showSuccess(r['message']);
      } else {
        EasyLoading.showError(r['message']);
      }
    });
    return success;
  }

  Future<void> changePassword(
      {required String oldPass, required String newPass}) async {
    final failureOrSuccess =
        await _services.changePassword(oldPass: oldPass, newPass: newPass);
    failureOrSuccess.fold((l) => debugPrint("Failure In Login $l"), (r) {
      if (r['success']) {
        EasyLoading.showSuccess(r['message']);
        Get.back();
      } else {
        EasyLoading.showError(r['message']);
      }
    });
  }

  Future<void> createNewPassword(
      {required String mobile, required String pass}) async {
    final failureOrSuccess =
        await _services.createNewPassword(mobile: mobile, pass: pass);
    failureOrSuccess.fold((l) => debugPrint("Failure In Create Password $l"),
        (r) {
      if (r['success']) {
        EasyLoading.showSuccess(r['message']);
        Get.offAllNamed(AppRoutes.login);
      } else {
        EasyLoading.showError(r['message']);
      }
    });
  }
}
