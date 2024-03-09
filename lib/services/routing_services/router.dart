import 'package:get/route_manager.dart';
import 'package:goa/services/routing_services/routes.dart';
import 'package:goa/src/middlewares/global_middleware.dart';
import 'package:goa/src/views/screens/auth_screen/forgot_password/new_password_screen.dart';
import 'package:goa/src/views/screens/auth_screen/forgot_password/sent_otp_screen.dart';
import 'package:goa/src/views/screens/auth_screen/login.dart';
import 'package:goa/src/views/screens/auth_screen/otp_screen.dart';
import 'package:goa/src/views/screens/dashboard.dart';
import 'package:goa/src/views/screens/info_screen/contact_us.dart';
import 'package:goa/src/views/screens/info_screen/info_detail_screen.dart';
import 'package:goa/src/views/screens/info_screen/return_refund_screen.dart';
import 'package:goa/src/views/screens/passes_screen/paper_pass_screen.dart';
import 'package:goa/src/views/screens/passes_screen/pass_screen.dart';
import 'package:goa/src/views/screens/passes_screen/route_listing.dart';
import 'package:goa/src/views/screens/passes_screen/vehicle_screen.dart';
import 'package:goa/src/views/screens/settings_screen/change_inside_password.dart';
import 'package:goa/src/views/screens/settings_screen/import_pass.dart';
import 'package:goa/src/views/screens/settings_screen/paper_scan_screen.dart';
import 'package:goa/src/views/screens/settings_screen/transfer_pass.dart';

import '../../src/views/screens/auth_screen/register.dart';
import '../../src/views/screens/your_pass_screen/your_pass_screen.dart';

class AppRouter {
  static List<GetPage> routes = [
    GetPage(
        name: AppRoutes.dashboard,
        page: () => const DashBoard(),
        middlewares: [AuthMiddleware()]),
    GetPage(name: AppRoutes.login, page: () => const LoginScreen()),
    GetPage(name: AppRoutes.register, page: () => const RegisterScreen()),
    GetPage(name: AppRoutes.otp, page: () => const OtpScreeen()),
    GetPage(
        name: AppRoutes.routeListing, page: () => const RouteListingScreen()),
    GetPage(name: AppRoutes.vehicleListing, page: () => const VehicleScreen()),
    GetPage(name: AppRoutes.passDetails, page: () => const PassScreen()),
    GetPage(name: AppRoutes.yourPass, page: () => const YourPassScreen()),
    GetPage(name: AppRoutes.infoDetails, page: () => const InfoDetailScreen()),
    GetPage(name: AppRoutes.sendOtp, page: () => const SendOtpScreen()),
    GetPage(name: AppRoutes.newPass, page: () => const NewPassScreen()),
    GetPage(name: AppRoutes.changeInPass, page: () => const ChangeInsidePass()),
    GetPage(name: AppRoutes.transferPass, page: () => const TransferPass()),
    GetPage(name: AppRoutes.importPass, page: () => const ImportPass()),
    GetPage(name: AppRoutes.contactUs, page: () => const ContactUs()),
    GetPage(name: AppRoutes.paperPass, page: () => const PaperPassScreen()),
    GetPage(name: AppRoutes.scanPaperPass, page: () => const ScanPaperPass()),
    GetPage(name: AppRoutes.returnScreen, page: () => const ReturnScreen())
  ];
}
