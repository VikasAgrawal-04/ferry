import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/route_manager.dart';
import 'package:goa/services/routing_services/router.dart';
import 'package:goa/services/routing_services/routes.dart';
import 'package:goa/src/core/theme/theme.dart';
import 'package:goa/src/core/utils/environment.dart';
import 'package:goa/src/core/utils/helpers/helpers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

void main() async {
  await dotenv.load(fileName: Environment.fileName);
  SharedPreferences.getInstance().then((prefs) {
    // Initialize SharedPreferences before running the app
    Helpers.prefs = prefs; // Set the instance in your Helpers class
    runApp(MyApp());
  });
  
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: ((context, orientation, deviceType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          getPages: AppRouter.routes,
          initialRoute: AppRoutes.dashboard,
          theme: ApplicationTheme.lightTheme,
        );
      }),
    );
  }
}
