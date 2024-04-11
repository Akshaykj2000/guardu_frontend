// To parse this JSON data, do
//
//     final messageModel = messageModelFromJson(jsonString);

import 'dart:convert';

List<MessageModel> messageModelFromJson(String str) => List<MessageModel>.from(json.decode(str).map((x) => MessageModel.fromJson(x)));

String messageModelToJson(List<MessageModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MessageModel {
  String id;
  String hodId;
  StudentId studentId;
  String subject;
  String description;
  String department;
  String nopeople;
  String names;
  String status;
  String sendTime;
  int v;

  MessageModel({
    required this.id,
    required this.hodId,
    required this.studentId,
    required this.subject,
    required this.description,
    required this.department,
    required this.nopeople,
    required this.names,
    required this.status,
    required this.sendTime,
    required this.v,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
    id: json["_id"],
    hodId: json["hodId"],
    studentId: StudentId.fromJson(json["studentId"]),
    subject: json["subject"],
    description: json["description"],
    department: json["department"],
    nopeople: json["nopeople"],
    names: json["names"],
    status: json["status"],
    sendTime: json["sendTime"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "hodId": hodId,
    "studentId": studentId.toJson(),
    "subject": subject,
    "description": description,
    "department": department,
    "nopeople": nopeople,
    "names": names,
    "status": status,
    "sendTime": sendTime,
    "__v": v,
  };
}

class StudentId {
  String id;
  String name;
  String admissionno;
  String dateofbirth;
  String age;
  String contactno;
  String gender;
  String studentIdClass;
  String department;
  String emailid;
  String password;
  String requestStatus;
  int v;

  StudentId({
    required this.id,
    required this.name,
    required this.admissionno,
    required this.dateofbirth,
    required this.age,
    required this.contactno,
    required this.gender,
    required this.studentIdClass,
    required this.department,
    required this.emailid,
    required this.password,
    required this.requestStatus,
    required this.v,
  });

  factory StudentId.fromJson(Map<String, dynamic> json) => StudentId(
    id: json["_id"],
    name: json["name"],
    admissionno: json["admissionno"],
    dateofbirth: json["dateofbirth"],
    age: json["age"],
    contactno: json["contactno"],
    gender: json["gender"],
    studentIdClass: json["class"],
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
    "class": studentIdClass,
    "department": department,
    "emailid": emailid,
    "password": password,
    "requestStatus": requestStatus,
    "__v": v,
  };
}
