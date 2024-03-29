import 'package:goa/src/core/utils/environment.dart';

class EndPoints {
  static String baseUrl = Environment.apiBaseUrl;

  //Auth
  static const String createUser = "create_user.php";
  static const String login = "login.php";
  static const String verifyOtp = "verifyotp.php";
  static const String resendOtp = "resend_otp.php";
  static const String changePassword = "changepassword.php";
  static const String createNewPassword = 'sp_cp.php';
  static const String transferPass = "start_transfer.php";
  static const String importPass = "import_pass_transfer.php";

  //Routes And Passes
  static const String getRoutes = 'get_routes_name.php';
  static const String getRouteImg = 'get_route_image.php';
  static const String getPassByRoute = 'get_pass_by_route.php';
  static const String createPass = 'create_pass_sale.php';
  static const String currentPass = 'get_current_passes.php';
  static const String purchaseHistory = 'get_purchase_history.php';
  static const String paperPass = 'check_paper_pass.php';

  //General
  static const String appInfo = 'get_all_app_information.php';
  static const String contactInfo = 'get_contact_info.php';
  static const String deleteAccount = 'delete-account';

  //Payment
  static const String createChecksum = 'phonepe';
  static const String phonepeResponse = 'phonepe-response';
  static const String paytmCallback = 'paytm-callback';
}
