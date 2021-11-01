import 'package:inventory_management/model/borrow_detail.dart';

class BorrowDetailList{
  final List<BorrowDetail> details;

  BorrowDetailList({this.details});

  factory BorrowDetailList.fromJson(List<dynamic> parsedJson){
    List<BorrowDetail> details = new List<BorrowDetail>();
    details = parsedJson.map((i)=>BorrowDetail.fromJson(i)).toList();
    return new BorrowDetailList(details: details);
  }

}