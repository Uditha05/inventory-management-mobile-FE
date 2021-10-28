import 'package:inventory_management/api/technical_officer/technical_officer.dart'
    as api;

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
    return await api.acceptEquipment(this.id, status);
  }
}
