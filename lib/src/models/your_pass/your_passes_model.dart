// To parse this JSON data, do
//
//     final yourPassesModel = yourPassesModelFromJson(jsonString);

import 'dart:convert';

YourPassesModel yourPassesModelFromJson(String str) =>
    YourPassesModel.fromJson(json.decode(str));

String yourPassesModelToJson(YourPassesModel data) =>
    json.encode(data.toJson());

class YourPassesModel {
  bool success;
  String message;
  List<YourPassDatum> data;

  YourPassesModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory YourPassesModel.fromJson(Map<String, dynamic> json) =>
      YourPassesModel(
        success: json["success"],
        message: json["message"],
        data: List<YourPassDatum>.from(
            json["data"].map((x) => YourPassDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class YourPassDatum {
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
  String passname;
  String vehicletype;
  int passdays;
  String routename;
  String routeimg;
  List<TransferDetails>? transfers;

  YourPassDatum({
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
    required this.passname,
    required this.vehicletype,
    required this.passdays,
    required this.routename,
    required this.routeimg,
    this.transfers,
  });

  factory YourPassDatum.fromJson(Map<String, dynamic> json) => YourPassDatum(
        id: json["id"],
        passid: json["passid"],
        routeid: json["routeid"],
        userid: json["userid"],
        buyDate: DateTime.parse(json["buy_date"]),
        buyTime: json["buy_time"],
        cost: json["cost"],
        validTillDate: DateTime.parse(json["valid_till_date"]),
        paymentMode: json["payment_mode"] ?? "Un-Defined",
        paymentReference: json["payment_reference"] ?? "Un-Defined",
        isActive: json["is_active"],
        isDeleted: json["is_deleted"],
        currentuserid: json["currentuserid"],
        currentdeviceid: json["currentdeviceid"],
        isUnderTransfer: json["is_under_transfer"],
        passcode: json["passcode"],
        passname: json["passname"],
        vehicletype: json["vehicletype"],
        passdays: json["passdays"],
        routename: json["routename"],
        routeimg: json["routeimg"],
        transfers: json["transfers"] == null
            ? []
            : List<TransferDetails>.from(
                json["transfers"]!.map((x) => TransferDetails.fromJson(x))),
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
        "passname": passname,
        "vehicletype": vehicletype,
        "passdays": passdays,
        "routename": routename,
        "routeimg": routeimg,
        "transfers": transfers == null
            ? []
            : List<dynamic>.from(transfers!.map((x) => x.toJson())),
      };
}

class TransferDetails {
  int transferid;
  int passid;
  DateTime transferstartdatetime;
  int fromuserid;
  String fromdeviceid;
  String isTransferCompleted;
  dynamic transfercompletedDatetime;
  dynamic receivedUserid;
  dynamic receivedDeviceid;
  String isdeleted;
  String transfercode;
  String passcode;

  TransferDetails({
    required this.transferid,
    required this.passid,
    required this.transferstartdatetime,
    required this.fromuserid,
    required this.fromdeviceid,
    required this.isTransferCompleted,
    required this.transfercompletedDatetime,
    required this.receivedUserid,
    required this.receivedDeviceid,
    required this.isdeleted,
    required this.transfercode,
    required this.passcode,
  });

  factory TransferDetails.fromJson(Map<String, dynamic> json) =>
      TransferDetails(
        transferid: json["transferid"],
        passid: json["passid"],
        transferstartdatetime: DateTime.parse(json["transferstartdatetime"]),
        fromuserid: json["fromuserid"],
        fromdeviceid: json["fromdeviceid"],
        isTransferCompleted: json["is_transfer_completed"],
        transfercompletedDatetime: json["transfercompleted_datetime"],
        receivedUserid: json["received_userid"],
        receivedDeviceid: json["received_deviceid"],
        isdeleted: json["isdeleted"],
        transfercode: json["transfercode"],
        passcode: json["passcode"],
      );

  Map<String, dynamic> toJson() => {
        "transferid": transferid,
        "passid": passid,
        "transferstartdatetime": transferstartdatetime.toIso8601String(),
        "fromuserid": fromuserid,
        "fromdeviceid": fromdeviceid,
        "is_transfer_completed": isTransferCompleted,
        "transfercompleted_datetime": transfercompletedDatetime,
        "received_userid": receivedUserid,
        "received_deviceid": receivedDeviceid,
        "isdeleted": isdeleted,
        "transfercode": transfercode,
        "passcode": passcode,
      };
}
