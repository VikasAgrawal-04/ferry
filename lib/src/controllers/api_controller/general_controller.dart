import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:goa/services/api_services/general_service.dart';

import '../../models/info/app_info_model.dart';
import '../../models/info/contact_info.dart';
import '../network/network_controller.dart';

class GeneralController extends GetxController {
  final Dio dio;
  GeneralController(this.dio);

  late final GeneralService _service = GeneralService(dio);
  final network = Get.find<NetworkController>();

  //List Of App Information
  final appInfo = <AppInfoDatum>[].obs;
  final contactInfo = <ContactInfo>[].obs;

  Future<bool> getAppInfo() async {
    if (network.isOnline) {
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
    } else {
      EasyLoading.showInfo("Your Are OFFLINE!");
      return false;
    }
  }

  Future<void> getContactInfo() async {
    if (network.isOnline) {
      final failureOrSuccess = await _service.getContactInfo();
      failureOrSuccess.fold((l) => debugPrint("Failure In GetContactInfo"),
          (r) {
        if (r.success) {
          contactInfo.clear();
          contactInfo.addAll(r.data);
        }
      });
    } else {
      EasyLoading.showInfo("Your Are OFFLINE!");
    }
  }
}
