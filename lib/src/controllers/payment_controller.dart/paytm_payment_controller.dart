import 'package:dio/dio.dart' as doo;
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:goa/services/payment_services/payment_service.dart';
import 'package:goa/services/routing_services/routes.dart';
import 'package:goa/src/controllers/api_controller/route_controller.dart';
import 'package:goa/src/controllers/network/network_controller.dart';
import 'package:goa/src/core/utils/environment.dart';
import 'package:goa/src/core/utils/helpers/database_helpers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class PaytmController extends GetxController {
  final doo.Dio dio;
  PaytmController({required this.dio});
  late final _service = PaymentService(dio: dio);

  final String mId = Environment.mid;
  final passController = Get.find<RouteController>();
  final network = Get.find<NetworkController>();

  Future<void> generateChecksum(
      {required int passId, required int amount}) async {
    EasyLoading.show();
    final failureOrSuccess =
        await _service.generateChecksum(passId: passId, amount: amount);
    EasyLoading.dismiss();
    failureOrSuccess.fold((l) {
      debugPrint("Failure In GenerateChecksum $l");
      EasyLoading.showError('An Error Occured!');
    }, (r) async {
      if (await canLaunchUrl(
          Uri.parse(r.response.data.instrumentResponse.redirectInfo.url))) {
        await launchUrl(
            Uri.parse(r.response.data.instrumentResponse.redirectInfo.url));
        await passController.downloadPasses();
        Get.offAllNamed(AppRoutes.dashboard);
      }
    });
  }

  // Future<void> verifyTransaction(String qrId) async {
  //   final failureOrSuccess = await _service.verifyTransaction(qrId);
  //   failureOrSuccess.fold((l) {
  //     debugPrint("Failure In VerifyTransaction ${l.toString()}");
  //     EasyLoading.showError(l.toString());
  //   }, (r) async {
  //     EasyLoading.showSuccess(r['message']);
  //     await passController.downloadPasses();
  //     Get.offAllNamed(AppRoutes.dashboard);
  //     debugPrint("Success In VerifyTransaction $r");
  //   });
  // }

  Future<void> deleteAccount() async {
    if (network.isOnline) {
      final failureOrSuccess = await _service.deleteAccount();
      failureOrSuccess.fold((l) => debugPrint("Failure In deleteAccount $l"),
          (r) async {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.clear();
        DatabaseHelper.instance.deleteEverything();
        Get.offAllNamed(AppRoutes.login);
      });
    } else {
      EasyLoading.showInfo("Your Are OFFLINE!");
    }
  }
}
