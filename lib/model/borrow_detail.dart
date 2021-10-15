import 'package:inventory_management/model/item.dart';
class BorrowDetail{
  final String month;
  final String date;
  final Item data;

  BorrowDetail({this.month,this.date,this.data});

  factory BorrowDetail.fromJson(Map<String, dynamic> parsedJson) =>BorrowDetail(
    month: parsedJson["month"],
    date: parsedJson["date"],
    data: Item.fromJson(parsedJson["Item"]),
  );

  Map<String, dynamic> toJson() => {
    "month": month,
    "date": date,
    "Item": data.toJson(),
  };
}