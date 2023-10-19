import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:goa/services/payment_services/paytm_service.dart';
import 'package:goa/src/core/utils/environment.dart';
import 'package:goa/src/core/utils/helpers/helpers.dart';
import 'package:goa/src/models/payment/payment_model.dart';
import 'package:paytm_allinonesdk/paytm_allinonesdk.dart';

class PaytmController extends GetxController {
  final Dio dio;
  PaytmController({required this.dio});
  late final _service = PaytmService(dio: dio);

  final String mId = Environment.mid;

  Future<void> generateChecksum(
      {required int passId, required int amount}) async {
    final failureOrSuccess =
        await _service.generateChecksum(passId: passId, amount: amount);
    failureOrSuccess.fold((l) {
      debugPrint("Failure In GenerateChecksum $l");
      EasyLoading.showError('An Error Occured!');
    }, (r) {
      initiateTransaction(r, amount.toDouble().toString());
    });
  }

  Future<void> initiateTransaction(PaytmCheckSum data, String amount) async {
    print(data.response['head']['signature']);
    var response = AllInOneSdk.startTransaction(mId, data.orderId, amount,
        data.response['body']['txnToken'], data.callbackUrl, true, true);
    response.then((value) {
      Helpers.logger(type: LoggerType.w, message: "Success $value");
    }).catchError((onError) {
      if (onError is PlatformException) {
        Helpers.logger(
            type: LoggerType.w,
            message:
                "Platform Exeption m error ${onError.message} ++++ ${onError.details} ${onError.code}");
      } else {
        Helpers.logger(type: LoggerType.w, message: "else m error h $onError");
      }
    });
  }
}
