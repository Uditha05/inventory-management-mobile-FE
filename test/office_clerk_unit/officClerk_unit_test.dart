import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

class MockClient extends Mock implements Client {}

void main() {
  setUpAll(() {
    registerException(Uri.parse(""));
  });
  // test("hello test", () {
  //   String hello = "hello";
  //   expect(hello, "hello");
  // });

  group("offce_clerk_controller", () {
    setUpAll(() {}); // before all, one time

    setUp(() {}); // before each test

    test("office_clerk1", () {});

    tearDown(() {}); // after each test

    tearDownAll(() {}); // after all, one time
  });
}
