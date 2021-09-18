import 'package:inventory_management/model/item.dart';
class AvailabilityDetail{
  final bool availability;
  final Item data;
  final String availableDate;

  AvailabilityDetail({this.availability,this.data,this.availableDate});
}