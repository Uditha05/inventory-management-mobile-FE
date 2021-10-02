class BorrowData {
  final String type;
  final String name;
  final DateTime fromDate;
  final DateTime toDate;
  final String status;
  final String id;
  DateTime returnDate;

  BorrowData(
      {this.type,
      this.fromDate,
      this.status,
      this.toDate,
      this.name,
      this.id,
      this.returnDate});
}
