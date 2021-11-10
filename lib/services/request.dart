import 'package:inventory_management/services/borrow_data.dart';
import 'package:inventory_management/services/i_request_user.dart';
import 'package:inventory_management/api/technical_officer/technical_officer.dart';
import 'iteam.dart';

class Request {
  String status;
  final IRequestUser iRequestUser;
  final DateTime reqdate;
  BorrowData borrowData;
  final Iteam iteam;
  final String id;
  IRequestUser lecture;

  Request({
    this.iRequestUser,
    this.reqdate,
    this.status,
    this.iteam,
    this.id,
  });

  Future setBorrowData() {}

  Future IssueNormalEquipment(fromdate, todate) async {
    return await API().NormalIssueEquipment(
        iRequestUser.id, iteam.store_code, fromdate, todate, id);
  }
}
