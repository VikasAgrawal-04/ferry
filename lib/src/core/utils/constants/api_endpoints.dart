import 'package:goa/src/core/utils/environment.dart';

class EndPoints {
  static String baseUrl = Environment.apiBaseUrl;

  //Auth
  static const String createUser = "create_user.php";
  static const String login = "login.php";
  static const String verifyOtp = "verifyotp.php";
  static const String resendOtp = "resend_otp.php";
  static const String changePassword = "changepassword.php";

  //Routes
  static const String getRoutes = 'get_routes_name.php';
  static const String getRouteImg = 'get_route_image.php';
  static const String getPassByRoute = 'get_pass_by_route.php';
  static const String createPass = 'create_pass_sale.php';
  static const String currentPass = 'get_current_passes.php';

  //General
  static const String appInfo = 'get_all_app_information.php';
}
