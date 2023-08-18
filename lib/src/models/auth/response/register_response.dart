// To parse this JSON data, do
//
//     final registerResponse = registerResponseFromJson(jsonString);

import 'dart:convert';

RegisterResponse registerResponseFromJson(String str) =>
    RegisterResponse.fromJson(json.decode(str));

String registerResponseToJson(RegisterResponse data) =>
    json.encode(data.toJson());

class RegisterResponse {
  bool success;
  String message;
  RegisterData data;

  RegisterResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      RegisterResponse(
        success: json["success"],
        message: json["message"],
        data: RegisterData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
      };
}

class RegisterData {
  String fullname;
  String emailid;
  String mobile;
  String usertype;
  String otp;

  RegisterData({
    required this.fullname,
    required this.emailid,
    required this.mobile,
    required this.usertype,
    required this.otp,
  });

  factory RegisterData.fromJson(Map<String, dynamic> json) => RegisterData(
        fullname: json["fullname"],
        emailid: json["emailid"],
        mobile: json["mobile"],
        usertype: json["usertype"],
        otp: json["otp"],
      );

  Map<String, dynamic> toJson() => {
        "fullname": fullname,
        "emailid": emailid,
        "mobile": mobile,
        "usertype": usertype,
        "otp": otp,
      };
}
