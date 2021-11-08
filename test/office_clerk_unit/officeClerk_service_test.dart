import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:http/http.dart' as http;
import 'package:inventory_management/config/constant_data.dart';
import 'package:inventory_management/model/office_clerk_related/repairModel.dart';

import 'package:inventory_management/service/office_clerk_service.dart';

import 'package:mockito/mockito.dart';

class MockClient extends Mock implements http.Client {}

const List<Map<String, dynamic>> damageItemList = [
  {
    "id": "2-6-1-9",
    "imageURL":
        "http://res.cloudinary.com/inventorysep/image/upload/v1635181241/xyjzpppadtanpwz0p3uv.jpg",
    "categoryId": 2,
    "modelId": 6,
    "labId": 1,
    "availability": 1,
    "status": "notdamage",
    "addDate": "2021-10-25",
    "CategoryId": 2,
    "ModelId": 6,
    "LabId": 1,
    "Category.categoryName": "Camera",
    "Lab.labName": "CSE Level 1",
    "Model.modelName": "C-001",
    "reason": "update item",
    "openDate": "2021-10-25T17:16:29.000Z",
    "damageId": 1
  }
];

void main() {
  group("OfficeClerk_service_tests: ", () {
    setUpAll(() {
      ConstantData.TOKEN =
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySUQiOiJTMTExIiwiZXhwaXJlc0luIjozNjAwLCJ0eXBlIjoiT2ZmaWNlQ2xlcmsiLCJmaXJzdE5hbWUiOiJVZGl0aGEiLCJsYXN0TmFtZSI6IklzdXJhbmdhIiwiZW1haWwiOiJvZmZpY2VjbGVya0B1b20uY29tIiwiaWF0IjoxNjM2MzUwMDUwfQ.x-CzTmdvP90_8yUPgeA8C5Md216G-GlfsJ3g0GfHlH0";
    });

    setUp(() {
      print("reset token");
      ConstantData.TOKEN =
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySUQiOiJTMTExIiwiZXhwaXJlc0luIjozNjAwLCJ0eXBlIjoiT2ZmaWNlQ2xlcmsiLCJmaXJzdE5hbWUiOiJVZGl0aGEiLCJsYXN0TmFtZSI6IklzdXJhbmdhIiwiZW1haWwiOiJvZmZpY2VjbGVya0B1b20uY29tIiwiaWF0IjoxNjM2MzUwMDUwfQ.x-CzTmdvP90_8yUPgeA8C5Md216G-GlfsJ3g0GfHlH0";
    });

    test("Get New Damage Items", () async {
      MockClient mockClient = MockClient();

      when(mockClient.get(
          Uri.parse(
              'http://10.0.2.2:5000/users/office-clerk/get-new-damage-item'),
          headers: {
            "Authorization": 'Bearer ${ConstantData.TOKEN}',
          })).thenAnswer(
          (_) async => http.Response(jsonEncode(damageItemList), 200));

      OfficeClerkService officeClerkService =
          OfficeClerkService.internal(mockClient);
      var out = await officeClerkService.getNewDamageItems();

      expect(out, isA<List<DamageModel>>());
    });

    test("Get New Damage Items when not authenticated", () async {
      MockClient mockClient = MockClient();
      ConstantData.TOKEN = "";
      when(mockClient.get(
          Uri.parse(
              'http://10.0.2.2:5000/users/office-clerk/get-new-damage-item'),
          headers: {
            "Authorization": 'Bearer ${ConstantData.TOKEN}',
          })).thenAnswer((_) async => http.Response(
          jsonEncode({"object": null, "message": "Invalid email or password"}),
          500));

      OfficeClerkService officeClerkService =
          OfficeClerkService.internal(mockClient);
      var out = await officeClerkService.getNewDamageItems();

      expect(out, isNull);
    });

    test("Get Under Repair Damage Items", () async {
      MockClient mockClient = MockClient();

      when(mockClient.get(
          Uri.parse(
              'http://10.0.2.2:5000/users/office-clerk/get-under-repair-item'),
          headers: {
            "Authorization": 'Bearer ${ConstantData.TOKEN}',
          })).thenAnswer(
          (_) async => http.Response(jsonEncode(damageItemList), 200));

      OfficeClerkService officeClerkService =
          OfficeClerkService.internal(mockClient);
      var out = await officeClerkService.getPendingRepairItems();

      expect(out, isA<List<DamageModel>>());
    });

    test("Get Old Damage Items", () async {
      MockClient mockClient = MockClient();

      when(mockClient.get(
          Uri.parse(
              'http://10.0.2.2:5000/users/office-clerk/get-old-damage-item'),
          headers: {
            "Authorization": 'Bearer ${ConstantData.TOKEN}',
          })).thenAnswer(
          (_) async => http.Response(jsonEncode(damageItemList), 200));

      OfficeClerkService officeClerkService =
          OfficeClerkService.internal(mockClient);
      var out = await officeClerkService.getOldDamageItem();

      expect(out, isA<List<DamageModel>>());
    });

    test("Mark as send to repair", () async {
      MockClient mockClient = MockClient();

      when(mockClient.put(
          Uri.parse('http://10.0.2.2:5000/users/office-clerk/send-to-repair/' +
              "1-1-2-4"),
          headers: {
            "Authorization": 'Bearer ${ConstantData.TOKEN}',
          })).thenAnswer((_) async =>
          http.Response(jsonEncode({"msg": "update success"}), 200));

      OfficeClerkService officeClerkService =
          OfficeClerkService.internal(mockClient);
      var out = await officeClerkService.markSendToRepair("1-1-2-4");

      expect(out, "pass");
    });

    test("Mark as finished to repair", () async {
      MockClient mockClient = MockClient();

      when(mockClient.get(
          Uri.parse('http://10.0.2.2:5000/users/office-clerk/finish-repair/' +
              "1" +
              "1-2-3-4"),
          headers: {
            "Authorization": 'Bearer ${ConstantData.TOKEN}',
          })).thenAnswer((_) async =>
          http.Response(jsonEncode({"msg": "update success"}), 200));

      OfficeClerkService officeClerkService =
          OfficeClerkService.internal(mockClient);
      var out = await officeClerkService.markFinishedRepair("1", "1-2-3-4");

      expect(out, "pass");
    });
  });
}
