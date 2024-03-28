// To parse this JSON data, do
//
//     final hodModel = hodModelFromJson(jsonString);

import 'dart:convert';

List<HodModel> hodModelFromJson(String str) => List<HodModel>.from(json.decode(str).map((x) => HodModel.fromJson(x)));

String hodModelToJson(List<HodModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HodModel {
  String id;
  String hodname;
  String department;
  String gender;
  String dateofbirth;
  String age;
  String phone;
  String status;
  String email;
  String hodpassword;
  int v;

  HodModel({
    required this.id,
    required this.hodname,
    required this.department,
    required this.gender,
    required this.dateofbirth,
    required this.age,
    required this.phone,
    required this.status,
    required this.email,
    required this.hodpassword,
    required this.v,
  });

  factory HodModel.fromJson(Map<String, dynamic> json) => HodModel(
    id: json["_id"],
    hodname: json["hodname"],
    department: json["department"],
    gender: json["gender"],
    dateofbirth: json["dateofbirth"],
    age: json["age"],
    phone: json["phone"],
    status: json["status"],
    email: json["email"],
    hodpassword: json["hodpassword"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "hodname": hodname,
    "department": department,
    "gender": gender,
    "dateofbirth": dateofbirth,
    "age": age,
    "phone": phone,
    "status": status,
    "email": email,
    "hodpassword": hodpassword,
    "__v": v,
  };
}
