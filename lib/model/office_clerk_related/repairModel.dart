// To parse this JSON data, do
//
//     final damageModel = damageModelFromJson(jsonString);

import 'dart:convert';

List<DamageModel> damageModelFromJson(String str) => List<DamageModel>.from(
    json.decode(str).map((x) => DamageModel.fromJson(x)));

String damageModelToJson(List<DamageModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DamageModel {
  DamageModel({
    this.id,
    this.imageUrl,
    this.damageModelCategoryId,
    this.damageModelModelId,
    this.damageModelLabId,
    this.availability,
    this.status,
    this.addDate,
    this.categoryId,
    this.modelId,
    this.labId,
    this.categoryCategoryName,
    this.labLabName,
    this.modelModelName,
    this.reason,
    this.openDate,
    this.damageId,
    this.closeDate,
  });

  String id;
  String imageUrl;
  int damageModelCategoryId;
  int damageModelModelId;
  int damageModelLabId;
  int availability;
  String status;
  DateTime addDate;
  int categoryId;
  int modelId;
  int labId;
  String categoryCategoryName;
  String labLabName;
  String modelModelName;
  String reason;
  DateTime openDate;
  int damageId;
  DateTime closeDate;

  factory DamageModel.fromJson(Map<String, dynamic> json) => DamageModel(
      id: json["id"],
      imageUrl: json["imageURL"],
      damageModelCategoryId: json["categoryId"],
      damageModelModelId: json["modelId"],
      damageModelLabId: json["labId"],
      availability: json["availability"],
      status: json["status"],
      addDate: DateTime.parse(json["addDate"]),
      categoryId: json["CategoryId"],
      modelId: json["ModelId"],
      labId: json["LabId"],
      categoryCategoryName: json["Category.categoryName"],
      labLabName: json["Lab.labName"],
      modelModelName: json["Model.modelName"],
      reason: json["reason"],
      openDate: DateTime.parse(json["openDate"]),
      damageId: json["damageId"],
      closeDate: DateTime.parse(
          json["closeDate"] == null ? "2021-10-10" : json["closeDate"]));

  Map<String, dynamic> toJson() => {
        "id": id,
        "imageURL": imageUrl,
        "categoryId": damageModelCategoryId,
        "modelId": damageModelModelId,
        "labId": damageModelLabId,
        "availability": availability,
        "status": status,
        "addDate":
            "${addDate.year.toString().padLeft(4, '0')}-${addDate.month.toString().padLeft(2, '0')}-${addDate.day.toString().padLeft(2, '0')}",
        "CategoryId": categoryId,
        "ModelId": modelId,
        "LabId": labId,
        "Category.categoryName": categoryCategoryName,
        "Lab.labName": labLabName,
        "Model.modelName": modelModelName,
        "reason": reason,
        "openDate": openDate.toIso8601String(),
        "damageId": damageId,
        "closeDate": closeDate.toIso8601String(),
      };
}
