// To parse this JSON data, do
//
//     final routeImgModel = routeImgModelFromJson(jsonString);

import 'dart:convert';

RouteImgModel routeImgModelFromJson(String str) =>
    RouteImgModel.fromJson(json.decode(str));

String routeImgModelToJson(RouteImgModel data) => json.encode(data.toJson());

class RouteImgModel {
  bool success;
  String message;
  String routeimg;

  RouteImgModel({
    required this.success,
    required this.message,
    required this.routeimg,
  });

  factory RouteImgModel.fromJson(Map<String, dynamic> json) => RouteImgModel(
        success: json["success"],
        message: json["message"],
        routeimg: json["routeimg"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "routeimg": routeimg,
      };
}
