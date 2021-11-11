import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:inventory_management/model/availability_detail_list.dart';
import 'package:inventory_management/model/pending_detail.dart';
import 'package:inventory_management/model/request_list.dart';
import 'package:inventory_management/services/lecturer_api.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'getItems_test.mocks.dart';


@GenerateMocks([http.Client])
void main() {
  LecturerApi lecturerApi;
  setUp((){
    lecturerApi = LecturerApi();
  });
  group('fetch items',(){
    test('returns items if the http call complete succesfully',()async {
      final client = MockClient();
      lecturerApi.client=client;
      when(client.get(Uri.parse('https://sep-uom-inventory.herokuapp.com/student/checkAvaiabilitymobile'))).thenAnswer((_) async=>
        http.Response('[{"id":"ASDF4","imageURL":"abc.com","availability":0,"Category.categoryName":"projector","Lab.labName":"CSE Level 1","Model.modelName":"CA124-B","returnDate":"2021-10-14"}]',200));
      expect(await lecturerApi.getItems(),isA<AvailabilityDetailList>());
    });
  });

  group('fetch pending requests',(){
    test('returns pending requests if the http call complete succesfully',()async {
      final client = MockClient();
      lecturerApi.client = client;
      when(client.get(Uri.parse('https://sep-uom-inventory.herokuapp.com/lecturer/pending/s001'))).thenAnswer((_) async=>
          http.Response('[{"id":3,"equipmentId":"ASDF4","requestDate":"2021-10-02","returnDate":"2021-10-04","RequestBorrowing.studentId":"180244B","RequestBorrowing.lecturerId":"123456L"}]',200));
      expect(await lecturerApi.getPendingRequest('s001'),isA<RequestsList>());
    });

    test('trows an expection',()async{
      final client = MockClient();
      when(client.get(Uri.parse('https://sep-uom-inventory.herokuapp.com/lecturer/pending/s001'))).thenAnswer((_) async=> http.Response('Not Found',404));
      expect(await lecturerApi.getPendingRequest('s001'), isA<RequestsList>());
    });
  });

  group('fetch pending item details',(){
    test('returns pending item details if the http call complete succesfully',()async {
      final client = MockClient();
      lecturerApi.client = client;
      when(client.get(Uri.parse('https://sep-uom-inventory.herokuapp.com/lecturer/requestDetail/3'))).thenAnswer((_) async=>
          http.Response('[{"id":"ASDF4","imageURL":"abc.com","Requests.id":3,"Requests.reason":"testingseq","Requests.requestDate":"2021-10-02","Requests.returnDate":"2021-10-04","Requests.RequestBorrowing.id":1,"Requests.RequestBorrowing.studentId":"180244B","Category.categoryName":"projector","Lab.labName":"CSE Level 1","Model.modelName":"CA124-B"}]',200));
      expect(await lecturerApi.getPendingItemDetail('3'),isA<PendingDetail>());
    });

    test('trows an expection',()async{
      final client = MockClient();
      when(client.get(Uri.parse('https://sep-backend-inventory.herokuapp.com/pending'))).thenAnswer((_) async=> http.Response('Not Found',404));
      expect(await lecturerApi.getPendingItemDetail('3'), isA<PendingDetail>());
    });
  });

  group('fetch avilable category details',(){
    test('returns available category details if the http call complete succesfully',()async {
      final client = MockClient();
      lecturerApi.client = client;
      when(client.get(Uri.parse('https://sep-uom-inventory.herokuapp.com/student/category'))).thenAnswer((_) async=>
          http.Response('[{"Category.categoryName":"Camera"}]',200));
      expect(await lecturerApi.getCategory(),isA<List>());
    });

    test('trows an expection',()async{
      final client = MockClient();
      when(client.get(Uri.parse('https://sep-uom-inventory.herokuapp.com/student/category'))).thenAnswer((_) async=> http.Response('Not Found',404));
      expect(await lecturerApi.getCategory(), isA<List>());
    });
  });
  //
  group('fetch models for a particular category',(){
    test('returns models for a particular category if the http call complete succesfully',()async {
      final client = MockClient();
      lecturerApi.client = client;
      when(client.get(Uri.parse('https://sep-uom-inventory.herokuapp.com/student/model/camera'))).thenAnswer((_) async=>
          http.Response('[{"Category.categoryName":"Camera","Model.modelName":"RT567-R"}]',200));
      expect(await lecturerApi.getModel('camera'),isA<List>());
    });

    test('trows an expection',()async{
      final client = MockClient();
      when(client.get(Uri.parse('https://sep-uom-inventory.herokuapp.com/student/model/camera'))).thenAnswer((_) async=> http.Response('Not Found',404));
      expect(await lecturerApi.getModel('camera'), isA<List>());
    });
  });
  //
  group('fetch laboratory for a given category and model',(){
    test('returns laboratory for a given category and model if the http call complete succesfully',()async {
      final client = MockClient();
      lecturerApi.client = client;
      when(client.get(Uri.parse('https://sep-uom-inventory.herokuapp.com/student/lab/camera/RT567-R'))).thenAnswer((_) async=>
          http.Response('[{"Lab.labName":"CSE Level 1"}]',200));
      expect(await lecturerApi.getLab('RT567-R','camera'),isA<List>());
    });

    test('trows an expection',()async{
      final client = MockClient();
      when(client.get(Uri.parse('https://sep-uom-inventory.herokuapp.com/student/lab/camera/RT567-R'))).thenAnswer((_) async=> http.Response('Not Found',404));
      expect(await lecturerApi.getLab('RT567-R','camera'), isA<List>());
    });
  });
  //
  group('fetch storeCode for a given category and model and laboratory',(){
    test('returns storeCode for a given category and model if the http call complete succesfully',()async {
      final client = MockClient();
      lecturerApi.client = client;
      when(client.get(Uri.parse('https://sep-uom-inventory.herokuapp.com/student/storeCode/camera/RT567-R/cse%20level%201'))).thenAnswer((_) async=>
          http.Response('[{"id":"QWERT6"}]',200));
      expect(await lecturerApi.getStoreCode('camera', 'RT567-R', 'cse level 1'),isA<List>());
    });

    test('trows an expection',()async{
      final client = MockClient();
      when(client.get(Uri.parse('https://sep-backend-inventory.herokuapp.com/storeCode/camera/RT567-R/cse%20level%201'))).thenAnswer((_) async=> http.Response('Not Found',404));
      expect(await lecturerApi.getStoreCode('camera', 'RT567-R', 'cse level 1'), isA<List>());
    });
  });
  //
  group('fetch lecturers assigned for a laboratory',(){
    test('returns lecturers assigned for a laboratory if the http call complete succesfully',()async {
      final client = MockClient();
      lecturerApi.client = client;
      when(client.get(Uri.parse('https://sep-uom-inventory.herokuapp.com/student/lecturer/cse%20level%201'))).thenAnswer((_) async=>
          http.Response('[{"id":"123456L","firstName":"lecturer0","lastName":"lec"},{"id":"234567A","firstName":"wish","lastName":"kml"}]',200));
      expect(await lecturerApi.getLecturers('cse level 1'),isA<List>());
    });

    test('trows an expection',()async{
      final client = MockClient();
      when(client.get(Uri.parse('https://sep-uom-inventory.herokuapp.com/student/lecturer/cse%20level%201'))).thenAnswer((_) async=> http.Response('Not Found',404));
      expect(await lecturerApi.getLecturers('cse level 1'), isA<List>());
    });
  });

}