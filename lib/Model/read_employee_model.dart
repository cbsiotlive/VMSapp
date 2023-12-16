// To parse this JSON data, do
//
//     final readEmployeeModel = readEmployeeModelFromJson(jsonString);

import 'dart:convert';

ReadEmployeeModel readEmployeeModelFromJson(String str) => ReadEmployeeModel.fromJson(json.decode(str));

String readEmployeeModelToJson(ReadEmployeeModel data) => json.encode(data.toJson());

class ReadEmployeeModel {
  int employeeId;
  String firstName;
  String lastName;
  String gender;
  DateTime dateOfBirth;
  String contactNumber;
  String email;
  String address;
  String department;
  String position;
  DateTime hireDate;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic departmentId;
  dynamic designationId;

  ReadEmployeeModel({
    required this.employeeId,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.dateOfBirth,
    required this.contactNumber,
    required this.email,
    required this.address,
    required this.department,
    required this.position,
    required this.hireDate,
    required this.createdAt,
    required this.updatedAt,
    required this.departmentId,
    required this.designationId,
  });

  factory ReadEmployeeModel.fromJson(Map<String, dynamic> json) => ReadEmployeeModel(
    employeeId: json["employee_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    gender: json["gender"],
    dateOfBirth: DateTime.parse(json["date_of_birth"]),
    contactNumber: json["contact_number"],
    email: json["email"],
    address: json["address"],
    department: json["department"],
    position: json["position"],
    hireDate: DateTime.parse(json["hire_date"]),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    departmentId: json["department_id"],
    designationId: json["designation_id"],
  );

  Map<String, dynamic> toJson() => {
    "employee_id": employeeId,
    "first_name": firstName,
    "last_name": lastName,
    "gender": gender,
    "date_of_birth": dateOfBirth.toIso8601String(),
    "contact_number": contactNumber,
    "email": email,
    "address": address,
    "department": department,
    "position": position,
    "hire_date": hireDate.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "department_id": departmentId,
    "designation_id": designationId,
  };
}
