// To parse this JSON data, do
//
//     final entryModel = entryModelFromJson(jsonString);

import 'dart:convert';

List<EntryModel> entryModelFromJson(String str) => List<EntryModel>.from(json.decode(str).map((x) => EntryModel.fromJson(x)));

String entryModelToJson(List<EntryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EntryModel {
  String id;
  String securityId;
  String description;
  String phoneno;
  String typeofuser;
  String vehicle;
  String vehicleNumber;
  String vehicleName;
  String vehicleType;
  String eventType;
  String entryTime;
  String exitTime;
  DateTime date;
  int v;
  String name;

  EntryModel({
    required this.id,
    required this.securityId,
    required this.description,
    required this.phoneno,
    required this.typeofuser,
    required this.vehicle,
    required this.vehicleNumber,
    required this.vehicleName,
    required this.vehicleType,
    required this.eventType,
    required this.entryTime,
    required this.exitTime,
    required this.date,
    required this.v,
    required this.name,
  });

  factory EntryModel.fromJson(Map<String, dynamic> json) => EntryModel(
    id: json["_id"],
    securityId: json["securityId"],
    description: json["description"],
    phoneno: json["phoneno"],
    typeofuser: json["typeofuser"],
    vehicle: json["vehicle"],
    vehicleNumber: json["vehicleNumber"],
    vehicleName: json["vehicleName"],
    vehicleType: json["vehicleType"],
    eventType: json["eventType"],
    entryTime: json["entryTime"],
    exitTime: json["exitTime"],
    date: DateTime.parse(json["date"]),
    v: json["__v"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "securityId": securityId,
    "description": description,
    "phoneno": phoneno,
    "typeofuser": typeofuser,
    "vehicle": vehicle,
    "vehicleNumber": vehicleNumber,
    "vehicleName": vehicleName,
    "vehicleType": vehicleType,
    "eventType": eventType,
    "entryTime": entryTime,
    "exitTime": exitTime,
    "date": date.toIso8601String(),
    "__v": v,
    "name": name,
  };
}
