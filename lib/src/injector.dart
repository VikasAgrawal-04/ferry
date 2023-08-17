import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:goa/src/controllers/auth_controller.dart';
import 'package:goa/src/controllers/route_controller.dart';
import 'package:goa/src/core/utils/constants/api_endpoints.dart';

class DependencyInjector {
  static void inject() {
    _injectDio();
    _injectControllers();
  }

  static void _injectDio() {
    final dio = Dio(BaseOptions(baseUrl: EndPoints.baseUrl));
    Get.lazyPut<Dio>(() => dio);
  }

  static void _injectControllers() {
    final dio = Get.find<Dio>();
    Get.lazyPut(() => AuthController(dio: dio));
    Get.lazyPut(() => RouteController(dio: dio));
  }
}
