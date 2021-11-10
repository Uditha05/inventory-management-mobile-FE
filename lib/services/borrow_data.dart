import 'package:inventory_management/api/technical_officer/technical_officer.dart';

class BorrowData {
  final String type;
  final String name;
  final DateTime fromDate;
  final DateTime toDate;
  final String status;
  final String id;
  String userid;
  DateTime returnDate;

  BorrowData(
      {this.type,
      this.fromDate,
      this.status,
      this.toDate,
      this.name,
      this.id,
      this.returnDate});

  Future AcceptEquipment(status) async {
    return await API().acceptEquipment(this.id, status);
  }
}
