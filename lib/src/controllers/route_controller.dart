import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:goa/services/api_services/route_services.dart';
import 'package:goa/src/models/routes/routes_info_model.dart';

class RouteController extends GetxController {
  final Dio dio;
  RouteController({required this.dio});
  late final RouteService _service = RouteService(dio: dio);

  //List Of Routes
  final routesName = <Route>[].obs;

  Future<void> fetchRoutes() async {
    final successOrFailure = await _service.fetchRoutes();
    successOrFailure.fold((l) => debugPrint("Error In Fetch Routes"), (r) {
      routesName.clear();
      if (r.success) {
        print(r.routes.length);
        routesName.addAll(r.routes);
      }
    });
  }
}
