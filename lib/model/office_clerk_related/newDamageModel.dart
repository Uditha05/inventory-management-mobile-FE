// To parse this JSON data, do
//
//     final newDamageModel = newDamageModelFromJson(jsonString);

import 'dart:convert';

List<NewDamageModel> newDamageModelFromJson(String str) =>
    List<NewDamageModel>.from(
        json.decode(str).map((x) => NewDamageModel.fromJson(x)));

String newDamageModelToJson(List<NewDamageModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NewDamageModel {
  NewDamageModel({
    this.id,
    this.imageUrl,
    this.newDamageModelCategoryId,
    this.newDamageModelModelId,
    this.newDamageModelLabId,
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
  });

  String id;
  String imageUrl;
  int newDamageModelCategoryId;
  int newDamageModelModelId;
  int newDamageModelLabId;
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

  factory NewDamageModel.fromJson(Map<String, dynamic> json) => NewDamageModel(
        id: json["id"],
        imageUrl: json["imageURL"],
        newDamageModelCategoryId: json["categoryId"],
        newDamageModelModelId: json["modelId"],
        newDamageModelLabId: json["labId"],
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
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "imageURL": imageUrl,
        "categoryId": newDamageModelCategoryId,
        "modelId": newDamageModelModelId,
        "labId": newDamageModelLabId,
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
      };
}
