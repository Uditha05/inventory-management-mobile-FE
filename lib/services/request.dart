import 'package:inventory_management/services/borrow_data.dart';
import 'package:inventory_management/services/i_request_user.dart';

import 'iteam.dart';

class Request {
  String status;
  final IRequestUser iRequestUser;
  final DateTime reqdate;
  BorrowData borrowData;
  final Iteam iteam;
  final String id;
  final IRequestUser lecture;

  Request(
      {this.iRequestUser,
      this.reqdate,
      this.status,
      this.iteam,
      this.id,
      this.lecture});

  Future setBorrowData() {}
}
