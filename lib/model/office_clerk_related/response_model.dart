// To parse this JSON data, do
//
//     final responseModel = responseModelFromJson(jsonString);

import 'dart:convert';

ResponseModel responseModelFromJson(String str) =>
    ResponseModel.fromJson(json.decode(str));

String responseModelToJson(ResponseModel data) => json.encode(data.toJson());

class ResponseModel {
  ResponseModel({
    this.results,
    this.message,
  });

  Results results;
  String message;

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        results: json["results"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "results": results,
        "message": message,
      };
}

class Results {
  Results({
    this.token,
  });

  String token;

  factory Results.fromJson(Map<String, dynamic> json) => Results(
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
      };
}
