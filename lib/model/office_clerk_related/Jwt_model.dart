// To parse this JSON data, do
//
//     final jwt = jwtFromJson(jsonString);

import 'dart:convert';

Jwt jwtFromJson(String str) => Jwt.fromJson(json.decode(str));

String jwtToJson(Jwt data) => json.encode(data.toJson());

class Jwt {
  Jwt({
    this.token,
  });

  String token;

  factory Jwt.fromJson(Map<String, dynamic> json) => Jwt(
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
      };
}
