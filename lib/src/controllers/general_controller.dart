import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goa/services/api_services/general_service.dart';

class GeneralController extends GetxController {
  final Dio dio;
  GeneralController(this.dio);

  late final GeneralService _service = GeneralService(dio);

  Future<bool> getAppInfo(String title) async {
    bool rtype = false;
    final failureOrSuccess = await _service.getAppInfo(title);
    failureOrSuccess.fold((l) => debugPrint("Failure In GetAppInfo"), (r) {
      if (r['success']) {
        rtype = true;
      }
    });
    return rtype;
  }
}
