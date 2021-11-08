import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:inventory_management/controller/auth_controller.dart';
import 'package:inventory_management/service/auth_service.dart';
import 'package:mockito/mockito.dart';

const Map<String, dynamic> loginResposne = {
  "token":
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySUQiOiJTMTExIiwiZXhwaXJlc0luIjozNjAwLCJ0eXBlIjoiT2ZmaWNlQ2xlcmsiLCJmaXJzdE5hbWUiOiJVZGl0aGEiLCJsYXN0TmFtZSI6IklzdXJhbmdhIiwiZW1haWwiOiJvZmZpY2VjbGVya0B1b20uY29tIiwiaWF0IjoxNjM2MzUwMDUwfQ.x-CzTmdvP90_8yUPgeA8C5Md216G-GlfsJ3g0GfHlH0"
};

class MockClient extends Mock implements AuthService {
  @override
  Future attemptLogIn(
    String username,
    String password,
  ) async {
    if (username == "officeclerk@uom.com" && password == "abc123") {
      return jsonEncode(loginResposne);
    } else {
      return null;
    }
  }
}

void main() {
  group("auth_controller_tests", () {
    setUpAll(() {}); // before all, one time

    setUp(() {}); // before each test

    test("decode Jwt", () {
      var model = AuthController();
      var jwt =
          '{"token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySUQiOiJTMTExIiwiZXhwaXJlc0luIjozNjAwLCJ0eXBlIjoiT2ZmaWNlQ2xlcmsiLCJmaXJzdE5hbWUiOiJVZGl0aGEiLCJsYXN0TmFtZSI6IklzdXJhbmdhIiwiZW1haWwiOiJvZmZpY2VjbGVya0B1b20uY29tIiwiaWF0IjoxNjM2MzUwMDUwfQ.x-CzTmdvP90_8yUPgeA8C5Md216G-GlfsJ3g0GfHlH0"}';
      var payload = {
        "userID": "S111",
        "expiresIn": 3600,
        "type": "OfficeClerk",
        "firstName": "Uditha",
        "lastName": "Isuranga",
        "email": "officeclerk@uom.com",
        "iat": 1636350050
      };
      expect(model.decodeJWT(jwt), payload);
    });

    test("submit valid Username and password", () async {
      MockClient mockService = MockClient();

      AuthController authController = AuthController.internal(mockService);
      var out = await authController.submitUserNamePassword(
          "officeclerk@uom.com", "abc123");

      expect(out, "OfficeClerk");
    });

    test("submit invalid Username and password", () async {
      MockClient mockService = MockClient();

      AuthController authController = AuthController.internal(mockService);
      var out = await authController.submitUserNamePassword(
          "office@uom.com", "abc123");

      expect(out, isNull);
    });
  });
}
