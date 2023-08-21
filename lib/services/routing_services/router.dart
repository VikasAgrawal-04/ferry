import 'package:get/route_manager.dart';
import 'package:goa/services/routing_services/routes.dart';
import 'package:goa/src/middlewares/global_middleware.dart';
import 'package:goa/src/views/screens/auth_screen/login.dart';
import 'package:goa/src/views/screens/dashboard.dart';
import 'package:goa/src/views/screens/passes_screen/pass_screen.dart';
import 'package:goa/src/views/screens/passes_screen/route_listing.dart';
import 'package:goa/src/views/screens/passes_screen/vehicle_screen.dart';

import '../../src/views/screens/auth_screen/register.dart';

class AppRouter {
  static List<GetPage> routes = [
    GetPage(
        name: AppRoutes.dashboard,
        page: () => const DashBoard(),
        middlewares: [AuthMiddleware()]),
    GetPage(name: AppRoutes.login, page: () => const LoginScreen()),
    GetPage(name: AppRoutes.register, page: () => const RegisterScreen()),
    GetPage(
        name: AppRoutes.routeListing, page: () => const RouteListingScreen()),
    GetPage(name: AppRoutes.vehicleListing, page: () => const VehicleScreen()),
    GetPage(name: AppRoutes.passDetails, page: () => const PassScreen())
  ];
}
