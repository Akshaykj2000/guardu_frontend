// To parse this JSON data, do
//
//     final studentModel = studentModelFromJson(jsonString);

import 'dart:convert';

StudentModel studentModelFromJson(String str) => StudentModel.fromJson(json.decode(str));

String studentModelToJson(StudentModel data) => json.encode(data.toJson());

class StudentModel {
  String id;
  String name;
  String admissionno;
  String dateofbirth;
  String age;
  String contactno;
  String gender;
  String studentModelClass;
  String department;
  String emailid;
  String password;
  String requestStatus;
  int v;

  StudentModel({
    required this.id,
    required this.name,
    required this.admissionno,
    required this.dateofbirth,
    required this.age,
    required this.contactno,
    required this.gender,
    required this.studentModelClass,
    required this.department,
    required this.emailid,
    required this.password,
    required this.requestStatus,
    required this.v,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
    id: json["_id"],
    name: json["name"],
    admissionno: json["admissionno"],
    dateofbirth: json["dateofbirth"],
    age: json["age"],
    contactno: json["contactno"],
    gender: json["gender"],
    studentModelClass: json["class"],
    department: json["department"],
    emailid: json["emailid"],
    password: json["password"],
    requestStatus: json["requestStatus"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "admissionno": admissionno,
    "dateofbirth": dateofbirth,
    "age": age,
    "contactno": contactno,
    "gender": gender,
    "class": studentModelClass,
    "department": department,
    "emailid": emailid,
    "password": password,
    "requestStatus": requestStatus,
    "__v": v,
  };
}
