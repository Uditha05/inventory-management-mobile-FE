import 'package:inventory_management/model/item.dart';
class AvailabilityDetail{
  final bool availability;
  final Item data;
  final String availableDate;

  AvailabilityDetail({this.availability,this.data,this.availableDate});

  factory AvailabilityDetail.fromJson(Map<String, dynamic> parsedJson) => AvailabilityDetail(
    availability: parsedJson["availability"],
    data: Item.fromJson(parsedJson["Item"]),
    availableDate: parsedJson["availableDate"],
  );

  Map<String, dynamic> toJson() => {
    "availability": availability,
    "Item": data.toJson(),
    "availableDate": availableDate,
  };
}