import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:inventory_management/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group("Login process test", () {
    testWidgets("Login process test", (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      final loginButton = find.byKey(Key("login"));
      await tester.tap(loginButton);
      await tester.pumpAndSettle();
    });
  });
}
