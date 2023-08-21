// To parse this JSON data, do
//
//     final routePasses = routePassesFromJson(jsonString);

import 'dart:convert';

RoutePasses routePassesFromJson(String str) =>
    RoutePasses.fromJson(json.decode(str));

String routePassesToJson(RoutePasses data) => json.encode(data.toJson());

class RoutePasses {
  bool success;
  String message;
  List<Pass> passes;

  RoutePasses({
    required this.success,
    required this.message,
    required this.passes,
  });

  factory RoutePasses.fromJson(Map<String, dynamic> json) => RoutePasses(
        success: json["success"],
        message: json["message"],
        passes: List<Pass>.from(json["passes"].map((x) => Pass.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "passes": List<dynamic>.from(passes.map((x) => x.toJson())),
      };
}

class Pass {
  int passid;
  int routeid;
  String passname;
  String passimg;
  int passDays;
  DateTime startDate;
  DateTime endDate;
  String cost;
  String vehicleType;
  String isactive;
  String isdeleted;

  Pass({
    required this.passid,
    required this.routeid,
    required this.passname,
    required this.passimg,
    required this.passDays,
    required this.startDate,
    required this.endDate,
    required this.cost,
    required this.vehicleType,
    required this.isactive,
    required this.isdeleted,
  });

  factory Pass.fromJson(Map<String, dynamic> json) => Pass(
        passid: json["passid"],
        routeid: json["routeid"],
        passname: json["passname"],
        passimg: json["passimg"],
        passDays: json["pass_days"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        cost: json["cost"],
        vehicleType: json["vehicle_type"],
        isactive: json["isactive"],
        isdeleted: json["isdeleted"],
      );

  Map<String, dynamic> toJson() => {
        "passid": passid,
        "routeid": routeid,
        "passname": passname,
        "passimg": passimg,
        "pass_days": passDays,
        "start_date":
            "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "end_date":
            "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "cost": cost,
        "vehicle_type": vehicleType,
        "isactive": isactive,
        "isdeleted": isdeleted,
      };
}
