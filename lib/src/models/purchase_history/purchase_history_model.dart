// To parse this JSON data, do
//
//     final purchaseHistory = purchaseHistoryFromJson(jsonString);

import 'dart:convert';

PurchaseHistory purchaseHistoryFromJson(String str) =>
    PurchaseHistory.fromJson(json.decode(str));

String purchaseHistoryToJson(PurchaseHistory data) =>
    json.encode(data.toJson());

class PurchaseHistory {
  bool success;
  String message;
  List<PurchaseDatum> data;

  PurchaseHistory({
    required this.success,
    required this.message,
    required this.data,
  });

  factory PurchaseHistory.fromJson(Map<String, dynamic> json) =>
      PurchaseHistory(
        success: json["success"],
        message: json["message"],
        data: List<PurchaseDatum>.from(
            json["data"].map((x) => PurchaseDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class PurchaseDatum {
  int id;
  int passid;
  int routeid;
  int userid;
  DateTime buyDate;
  String buyTime;
  String cost;
  DateTime validTillDate;
  String paymentMode;
  String paymentReference;
  String isActive;
  String isDeleted;
  int currentuserid;
  String currentdeviceid;
  String isUnderTransfer;
  String passcode;
  String routename;
  String vehicleType;
  int passDays;
  String passname;

  PurchaseDatum({
    required this.id,
    required this.passid,
    required this.routeid,
    required this.userid,
    required this.buyDate,
    required this.buyTime,
    required this.cost,
    required this.validTillDate,
    required this.paymentMode,
    required this.paymentReference,
    required this.isActive,
    required this.isDeleted,
    required this.currentuserid,
    required this.currentdeviceid,
    required this.isUnderTransfer,
    required this.passcode,
    required this.routename,
    required this.vehicleType,
    required this.passDays,
    required this.passname,
  });

  factory PurchaseDatum.fromJson(Map<String, dynamic> json) => PurchaseDatum(
        id: json["id"],
        passid: json["passid"],
        routeid: json["routeid"],
        userid: json["userid"],
        buyDate: DateTime.parse(json["buy_date"]),
        buyTime: json["buy_time"],
        cost: json["cost"],
        validTillDate: DateTime.parse(json["valid_till_date"]),
        paymentMode: json["payment_mode"],
        paymentReference: json["payment_reference"],
        isActive: json["is_active"],
        isDeleted: json["is_deleted"],
        currentuserid: json["currentuserid"],
        currentdeviceid: json["currentdeviceid"],
        isUnderTransfer: json["is_under_transfer"],
        passcode: json["passcode"],
        routename: json["routename"],
        vehicleType: json["vehicle_type"],
        passDays: json["pass_Days"],
        passname: json["passname"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "passid": passid,
        "routeid": routeid,
        "userid": userid,
        "buy_date":
            "${buyDate.year.toString().padLeft(4, '0')}-${buyDate.month.toString().padLeft(2, '0')}-${buyDate.day.toString().padLeft(2, '0')}",
        "buy_time": buyTime,
        "cost": cost,
        "valid_till_date":
            "${validTillDate.year.toString().padLeft(4, '0')}-${validTillDate.month.toString().padLeft(2, '0')}-${validTillDate.day.toString().padLeft(2, '0')}",
        "payment_mode": paymentMode,
        "payment_reference": paymentReference,
        "is_active": isActive,
        "is_deleted": isDeleted,
        "currentuserid": currentuserid,
        "currentdeviceid": currentdeviceid,
        "is_under_transfer": isUnderTransfer,
        "passcode": passcode,
        "routename": routename,
        "vehicle_type": vehicleType,
        "pass_Days": passDays,
        "passname": passname,
      };
}
