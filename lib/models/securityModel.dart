// To parse this JSON data, do
//
//     final securityModel = securityModelFromJson(jsonString);

import 'dart:convert';

List<SecurityModel> securityModelFromJson(String str) => List<SecurityModel>.from(json.decode(str).map((x) => SecurityModel.fromJson(x)));

String securityModelToJson(List<SecurityModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SecurityModel {
  String id;
  String name;
  String contactno;
  String post;
  String emailid;
  String password;
  int v;

  SecurityModel({
    required this.id,
    required this.name,
    required this.contactno,
    required this.post,
    required this.emailid,
    required this.password,
    required this.v,
  });

  factory SecurityModel.fromJson(Map<String, dynamic> json) => SecurityModel(
    id: json["_id"],
    name: json["name"],
    contactno: json["contactno"],
    post: json["post"],
    emailid: json["emailid"],
    password: json["password"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "contactno": contactno,
    "post": post,
    "emailid": emailid,
    "password": password,
    "__v": v,
  };
}
