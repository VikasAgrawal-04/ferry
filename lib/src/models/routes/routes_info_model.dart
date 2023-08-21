// To parse this JSON data, do
//
//     final routeInfo = routeInfoFromJson(jsonString);

import 'dart:convert';

RouteInfo routeInfoFromJson(String str) => RouteInfo.fromJson(json.decode(str));

String routeInfoToJson(RouteInfo data) => json.encode(data.toJson());

class RouteInfo {
  bool success;
  String message;
  List<RouteDatum> routes;

  RouteInfo({
    required this.success,
    required this.message,
    required this.routes,
  });

  factory RouteInfo.fromJson(Map<String, dynamic> json) => RouteInfo(
        success: json["success"],
        message: json["message"],
        routes: List<RouteDatum>.from(
            json["routes"].map((x) => RouteDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "routes": List<dynamic>.from(routes.map((x) => x.toJson())),
      };
}

class RouteDatum {
  int routeid;
  String routename;

  RouteDatum({
    required this.routeid,
    required this.routename,
  });

  factory RouteDatum.fromJson(Map<String, dynamic> json) => RouteDatum(
        routeid: json["routeid"],
        routename: json["routename"],
      );

  Map<String, dynamic> toJson() => {
        "routeid": routeid,
        "routename": routename,
      };
}
