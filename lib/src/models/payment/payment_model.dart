// To parse this JSON data, do
//
//     final paytmCheckSum = paytmCheckSumFromJson(jsonString);

import 'dart:convert';

PaytmCheckSum paytmCheckSumFromJson(String str) =>
    PaytmCheckSum.fromJson(json.decode(str));

String paytmCheckSumToJson(PaytmCheckSum data) => json.encode(data.toJson());

class PaytmCheckSum {
  Map<String, dynamic> response;
  String orderId;
  String callbackUrl;

  PaytmCheckSum({
    required this.response,
    required this.orderId,
    required this.callbackUrl,
  });

  factory PaytmCheckSum.fromJson(Map<String, dynamic> json) => PaytmCheckSum(
        response: jsonDecode(json["response"]),
        orderId: json["orderId"],
        callbackUrl: json["callbackUrl"],
      );

  Map<String, dynamic> toJson() => {
        "response": response,
        "orderId": orderId,
        "callbackUrl": callbackUrl,
      };
}
