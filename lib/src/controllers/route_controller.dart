import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:goa/services/api_services/route_services.dart';
import 'package:goa/services/routing_services/routes.dart';
import 'package:goa/src/models/routes/routes_info_model.dart';

import '../models/routes/route_passes.dart';
import '../models/your_pass/your_passes_model.dart';

class RouteController extends GetxController {
  final Dio dio;
  RouteController({required this.dio});
  late final RouteService _service = RouteService(dio: dio);

  //List Of Routes
  final routesName = <RouteDatum>[].obs;

  //List of Passes
  final passes = <Pass>[].obs;
  final yourPasses = <YourPassDatum>[].obs;
  final passesImg = ['assets/images/6.PNG', 'assets/images/9.PNG'];

  Future<void> fetchRoutes() async {
    EasyLoading.show();
    final successOrFailure = await _service.fetchRoutes();
    successOrFailure.fold((l) => debugPrint("Error In Fetch Routes $l"), (r) {
      routesName.clear();
      if (r.success) {
        routesName.addAll(r.routes);
        EasyLoading.dismiss();
      }
    });
  }

  Future<bool> getRoutePasses(
      {required int routeId, required String vehicleType}) async {
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
  }

  Future<void> createPass({required int passId}) async {
    EasyLoading.show();
    final successOrFailure = await _service.createPass(passId: passId);
    successOrFailure.fold((l) => debugPrint("Error In Create Pass $l"), (r) {
      if (r['success']) {
        EasyLoading.showSuccess(r['message']);
        Get.toNamed(AppRoutes.yourPass);
      } else {
        EasyLoading.showError(r['message']);
      }
    });
    EasyLoading.dismiss();
  }

  Future<void> getYourPasses() async {
    EasyLoading.show();
    final successOrFailure = await _service.getYourPasses();
    successOrFailure.fold((l) => debugPrint("Error In Get Your Passes $l"),
        (r) {
      yourPasses.clear();
      if (r.success) {
        yourPasses.addAll(r.data);
      }
    });
    EasyLoading.dismiss();
  }
}
