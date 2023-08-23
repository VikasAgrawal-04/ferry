import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goa/services/api_services/general_service.dart';

import '../models/info/app_info_model.dart';

class GeneralController extends GetxController {
  final Dio dio;
  GeneralController(this.dio);

  late final GeneralService _service = GeneralService(dio);

  //List Of App Information
  final appInfo = <AppInfoDatum>[].obs;

  Future<bool> getAppInfo() async {
    bool rtype = false;
    final failureOrSuccess = await _service.getAppInfo();
    failureOrSuccess.fold((l) => debugPrint("Failure In GetAppInfo"), (r) {
      appInfo.clear();
      if (r.success) {
        appInfo.addAll(r.data);
        rtype = true;
      }
    });
    return rtype;
  }
}
