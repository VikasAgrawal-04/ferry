import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:goa/services/payment_services/paytm_service.dart';
import 'package:goa/services/routing_services/routes.dart';
import 'package:goa/src/controllers/api_controller/route_controller.dart';
import 'package:goa/src/core/utils/environment.dart';

class PaytmController extends GetxController {
  final Dio dio;
  PaytmController({required this.dio});
  late final _service = PaytmService(dio: dio);

  final String mId = Environment.mid;
  final passController = Get.find<RouteController>();

  Future<void> generateChecksum(
      {required int passId, required int amount}) async {
    EasyLoading.show();
    final failureOrSuccess =
        await _service.generateChecksum(passId: passId, amount: amount);
    EasyLoading.dismiss();
    failureOrSuccess.fold((l) {
      debugPrint("Failure In GenerateChecksum $l");
      EasyLoading.showError('An Error Occured!');
    }, (r) {
      Get.toNamed(AppRoutes.qrScreen,
          arguments: r.response.body.image,
          parameters: {
            'id': r.response.body.qrCodeId,
            'amount': amount.toString()
          });
    });
  }

  Future<void> verifyTransaction(String qrId) async {
    final failureOrSuccess = await _service.verifyTransaction(qrId);
    failureOrSuccess.fold((l) {
      debugPrint("Failure In VerifyTransaction ${l.toString()}");
      EasyLoading.showError(l.toString());
    }, (r) async {
      EasyLoading.showSuccess(r['message']);
      await passController.downloadPasses();
      Get.offAllNamed(AppRoutes.dashboard);
      debugPrint("Success In VerifyTransaction $r");
    });
  }
}
