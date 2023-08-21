import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:goa/services/api_services/route_services.dart';
import 'package:goa/src/models/routes/routes_info_model.dart';

import '../models/routes/route_passes.dart';

class RouteController extends GetxController {
  final Dio dio;
  RouteController({required this.dio});
  late final RouteService _service = RouteService(dio: dio);

  //List Of Routes
  final routesName = <RouteDatum>[].obs;

  //List of Passes
  final passes = <Pass>[].obs;
  final passesImg = ['assets/images/6.PNG', 'assets/images/9.PNG'];

  Future<void> fetchRoutes() async {
    final successOrFailure = await _service.fetchRoutes();
    successOrFailure.fold((l) => debugPrint("Error In Fetch Routes $l"), (r) {
      routesName.clear();
      if (r.success) {
        routesName.addAll(r.routes);
      }
    });
    EasyLoading.dismiss();
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
}
