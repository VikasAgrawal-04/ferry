// To parse this JSON data, do
//
//     final appInfoModel = appInfoModelFromJson(jsonString);

import 'dart:convert';

AppInfoModel appInfoModelFromJson(String str) =>
    AppInfoModel.fromJson(json.decode(str));

String appInfoModelToJson(AppInfoModel data) => json.encode(data.toJson());

class AppInfoModel {
  bool success;
  String message;
  List<AppInfoDatum> data;

  AppInfoModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory AppInfoModel.fromJson(Map<String, dynamic> json) => AppInfoModel(
        success: json["success"],
        message: json["message"],
        data: List<AppInfoDatum>.from(
            json["data"].map((x) => AppInfoDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class AppInfoDatum {
  String title;
  String description;

  AppInfoDatum({
    required this.title,
    required this.description,
  });

  factory AppInfoDatum.fromJson(Map<String, dynamic> json) => AppInfoDatum(
        title: json["title"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
      };
}
