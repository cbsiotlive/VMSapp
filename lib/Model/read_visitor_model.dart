// To parse this JSON data, do
//
//     final readVisitorModel = readVisitorModelFromJson(jsonString);

import 'dart:convert';

ReadVisitorModel readVisitorModelFromJson(String str) => ReadVisitorModel.fromJson(json.decode(str));

String readVisitorModelToJson(ReadVisitorModel data) => json.encode(data.toJson());

class ReadVisitorModel {
  int id;
  String visitorName;
  String contactNumber;
  String email;
  String companyName;
  dynamic checkInTime;
  dynamic checkOutTime;
  String hostName;
  String purpose;
  int isCheckedOut;
  DateTime createdAt;
  DateTime updatedAt;

  ReadVisitorModel({
    required this.id,
    required this.visitorName,
    required this.contactNumber,
    required this.email,
    required this.companyName,
    required this.checkInTime,
    required this.checkOutTime,
    required this.hostName,
    required this.purpose,
    required this.isCheckedOut,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ReadVisitorModel.fromJson(Map<String, dynamic> json) => ReadVisitorModel(
    id: json["id"],
    visitorName: json["visitor_name"]??"",
    contactNumber: json["contact_number"]??"",
    email: json["email"]??"",
    companyName: json["company_name"]??"",
    checkInTime: json["check_in_time"]??"",
    checkOutTime: json["check_out_time"]??"",
    hostName: json["host_name"]??"",
    purpose: json["purpose"]??"",
    isCheckedOut: json["is_checked_out"]??"",
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "visitor_name": visitorName,
    "contact_number": contactNumber,
    "email": email,
    "company_name": companyName,
    "check_in_time": checkInTime,
    "check_out_time": checkOutTime,
    "host_name": hostName,
    "purpose": purpose,
    "is_checked_out": isCheckedOut,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
