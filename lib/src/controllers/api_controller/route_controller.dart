import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:goa/services/api_services/route_services.dart';
import 'package:goa/services/routing_services/routes.dart';
import 'package:goa/src/controllers/network/network_controller.dart';
import 'package:goa/src/core/utils/helpers/database_helpers.dart';
import 'package:goa/src/models/routes/routes_info_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

import '../../models/purchase_history/purchase_history_model.dart';
import '../../models/routes/route_passes.dart';
import '../../models/your_pass/your_passes_model.dart';

class RouteController extends GetxController {
  final Dio dio;
  RouteController({required this.dio});
  late final RouteService _service = RouteService(dio: dio);
  final database = DatabaseHelper.instance;
final network = Get.find<NetworkController>();

  //List Of Routes
  final routesName = <RouteDatum>[].obs;

  //List of Passes
  final passes = <Pass>[].obs;
  final yourPasses = <YourPassDatum>[].obs;
  final onlyYourPasses = <YourPassDatum>[].obs;
  final passesHistory = <PurchaseDatum>[].obs;
  final passesImg = ['assets/images/6.PNG', 'assets/images/9.PNG'];

  Future<void> downloadPasses() async {
    if (network.isOnline) {
      final successOrFailure = await _service.getYourPasses();
      successOrFailure.fold((l) => debugPrint("Error In Get Your Passes $l"),
          (r) async {
        if (r.success) {
          database.deletePasses();
          database.insertPasses(r.data);
        }
      });
    }
  }

  Future<void> fetchRoutes() async {
    if (network.isOnline) {
      EasyLoading.show();
      final successOrFailure = await _service.fetchRoutes();
      successOrFailure.fold((l) => debugPrint("Error In Fetch Routes $l"), (r) {
        routesName.clear();
        if (r.success) {
          routesName.addAll(r.routes);
          EasyLoading.dismiss();
        }
      });
    } else {
      EasyLoading.showInfo("Your Are OFFLINE!");
    }
  }

  Future<bool> getRoutePasses(
      {required int routeId, required String vehicleType}) async {
    if (network.isOnline) {
      EasyLoading.show();
      bool returnType = false;
      final failureOrSuccess = await _service.getRoutePasses(
          routeId: routeId, vehicleType: vehicleType);
      failureOrSuccess.fold((l) => debugPrint("Error In Get Route Passes $l"),
          (r) {
        passes.clear();
        if (r.success) {
          passes.addAll(r.passes);
          EasyLoading.showSuccess(r.message);
          returnType = true;
        } else {
          EasyLoading.showError(r.message);
          returnType = false;
        }
      });
      EasyLoading.dismiss();
      return returnType;
    } else {
      EasyLoading.showInfo("Your Are OFFLINE!");
      return false;
    }
  }

  Future<void> createPass({required int passId}) async {
    EasyLoading.show();
    final successOrFailure = await _service.createPass(passId: passId);
    successOrFailure.fold((l) => debugPrint("Error In Create Pass $l"),
        (r) async {
      if (r['success']) {
        EasyLoading.showSuccess(r['message']);
        await downloadPasses();
        Get.offAllNamed(AppRoutes.dashboard);
      } else {
        EasyLoading.showError(r['message']);
      }
    });
    EasyLoading.dismiss();
  }

  Future<void> getYourPasses() async {
    EasyLoading.show();
    yourPasses.clear();
    onlyYourPasses.clear();

    final res = await database.fetchPasses();
    yourPasses.addAll(res);
    for (final pass in res) {
      if (pass.isUnderTransfer == "1") {
        onlyYourPasses.add(pass);
      }
    }
    EasyLoading.dismiss();
  }

  Future<void> transferPass({required String passCode}) async {
    if (network.isOnline) {
      EasyLoading.show();
      final successOrFailure = await _service.transferPass(passCode: passCode);
      EasyLoading.dismiss();
      successOrFailure.fold((l) => debugPrint("Error In Transfer Pass $l"),
          (r) async {
        if (r['success']) {
          await downloadPasses();
          Get.defaultDialog(
              title: "${r['message']} \n Transfer Code: ${r['transfercode']}",
              content: SizedBox(
                height: 10.h,
                child: SfBarcodeGenerator(
                  showValue: true,
                  value: r['transfercode'],
                  symbology: Code128A(module: 2),
                ),
              ),
              textConfirm: 'Ok',
              onConfirm: () {
                Get.offAllNamed(AppRoutes.dashboard);
              });
        } else {
          EasyLoading.showError(r['message']);
        }
      });
    } else {
      EasyLoading.showInfo("Your Are OFFLINE!");
    }
  }

  Future<void> importPass({required String transferCode}) async {
    if (network.isOnline) {
      EasyLoading.show();
      final successOrFailure =
          await _service.importPass(transferCode: transferCode);
      EasyLoading.dismiss();
      successOrFailure.fold((l) => debugPrint("Error In Import Pass $l"),
          (r) async {
        if (r['success']) {
          EasyLoading.showSuccess(r['message']);
          await downloadPasses();
          Get.back();
        } else {
          EasyLoading.showError(r['message']);
        }
      });
    } else {
      EasyLoading.showInfo("Your Are OFFLINE!");
    }
  }

  Future<void> purchaseHistory() async {
    if (network.isOnline) {
      EasyLoading.show();
      final failureOrSuccess = await _service.purchaseHistory();
      passesHistory.clear();
      EasyLoading.dismiss();
      failureOrSuccess.fold((l) => debugPrint("Error In Purchase History $l"),
          (r) {
        if (r.success) {
          passesHistory.addAll(r.data);
        }
      });
    } else {
      EasyLoading.showInfo("Your Are OFFLINE!");
    }
  }
}
