// To parse this JSON data, do
//
//     final officeClerk = officeClerkFromJson(jsonString);

import 'dart:convert';

OfficeClerk officeClerkFromJson(String str) =>
    OfficeClerk.fromJson(json.decode(str));

String officeClerkToJson(OfficeClerk data) => json.encode(data.toJson());

class OfficeClerk {
  OfficeClerk({
    this.name,
    this.email,
    this.position,
    this.userId,
  });

  String name;
  String email;
  String position;
  String userId;

  factory OfficeClerk.fromJson(Map<String, dynamic> json) => OfficeClerk(
        name: json["name"],
        email: json["email"],
        position: json["position"],
        userId: json["userID"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "position": position,
        "userID": userId,
      };
}

var oneOfficeClerk = new OfficeClerk(
  name: "Uditha",
  email: "abc@gmail.com",
  position: "Admin",
  userId: "AD252627",
);
