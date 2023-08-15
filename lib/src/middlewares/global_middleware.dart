import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:goa/services/routing_services/routes.dart';
import 'package:goa/src/core/utils/constants/keys.dart';
import 'package:goa/src/core/utils/helpers/helpers.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final userData = Helpers.getString(key: Keys.userData);
    if (userData != null) {
      return null;
    } else {
      return const RouteSettings(name: AppRoutes.login);
    }
  }
}
