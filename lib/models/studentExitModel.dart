// To parse this JSON data, do
//
//     final studentExitModel = studentExitModelFromJson(jsonString);

import 'dart:convert';

List<StudentExitModel> studentExitModelFromJson(String str) => List<StudentExitModel>.from(json.decode(str).map((x) => StudentExitModel.fromJson(x)));

String studentExitModelToJson(List<StudentExitModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StudentExitModel {
  String id;
  String studentId;
  String name;
  String admissionno;
  String department;
  String studentExitModelClass;
  String contactno;
  String gender;
  String exitTime;
  int v;

  StudentExitModel({
    required this.id,
    required this.studentId,
    required this.name,
    required this.admissionno,
    required this.department,
    required this.studentExitModelClass,
    required this.contactno,
    required this.gender,
    required this.exitTime,
    required this.v,
  });

  factory StudentExitModel.fromJson(Map<String, dynamic> json) => StudentExitModel(
    id: json["_id"],
    studentId: json["studentId"],
    name: json["name"],
    admissionno: json["admissionno"],
    department: json["department"],
    studentExitModelClass: json["class"],
    contactno: json["contactno"],
    gender: json["gender"],
    exitTime: json["exitTime"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "studentId": studentId,
    "name": name,
    "admissionno": admissionno,
    "department": department,
    "class": studentExitModelClass,
    "contactno": contactno,
    "gender": gender,
    "exitTime": exitTime,
    "__v": v,
  };
}
