import 'item.dart';
class RequestDetail{
  final int requestId;
  final String studentId;
  final Item item;
  final String fromDate;
  final String dueDate;

  RequestDetail(this.requestId,this.studentId,this.item,this.fromDate,this.dueDate);
}
