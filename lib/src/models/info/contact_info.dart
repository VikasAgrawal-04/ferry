// To parse this JSON data, do
//
//     final contactInformation = contactInformationFromJson(jsonString);

import 'dart:convert';

ContactInformation contactInformationFromJson(String str) =>
    ContactInformation.fromJson(json.decode(str));

String contactInformationToJson(ContactInformation data) =>
    json.encode(data.toJson());

class ContactInformation {
  bool success;
  String message;
  List<ContactInfo> data;

  ContactInformation({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ContactInformation.fromJson(Map<String, dynamic> json) =>
      ContactInformation(
        success: json["success"],
        message: json["message"],
        data: List<ContactInfo>.from(
            json["data"].map((x) => ContactInfo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class ContactInfo {
  String mobile;
  String email;
  String landline;
  String facebook;
  String instagram;
  String twitter;
  String website;

  ContactInfo({
    required this.mobile,
    required this.email,
    required this.landline,
    required this.facebook,
    required this.instagram,
    required this.twitter,
    required this.website,
  });

  factory ContactInfo.fromJson(Map<String, dynamic> json) => ContactInfo(
        mobile: json["mobile"],
        email: json["email"],
        landline: json["landline"],
        facebook: json["facebook"],
        instagram: json["instagram"],
        twitter: json["twitter"],
        website: json["website"],
      );

  Map<String, dynamic> toJson() => {
        "mobile": mobile,
        "email": email,
        "landline": landline,
        "facebook": facebook,
        "instagram": instagram,
        "twitter": twitter,
        "website": website,
      };
}
