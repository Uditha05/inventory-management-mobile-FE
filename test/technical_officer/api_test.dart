import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:inventory_management/services/borrow_data.dart';
import 'package:inventory_management/services/category.dart';
import 'package:inventory_management/services/iteam.dart';
import 'package:inventory_management/services/lab.dart';
import 'package:inventory_management/services/modal.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:inventory_management/api/technical_officer/technical_officer.dart';
import 'package:inventory_management/controller/auth_controller.dart';
import 'api_test.mocks.dart';
import 'package:inventory_management/config/constant_data.dart';
import 'dart:convert' as convert;

// Generate a MockClient using the Mockito package.
// Create new instances of this class in each test.
@GenerateMocks([http.Client])
void main() {

  mockfn() {}
  var headers = {"Authorization": 'Bearer ' + ConstantData.TOKEN};
  API api = API();
  final client = MockClient();
  api.client = client;
  group('fetchCategory', () {
    test('returns an Category if the http call completes successfully',
        () async {
      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client.get(
              Uri.parse(
                  'https://sep-uom-inventory.herokuapp.com/technicalofficer/categories'),
              headers: headers))
          .thenAnswer((_) async =>
              http.Response('{"id": 2, "categoryName": "mock"}', 200));

      Category c = new Category(mockfn);

      expect(await api.getCategories(c), {"id": 2, "categoryName": "mock"});
    });

    test('returns an Category if the http call fails', () async {
      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client.get(
              Uri.parse(
                  'https://sep-uom-inventory.herokuapp.com/technicalofficer/categories'),
              headers: headers))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      Category c = new Category(mockfn);

      expect(await api.getCategories(c), null);
    });
  });
  group('fetchModel', () {
    test('returns an model if the http call completes successfully', () async {
      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client.get(
              Uri.parse(
                  'https://sep-uom-inventory.herokuapp.com/technicalofficer/models/2'),
              headers: headers))
          .thenAnswer((_) async =>
              http.Response('{"id": 2, "modelName": "mock"}', 200));

      Model m = Model("2", mockfn());

      expect(await api.getModels(m), {"id": 2, "modelName": "mock"});
    });

    test('returns an model if the http call fails', () async {
      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client.get(
              Uri.parse(
                  'https://sep-uom-inventory.herokuapp.com/technicalofficer/models/2'),
              headers: headers))
          .thenAnswer((_) async => http.Response('not found', 404));

      Model m = Model("2", mockfn());

      expect(await api.getModels(m), null);
    });
  });
  group('fetchLAbs', () {
    test('returns lab if the http call completes successfully', () async {
      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client.get(
              Uri.parse(
                  'https://sep-uom-inventory.herokuapp.com/technicalofficer/labs'),
              headers: headers))
          .thenAnswer(
              (_) async => http.Response('{"id": 2, "labName": "mock"}', 200));

      Lab l = Lab(mockfn());

      expect(await api.getLabs(l), {"id": 2, "labName": "mock"});
    });

    test('returns lab if the http call fails', () async {
      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client.get(
              Uri.parse(
                  'https://sep-uom-inventory.herokuapp.com/technicalofficer/labs'),
              headers: headers))
          .thenAnswer((_) async => http.Response('not found', 404));

      Lab l = Lab(mockfn());

      expect(await api.getLabs(l), null);
    });
  });

  group('fetchrequest', () {
    test('returns request if the http call completes successfully', () async {
      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client.get(
              Uri.parse(
                  'https://sep-uom-inventory.herokuapp.com/technicalofficer/requestdata/1'),
              headers: headers))
          .thenAnswer(
              (_) async => http.Response('{"id": 2, "labName": "mock"}', 200));

      expect(await api.getRequestData('1'), {"id": 2, "labName": "mock"});
    });

    test('returns request if the http call fails', () async {
      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client.get(
              Uri.parse(
                  'https://sep-uom-inventory.herokuapp.com/technicalofficer/requestdata/1'),
              headers: headers))
          .thenAnswer((_) async => http.Response('not found', 404));

      expect(await api.getRequestData('1'), null);
    });
  });
  group('fetchfindIteamsByCatogary', () {
    test('returns findIteamsByCatogary if the http call completes successfully',
        () async {
      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client.get(
              Uri.parse(
                  'https://sep-uom-inventory.herokuapp.com/technicalofficer/categories/1'),
              headers: headers))
          .thenAnswer((_) async => http.Response(
              '[{"Category": {"categoryName":"cat"}, "imageURL": "mock","status":"notdamage","availability":1,"Lab":{"labName":"lab"},"Model":{"modelName":"model"}}]',
              200));

      expect(await api.findIteamsByCatogary('1'), isA<List<Iteam>>());
    });

    test('returns findIteamsByCatogary if the http call fails', () async {
      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client.get(
              Uri.parse(
                  'https://sep-uom-inventory.herokuapp.com/technicalofficer/categories/1'),
              headers: headers))
          .thenAnswer((_) async => http.Response('not found', 404));

      expect(await api.findIteamsByCatogary('1'),
          "Request failed with status: 404.");
    });
  });

  group('fetchgetBorrowData', () {
    test('returns getBorrowData if the http call completes successfully',
        () async {
      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      var id = '1111';
      var fromDate = new DateTime(2021);
      var toDate = new DateTime(2021);
      when(client.post(
              Uri.parse(
                  'https://sep-uom-inventory.herokuapp.com/technicalofficer/borrowdata/'),
              body: {
                'store_code': id,
                'fromDate':
                    '${fromDate.year}/${fromDate.month}/${fromDate.day}',
                'toDate': '${toDate.year}/${toDate.month}/${toDate.day}'
              },
              headers: headers))
          .thenAnswer((_) async => http.Response('[]', 200));

      expect(await api.getBorrowData(id, fromDate, toDate),
          isA<List<BorrowData>>());
    });

    test('returns getBorrowData if the http call fails', () async {
      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      var id = '1111';
      var fromDate = new DateTime(2021);
      var toDate = new DateTime(2021);
      when(client.post(
              Uri.parse(
                  'https://sep-uom-inventory.herokuapp.com/technicalofficer/borrowdata/'),
              body: {
                'store_code': id,
                'fromDate':
                    '${fromDate.year}/${fromDate.month}/${fromDate.day}',
                'toDate': '${toDate.year}/${toDate.month}/${toDate.day}'
              },
              headers: headers))
          .thenAnswer((_) async => http.Response('not found', 404));

      expect(await api.getBorrowData(id, fromDate, toDate), null);
    });
  });

  group('fetch getLastBorrowData', () {
    var data = [
      {
        "Equipment": {
          "id": '1',
          "imageURL": '',
          "Lab": {"labName": 'lab name'},
          "Model": {"modelName": 'model name'},
          "Category": {"categoryName": 'category name'},
          "availability": 1
        },
        "type": "lecture",
        "TemoryBorrowings": [
          {
            "student": {
              "lastName": 'last',
              "firstName": 'first',
              "department": 'dep'
            }
          }
        ],
        "LecturerBorrowings": [
          {
            "lecturer": {
              "lastName": 'last',
              "firstName": 'first',
              "department": 'dep'
            }
          }
        ],
        "id": 1,
        "fromDate": "2021-11-11",
        "dueDate": "2021-11-11",
      }
    ];
    test('returns getLastBorrowData if the http call completes successfully',
        () async {
      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client.get(
              Uri.parse(
                  'https://sep-uom-inventory.herokuapp.com/technicalofficer/borrowdata/1'),
              headers: headers))
          .thenAnswer(
              (_) async => http.Response(convert.jsonEncode(data), 200));

      expect(await api.getLastBorrowData(1), isA<BorrowData>());
    });

    test('returns getLastBorrowData if the http call completes successfully',
        () async {
      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client.get(
              Uri.parse(
                  'https://sep-uom-inventory.herokuapp.com/technicalofficer/borrowdata/1'),
              headers: headers))
          .thenAnswer((_) async => http.Response("not found", 404));

      expect(await api.getLastBorrowData(1), null);
    });
  });
  group('fetch getEquipmentByStoreCode', () {
    var data = {
      "id": '1',
      "imageURL": '',
      "Lab": {"labName": 'lab name'},
      "Model": {"modelName": 'model name'},
      "Category": {"categoryName": 'category name'},
      "availability": 1
    };
    test(
        'returns getEquipmentByStoreCode if the http call completes successfully',
        () async {
      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client.get(
              Uri.parse(
                  'https://sep-uom-inventory.herokuapp.com/technicalofficer/equipment/1'),
              headers: headers))
          .thenAnswer(
              (_) async => http.Response(convert.jsonEncode(data), 200));

      expect(await api.getEquipmentByStoreCode(1), isA<Iteam>());
    });

    test('returns getEquipmentByStoreCode if the http call fails', () async {
      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client.get(
              Uri.parse(
                  'https://sep-uom-inventory.herokuapp.com/technicalofficer/equipment/1'),
              headers: headers))
          .thenAnswer((_) async => http.Response("not found", 404));

      expect(await api.getEquipmentByStoreCode(1), null);
    });
  });

  group('fetch getEquipmentByStoreCode', () {
    var data = {
      "id": '1',
      "imageURL": '',
      "Lab": {"labName": 'lab name'},
      "Model": {"modelName": 'model name'},
      "Category": {"categoryName": 'category name'},
      "availability": 1
    };
    test(
        'returns getEquipmentByStoreCode if the http call completes successfully',
        () async {
      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client.get(
              Uri.parse(
                  'https://sep-uom-inventory.herokuapp.com/technicalofficer/equipment/1'),
              headers: headers))
          .thenAnswer(
              (_) async => http.Response(convert.jsonEncode(data), 200));

      expect(await api.getEquipmentByStoreCode(1), isA<Iteam>());
    });

    test('returns getEquipmentByStoreCode if the http call fails', () async {
      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client.get(
              Uri.parse(
                  'https://sep-uom-inventory.herokuapp.com/technicalofficer/equipment/1'),
              headers: headers))
          .thenAnswer((_) async => http.Response("not found", 404));

      expect(await api.getEquipmentByStoreCode(1), null);
    });
  });
  group('fetch temporyIssueEquipment', () {
    var userid = 1;
    var storeid = 11;
    var fromdate = new DateTime(2021);
    var todate = new DateTime(2021);
    var reason = "reason";
    test(
        'returns temporyIssueEquipment if the http call completes successfully',
        () async {
      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client.post(
              Uri.parse(
                  'https://sep-uom-inventory.herokuapp.com/technicalofficer/temporyborrowing'),
              body: {
                'userid': userid,
                'storeid': storeid,
                'fromdate': fromdate.toString(),
                'todate': todate.toString(),
                'reason': reason
              },
              headers: headers))
          .thenAnswer((_) async => http.Response("{}", 201));

      expect(
          await api.temporyIssueEquipment(
              userid, storeid, fromdate, todate, reason),
          null);
    });

    test('returns temporyIssueEquipment if the http call fails', () async {
      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client.post(
              Uri.parse(
                  'https://sep-uom-inventory.herokuapp.com/technicalofficer/temporyborrowing'),
              body: {
                'userid': userid,
                'storeid': storeid,
                'fromdate': fromdate.toString(),
                'todate': todate.toString(),
                'reason': reason
              },
              headers: headers))
          .thenAnswer((_) async => http.Response("", 404));

      expect(
          await api.temporyIssueEquipment(
              userid, storeid, fromdate, todate, reason),
          'Request failed with status: 404.');
    });
  });
  group('fetch NormalIssueEquipment', () {
    var userid = 1;
    var storeid = 11;
    var fromdate = new DateTime(2021);
    var todate = new DateTime(2021);
    var requestid = 1;
    test('returns NormalIssueEquipment if the http call completes successfully',
        () async {
      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client.post(
              Uri.parse(
                  'https://sep-uom-inventory.herokuapp.com/technicalofficer/normalborrowing'),
              body: {
                'userid': userid,
                'storeid': storeid,
                'fromdate': fromdate.toString(),
                'todate': todate.toString(),
                'requestId': requestid
              },
              headers: headers))
          .thenAnswer((_) async => http.Response("{}", 201));

      expect(
          await api.NormalIssueEquipment(
              userid, storeid, fromdate, todate, requestid),
          null);
    });

    test('returns temporyIssueEquipment if the http call fails', () async {
      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client.post(
              Uri.parse(
                  'https://sep-uom-inventory.herokuapp.com/technicalofficer/normalborrowing'),
              body: {
                'userid': userid,
                'storeid': storeid,
                'fromdate': fromdate.toString(),
                'todate': todate.toString(),
                'requestId': requestid
              },
              headers: headers))
          .thenAnswer((_) async => http.Response("", 404));

      expect(
          await api.NormalIssueEquipment(
              userid, storeid, fromdate, todate, requestid),
          'Request failed with status: 404.');
    });
  });
  group('fetch updateEquipment', () {
    var imgUrl = "1";
    var storeid = 11;
    var status = "notdamage";
    var issetimage = false;
    test('returns updateEquipment if the http call completes successfully',
        () async {
      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client.post(
              Uri.parse(
                  'https://sep-uom-inventory.herokuapp.com/technicalofficer/updateequipment/'),
              body: {
                'store_code': storeid,
                'status': status,
                'imgPreview': imgUrl,
                'issetimage': issetimage.toString()
              },
              headers: headers))
          .thenAnswer((_) async => http.Response("{}", 201));

      expect(await api.updateEquipment(storeid, status, imgUrl, issetimage),
          [true, 'none']);
    });

    test('returns temporyIssueEquipment if the http call fails', () async {
      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client.post(
              Uri.parse(
                  'https://sep-uom-inventory.herokuapp.com/technicalofficer/updateequipment/'),
              body: {
                'store_code': storeid,
                'status': status,
                'imgPreview': imgUrl,
                'issetimage': issetimage.toString()
              },
              headers: headers))
          .thenAnswer((_) async => http.Response("{}", 404));

      expect(await api.updateEquipment(storeid, status, imgUrl, issetimage),
          [false, 'Request failed with status: 404.']);
    });
  });
  group('fetch AddEquipment', () {
    var category = 1;
    var model = 11;
    var lab = 1;
    var imgUrl = "url";
    test('returns AddEquipment if the http call completes successfully',
        () async {
      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client.post(
              Uri.parse(
                  'https://sep-uom-inventory.herokuapp.com/technicalofficer/addequipment/'),
              body: {
                'category': category,
                'model': model,
                'lab': lab,
                'imgPreview': imgUrl
              },
              headers: headers))
          .thenAnswer(
              (_) async => http.Response('{"id": 2, "labName": "mock"}', 201));

      expect(await api.AddEquipment(category, model, lab, imgUrl),
          [true, 'none', 2]);
    });

    test('returns temporyIssueEquipment if the http call fails', () async {
      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client.post(
              Uri.parse(
                  'https://sep-uom-inventory.herokuapp.com/technicalofficer/addequipment/'),
              body: {
                'category': category,
                'model': model,
                'lab': lab,
                'imgPreview': imgUrl
              },
              headers: headers))
          .thenAnswer((_) async => http.Response("{id:1}", 404));

      expect(await api.AddEquipment(category, model, lab, imgUrl),
          [false, 'Request failed with status: 404.']);
    });
  });

  group('fetch acceptEquipment', () {
    var id = 1;
    var status = "notdamage";
    test('returns acceptEquipment if the http call completes successfully',
        () async {
      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client.post(
              Uri.parse(
                  'https://sep-uom-inventory.herokuapp.com/technicalofficer/acceptEquipment/'),
              body: {'id': id, 'status': status},
              headers: headers))
          .thenAnswer((_) async => http.Response('{}', 201));

      expect(await api.acceptEquipment(id, status), false);
    });

    test('returns acceptEquipment if the http call fails', () async {
      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client.post(
              Uri.parse(
                  'https://sep-uom-inventory.herokuapp.com/technicalofficer/acceptEquipment/'),
              body: {'id': id, 'status': status},
              headers: headers))
          .thenAnswer((_) async => http.Response('{}', 404));

      expect(await api.acceptEquipment(id, status), true);
    });
  });
}
