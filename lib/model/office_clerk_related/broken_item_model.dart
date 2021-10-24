// To parse this JSON data, do
//
//     final brokenItems = brokenItemsFromJson(jsonString);

import 'dart:convert';

List<BrokenItems> brokenItemsFromJson(String str) => List<BrokenItems>.from(
    json.decode(str).map((x) => BrokenItems.fromJson(x)));

String brokenItemsToJson(List<BrokenItems> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BrokenItems {
  BrokenItems({
    this.id,
    this.reason,
    this.itemStatus,
    this.openDate,
    this.closeDate,
    this.equipmentId,
    this.equipment,
  });

  int id;
  String reason;
  String itemStatus;
  DateTime openDate;
  dynamic closeDate;
  int equipmentId;
  Equipment equipment;

  factory BrokenItems.fromJson(Map<String, dynamic> json) => BrokenItems(
        id: json["id"],
        reason: json["reason"],
        itemStatus: json["itemStatus"],
        openDate: DateTime.parse(json["openDate"]),
        closeDate: json["closeDate"],
        equipmentId: json["equipmentId"],
        equipment: Equipment.fromJson(json["equipment"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "reason": reason,
        "itemStatus": itemStatus,
        "openDate": openDate.toIso8601String(),
        "closeDate": closeDate,
        "equipmentId": equipmentId,
        "equipment": equipment.toJson(),
      };
}

class Equipment {
  Equipment({
    this.id,
    this.imageUrl,
    this.category,
    this.modelName,
    this.labName,
    this.availability,
    this.status,
    this.storeCode,
  });

  int id;
  String imageUrl;
  String category;
  String modelName;
  String labName;
  bool availability;
  String status;
  String storeCode;

  factory Equipment.fromJson(Map<String, dynamic> json) => Equipment(
        id: json["id"],
        imageUrl: json["imageURL"],
        category: json["category"],
        modelName: json["modelName"],
        labName: json["labName"],
        availability: json["availability"],
        status: json["status"],
        storeCode: json["storeCode"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "imageURL": imageUrl,
        "category": category,
        "modelName": modelName,
        "labName": labName,
        "availability": availability,
        "status": status,
        "storeCode": storeCode
      };
}
