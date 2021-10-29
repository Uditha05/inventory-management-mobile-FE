import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:inventory_management/services/category.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:inventory_management/api/technical_officer/technical_officer.dart'
    as api;

import 'api_test.mocks.dart';

// Generate a MockClient using the Mockito package.
// Create new instances of this class in each test.
@GenerateMocks([http.Client])
void main() {
  var apiurl = "insep.herokuapp.com";
  mockfn() {}
  group('fetchCategory', () {
    test('returns an Category if the http call completes successfully', () async {
      final client = MockClient();
    
      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client.get(Uri.parse(
              'https://insep.herokuapp.com/technicalofficer/categories')))
          .thenAnswer((_) async =>
              http.Response('{"id": 2, "categoryName": "mock"}', 200));

      Category c = new Category(mockfn);
      await c.set(mockfn);

      expect(await api.getCategories(c), c.categories);
      print(c.categories);
    });
  });
}
