import 'package:inventory_management/model/avaiability_detail.dart';

class AvailabilityDetailList{
  final List<AvailabilityDetail> details;

  AvailabilityDetailList({
    this.details,
  });

  factory AvailabilityDetailList.fromJson(List<dynamic> parsedJson){
    List<AvailabilityDetail> details = new List<AvailabilityDetail>();
    details = parsedJson.map((i)=>AvailabilityDetail.fromJson(i)).toList();
    return new AvailabilityDetailList(details: details);
  }
}