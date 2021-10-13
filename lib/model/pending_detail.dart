import './item.dart';

class PendingDetail{
  final String studentId;
  final Item item;
  final String fromDate;
  final String dueDate;

  PendingDetail({this.studentId,this.item,this.fromDate,this.dueDate});

  factory PendingDetail.fromJson(Map<String, dynamic> parsedJson) => PendingDetail(
    studentId: parsedJson["studentId"],
    item: Item.fromJson(parsedJson["Item"]),
    fromDate: parsedJson["fromDate"],
    dueDate: parsedJson['dueDate'],
  );
}