import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:goa/services/routing_services/router.dart';
import 'package:goa/services/routing_services/routes.dart';
import 'package:goa/src/core/theme/theme.dart';
import 'package:goa/src/core/utils/environment.dart';
import 'package:goa/src/core/utils/helpers/database_helpers.dart';
import 'package:goa/src/core/utils/helpers/helpers.dart';
import 'package:goa/src/injector.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: Environment.fileName);
  DependencyInjector.inject();
  await DatabaseHelper.instance.fetchDatabase;
  SharedPreferences.getInstance().then((prefs) {
    // Initialize SharedPreferences before running the app
    Helpers.prefs = prefs; // Set the instance in your Helpers class
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    configLoading();
    runApp(const MyApp());
  });
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.ripple
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..userInteractions = true
    ..dismissOnTap = false;
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return ResponsiveSizer(
      builder: ((context, orientation, deviceType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          getPages: AppRouter.routes,
          initialRoute: AppRoutes.dashboard,
          theme: ApplicationTheme.lightTheme,
          builder: EasyLoading.init(),
        );
      }),
    );
  }
}
