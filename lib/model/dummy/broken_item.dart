// To parse this JSON data, do
//
//     final brokenItem = brokenItemFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';

// BrokenItem brokenItemFromJson(String str) =>
//     BrokenItem.fromJson(json.decode(str));

// String brokenItemToJson(BrokenItem data) => json.encode(data.toJson());

class BrokenItem {
  BrokenItem(
      {this.itemId,
      this.storeCode,
      this.model,
      this.category,
      this.issue,
      this.openDate,
      this.closeDate,
      this.image,
      this.status,
      @required this.damageId});

  String itemId;
  String storeCode;
  String model;
  String category;
  String issue;
  DateTime openDate;
  var closeDate;
  String image;
  String status;
  String damageId;

  // factory BrokenItem.fromJson(Map<String, dynamic> json) => BrokenItem(
  //       itemId: json["itemID"],
  //       storeCode: json["storeCode"],
  //       model: json["model"],
  //       category: json["category"],
  //       issue: json["issue"],
  //       openDate: DateTime.parse(json["openDate"]),
  //       closeDate: DateTime.parse(json["closeDate"]),
  //       image: json["image"],
  //       status: json["status"],
  //     );

  // Map<String, dynamic> toJson() => {
  //       "itemID": itemId,
  //       "storeCode": storeCode,
  //       "model": model,
  //       "category": category,
  //       "issue": issue,
  //       "openDate":
  //           "${openDate.year.toString().padLeft(4, '0')}-${openDate.month.toString().padLeft(2, '0')}-${openDate.day.toString().padLeft(2, '0')}",
  //       "closeDate":
  //           "${closeDate.year.toString().padLeft(4, '0')}-${closeDate.month.toString().padLeft(2, '0')}-${closeDate.day.toString().padLeft(2, '0')}",
  //       "image": image,
  //       "status": status,
  //     };
}

// List<BrokenItem> dummyBroken = [
//   new BrokenItem(
//     itemId: "Abc123",
//     image:
//         "https://firebasestorage.googleapis.com/v0/b/perks-test-25b3c.appspot.com/o/img11218.jpg?alt=media&token=be1eab16-9814-45f1-a2cb-81a2ce40ce8e",
//     storeCode: "CSE2010",
//     model: "BC-2021N",
//     category: "Projector",
//     closeDate: DateTime(2020, 10, 20),
//     issue: "Stand is broken",
//     openDate: DateTime(2020, 10, 10),
//     status: "Broken",
//   ),
//   new BrokenItem(
//     itemId: "Abc125",
//     storeCode: "CSE2010",
//     image:
//         "https://firebasestorage.googleapis.com/v0/b/perks-test-25b3c.appspot.com/o/img11218.jpg?alt=media&token=be1eab16-9814-45f1-a2cb-81a2ce40ce8e",
//     model: "BC-2021N",
//     category: "Projector",
//     issue: "Stand is broken",
//     openDate: DateTime(2020, 10, 10),
//     status: "Repair",
//   ),
//   new BrokenItem(
//     itemId: "Abc123",
//     storeCode: "CSE2010",
//     image:
//         "https://firebasestorage.googleapis.com/v0/b/perks-test-25b3c.appspot.com/o/img11218.jpg?alt=media&token=be1eab16-9814-45f1-a2cb-81a2ce40ce8e",
//     model: "BC-2021N ",
//     category: "Projector",
//     issue: "Stand is broken",
//     openDate: DateTime(2020, 10, 10),
//     status: "Broken",
//   ),
//   new BrokenItem(
//     itemId: "Abc125",
//     storeCode: "CSE2010",
//     image:
//         "https://firebasestorage.googleapis.com/v0/b/perks-test-25b3c.appspot.com/o/img11218.jpg?alt=media&token=be1eab16-9814-45f1-a2cb-81a2ce40ce8e",
//     model: "BC-2021N",
//     category: "Projector",
//     issue: "Stand is broken",
//     openDate: DateTime(2020, 10, 10),
//     status: "Repair",
//   ),
//   new BrokenItem(
//     itemId: "Abc125",
//     storeCode: "CSE2010",
//     image:
//         "https://firebasestorage.googleapis.com/v0/b/perks-test-25b3c.appspot.com/o/img11218.jpg?alt=media&token=be1eab16-9814-45f1-a2cb-81a2ce40ce8e",
//     model: "BC-2021N",
//     category: "Projector",
//     issue: "Stand is broken",
//     openDate: DateTime(2020, 10, 10),
//     status: "Repair",
//   ),
//   new BrokenItem(
//     itemId: "Abc125",
//     storeCode: "CSE2010",
//     image:
//         "https://firebasestorage.googleapis.com/v0/b/perks-test-25b3c.appspot.com/o/img11218.jpg?alt=media&token=be1eab16-9814-45f1-a2cb-81a2ce40ce8e",
//     model: "BC-2021N",
//     category: "Projector",
//     issue: "Stand is broken",
//     openDate: DateTime(2020, 10, 10),
//     status: "Repair",
//   ),
//   new BrokenItem(
//     itemId: "Abc125",
//     storeCode: "CSE2010",
//     image:
//         "https://firebasestorage.googleapis.com/v0/b/perks-test-25b3c.appspot.com/o/img11218.jpg?alt=media&token=be1eab16-9814-45f1-a2cb-81a2ce40ce8e",
//     model: "BC-2021N",
//     category: "Projector",
//     issue: "Stand is broken",
//     openDate: DateTime(2020, 10, 10),
//     status: "Repair",
//   ),
// ];
