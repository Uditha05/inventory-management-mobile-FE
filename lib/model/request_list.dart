import 'package:inventory_management/model/request_detai.dart';

class RequestsList {
  final List<RequestDetail> details;
  RequestsList({this.details});

  factory RequestsList.fromJson(List<dynamic> parsedJson){
    List<RequestDetail> details = new List<RequestDetail>();
    details = parsedJson.map((i)=>RequestDetail.formJson(i)).toList();
    return new RequestsList(details: details);
  }
}