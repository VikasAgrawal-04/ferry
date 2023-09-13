import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goa/services/api_services/general_service.dart';

import '../../models/info/app_info_model.dart';
import '../../models/info/contact_info.dart';

class GeneralController extends GetxController {
  final Dio dio;
  GeneralController(this.dio);

  late final GeneralService _service = GeneralService(dio);

  //List Of App Information
  final appInfo = <AppInfoDatum>[].obs;
  final contactInfo = <ContactInfo>[].obs;

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

  Future<void> getContactInfo() async {
    final failureOrSuccess = await _service.getContactInfo();
    failureOrSuccess.fold((l) => debugPrint("Failure In GetContactInfo"), (r) {
      if (r.success) {
        contactInfo.clear();
        contactInfo.addAll(r.data);
      }
    });
  }
}
