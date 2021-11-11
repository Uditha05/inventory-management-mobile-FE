import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:http/http.dart' as http;
import 'package:inventory_management/service/auth_service.dart';
// import 'package:mocktail/mocktail.dart';

import 'package:mockito/mockito.dart';

class MockClient extends Mock implements http.Client {}

const Map<String, dynamic> loginResposne = {
  "token":
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySUQiOiJTMTExIiwiZXhwaXJlc0luIjozNjAwLCJ0eXBlIjoiT2ZmaWNlQ2xlcmsiLCJmaXJzdE5hbWUiOiJVZGl0aGEiLCJsYXN0TmFtZSI6IklzdXJhbmdhIiwiZW1haWwiOiJvZmZpY2VjbGVya0B1b20uY29tIiwiaWF0IjoxNjM2MzUwMDUwfQ.x-CzTmdvP90_8yUPgeA8C5Md216G-GlfsJ3g0GfHlH0"
};

void main() {
  group("Auth_service_tests: ", () {
    test("Attempt success login", () async {
      MockClient mockClient = MockClient();

      when(mockClient.post(Uri.parse('http://10.0.2.2:5000/auth/'),
              body: {"email": "officeclerk@uom.com", "password": "abc123"}))
          .thenAnswer(
              (_) async => http.Response(jsonEncode(loginResposne), 200));

      AuthService authService = AuthService.internal(mockClient);
      var out = await authService.attemptLogIn("officeclerk@uom.com", "abc123");
      expect(out, jsonEncode(loginResposne));
    });

    test("Attempt invalid login", () async {
      MockClient mockClient = MockClient();

      when(mockClient.post(Uri.parse('http://10.0.2.2:5000/auth/'), body: {
        "email": "office@uom.com",
        "password": "abc123"
      })).thenAnswer((_) async => http.Response(
          jsonEncode({"object": null, "message": "Invalid email or password"}),
          401));

      AuthService authService = AuthService.internal(mockClient);
      var out = await authService.attemptLogIn("office@uom.com", "abc123");

      expect(out, isNull);
    });
  });
}
