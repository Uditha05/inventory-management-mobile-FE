import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:inventory_management/controller/auth_controller.dart';
import 'package:mocktail/mocktail.dart';

class MockClient extends Mock implements Client {}

void main() {
  // setUpAll(() {
  //   registerException(Uri.parse(""));
  // });

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

    test("submit Username and password", () {});

    tearDown(() {}); // after each test

    tearDownAll(() {}); // after all, one time
  });
}
