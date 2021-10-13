class RequestDetail{
  final int id;
  final String storeCode;
  final String requestDate;
  final String studentId;

  RequestDetail({this.id,this.storeCode,this.requestDate,this.studentId});

  factory RequestDetail.formJson(Map<String,dynamic>parsedJson) => RequestDetail(
    id: parsedJson['id'],
    storeCode: parsedJson['storeCode'],
    requestDate: parsedJson['requestDate'],
    studentId: parsedJson['studentId'],
  );
}
