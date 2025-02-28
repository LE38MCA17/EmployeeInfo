// To parse this JSON data, do
//
//     final employeeInfoModel = employeeInfoModelFromJson(jsonString);

import 'dart:convert';

List<EmployeeInfoModel> employeeInfoModelFromJson(String str) => List<EmployeeInfoModel>.from(json.decode(str).map((x) => EmployeeInfoModel.fromJson(x)));

String employeeInfoModelToJson(List<EmployeeInfoModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EmployeeInfoModel {
  String profileImage;
  String name;
  String email;
  String address;
  String phone;
  String website;
  String companyName;
  String companyDetails;

  EmployeeInfoModel({
    required this.profileImage,
    required this.name,
    required this.email,
    required this.address,
    required this.phone,
    required this.website,
    required this.companyName,
    required this.companyDetails,
  });

  factory EmployeeInfoModel.fromJson(Map<String, dynamic> json) => EmployeeInfoModel(
    profileImage: json["profile_image"],
    name: json["name"],
    email: json["email"],
    address: json["address"],
    phone: json["phone"],
    website: json["website"],
    companyName: json["company_name"],
    companyDetails: json["company_details"],
  );

  Map<String, dynamic> toJson() => {
    "profile_image": profileImage,
    "name": name,
    "email": email,
    "address": address,
    "phone": phone,
    "website": website,
    "company_name": companyName,
    "company_details": companyDetails,
  };
}
