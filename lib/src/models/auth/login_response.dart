// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  bool success;
  String message;
  UserData? data;

  LoginResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : UserData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class UserData {
  int userid;
  String isotpverified;
  String fullname;
  String usertype;
  String emailid;
  String mobile;
  String jwtToken;

  UserData({
    required this.userid,
    required this.isotpverified,
    required this.fullname,
    required this.usertype,
    required this.emailid,
    required this.mobile,
    required this.jwtToken,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        userid: json["userid"],
        isotpverified: json["isotpverified"],
        fullname: json["fullname"],
        usertype: json["usertype"],
        emailid: json["emailid"],
        mobile: json["mobile"],
        jwtToken: json["jwtToken"],
      );

  Map<String, dynamic> toJson() => {
        "userid": userid,
        "isotpverified": isotpverified,
        "fullname": fullname,
        "usertype": usertype,
        "emailid": emailid,
        "mobile": mobile,
        "jwtToken": jwtToken,
      };
}
