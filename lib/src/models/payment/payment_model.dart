// To parse this JSON data, do
//
//     final checkSum = checkSumFromJson(jsonString);

import 'dart:convert';

CheckSum checkSumFromJson(String str) => CheckSum.fromJson(json.decode(str));

String checkSumToJson(CheckSum data) => json.encode(data.toJson());

class CheckSum {
  final Response response;

  CheckSum({
    required this.response,
  });

  CheckSum copyWith({
    Response? response,
  }) =>
      CheckSum(
        response: response ?? this.response,
      );

  factory CheckSum.fromJson(Map<String, dynamic> json) => CheckSum(
        response: Response.fromJson(json["response"]),
      );

  Map<String, dynamic> toJson() => {
        "response": response.toJson(),
      };
}

class Response {
  final bool success;
  final String code;
  final String message;
  final Data data;

  Response({
    required this.success,
    required this.code,
    required this.message,
    required this.data,
  });

  Response copyWith({
    bool? success,
    String? code,
    String? message,
    Data? data,
  }) =>
      Response(
        success: success ?? this.success,
        code: code ?? this.code,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        success: json["success"],
        code: json["code"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "code": code,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  final String merchantId;
  final String merchantTransactionId;
  final InstrumentResponse instrumentResponse;

  Data({
    required this.merchantId,
    required this.merchantTransactionId,
    required this.instrumentResponse,
  });

  Data copyWith({
    String? merchantId,
    String? merchantTransactionId,
    InstrumentResponse? instrumentResponse,
  }) =>
      Data(
        merchantId: merchantId ?? this.merchantId,
        merchantTransactionId:
            merchantTransactionId ?? this.merchantTransactionId,
        instrumentResponse: instrumentResponse ?? this.instrumentResponse,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        merchantId: json["merchantId"],
        merchantTransactionId: json["merchantTransactionId"],
        instrumentResponse:
            InstrumentResponse.fromJson(json["instrumentResponse"]),
      );

  Map<String, dynamic> toJson() => {
        "merchantId": merchantId,
        "merchantTransactionId": merchantTransactionId,
        "instrumentResponse": instrumentResponse.toJson(),
      };
}

class InstrumentResponse {
  final String type;
  final RedirectInfo redirectInfo;

  InstrumentResponse({
    required this.type,
    required this.redirectInfo,
  });

  InstrumentResponse copyWith({
    String? type,
    RedirectInfo? redirectInfo,
  }) =>
      InstrumentResponse(
        type: type ?? this.type,
        redirectInfo: redirectInfo ?? this.redirectInfo,
      );

  factory InstrumentResponse.fromJson(Map<String, dynamic> json) =>
      InstrumentResponse(
        type: json["type"],
        redirectInfo: RedirectInfo.fromJson(json["redirectInfo"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "redirectInfo": redirectInfo.toJson(),
      };
}

class RedirectInfo {
  final String url;
  final String method;

  RedirectInfo({
    required this.url,
    required this.method,
  });

  RedirectInfo copyWith({
    String? url,
    String? method,
  }) =>
      RedirectInfo(
        url: url ?? this.url,
        method: method ?? this.method,
      );

  factory RedirectInfo.fromJson(Map<String, dynamic> json) => RedirectInfo(
        url: json["url"],
        method: json["method"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "method": method,
      };
}
