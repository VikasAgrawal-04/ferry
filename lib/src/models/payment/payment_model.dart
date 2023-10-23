// To parse this JSON data, do
//
//     final paytmCheckSum = paytmCheckSumFromJson(jsonString);

import 'dart:convert';

PaytmCheckSum paytmCheckSumFromJson(String str) =>
    PaytmCheckSum.fromJson(json.decode(str));

String paytmCheckSumToJson(PaytmCheckSum data) => json.encode(data.toJson());

class PaytmCheckSum {
  Response response;

  PaytmCheckSum({
    required this.response,
  });

  factory PaytmCheckSum.fromJson(Map<String, dynamic> json) => PaytmCheckSum(
        response: Response.fromJson(json["response"]),
      );

  Map<String, dynamic> toJson() => {
        "response": response.toJson(),
      };
}

class Response {
  Head head;
  Body body;

  Response({
    required this.head,
    required this.body,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        head: Head.fromJson(json["head"]),
        body: Body.fromJson(json["body"]),
      );

  Map<String, dynamic> toJson() => {
        "head": head.toJson(),
        "body": body.toJson(),
      };
}

class Body {
  ResultInfo resultInfo;
  String qrCodeId;
  String qrData;
  String image;

  Body({
    required this.resultInfo,
    required this.qrCodeId,
    required this.qrData,
    required this.image,
  });

  factory Body.fromJson(Map<String, dynamic> json) => Body(
        resultInfo: ResultInfo.fromJson(json["resultInfo"]),
        qrCodeId: json["qrCodeId"],
        qrData: json["qrData"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "resultInfo": resultInfo.toJson(),
        "qrCodeId": qrCodeId,
        "qrData": qrData,
        "image": image,
      };
}

class ResultInfo {
  String resultStatus;
  String resultCode;
  String resultMsg;

  ResultInfo({
    required this.resultStatus,
    required this.resultCode,
    required this.resultMsg,
  });

  factory ResultInfo.fromJson(Map<String, dynamic> json) => ResultInfo(
        resultStatus: json["resultStatus"],
        resultCode: json["resultCode"],
        resultMsg: json["resultMsg"],
      );

  Map<String, dynamic> toJson() => {
        "resultStatus": resultStatus,
        "resultCode": resultCode,
        "resultMsg": resultMsg,
      };
}

class Head {
  String responseTimestamp;
  String version;
  String clientId;
  String signature;

  Head({
    required this.responseTimestamp,
    required this.version,
    required this.clientId,
    required this.signature,
  });

  factory Head.fromJson(Map<String, dynamic> json) => Head(
        responseTimestamp: json["responseTimestamp"],
        version: json["version"],
        clientId: json["clientId"],
        signature: json["signature"],
      );

  Map<String, dynamic> toJson() => {
        "responseTimestamp": responseTimestamp,
        "version": version,
        "clientId": clientId,
        "signature": signature,
      };
}
