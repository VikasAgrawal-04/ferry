import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:goa/src/controllers/api_controller/auth_controller.dart';
import 'package:goa/src/controllers/api_controller/general_controller.dart';
import 'package:goa/src/controllers/api_controller/route_controller.dart';
import 'package:goa/src/controllers/network/network_controller.dart';
import 'package:goa/src/controllers/payment_controller.dart/paytm_payment.dart';
import 'package:goa/src/core/utils/constants/api_endpoints.dart';
import 'package:goa/src/core/utils/environment.dart';

class DependencyInjector {
  static void inject() {
    _injectDio();
    _injectControllers();
  }

  static void _injectDio() {
    final dio = Dio(BaseOptions(baseUrl: EndPoints.baseUrl));
    final paytmDio = Dio(BaseOptions(baseUrl: Environment.paytmBaseUrl));
    Get.lazyPut<Dio>(() => dio);
    Get.lazyPut<Dio>(() => paytmDio, tag: 'paytm');
  }

  static void _injectControllers() {
    final dio = Get.find<Dio>();
    final paytmDio = Get.find<Dio>(tag: 'paytm');
    Get.put(NetworkController());
    Get.put(RouteController(dio: dio));
    Get.put(AuthController(dio: dio));
    Get.put(GeneralController(dio));
    Get.put(PaytmController(dio: paytmDio));
  }
}
