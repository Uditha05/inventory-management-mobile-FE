import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:inventory_management/screen/lecturer/lecturer_dashboard.dart';
import 'package:inventory_management/widget/widget/dashboard_card.dart';
import 'package:inventory_management/screen/lecturer/check_availability.dart';
import 'package:inventory_management/main.dart' as app;

void main(){
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('end-to-end test',(){
    testWidgets('test dashboard', (WidgetTester tester)async{
      app.main();
      await tester.pumpAndSettle();
      final card = find.byType(ReusableCard).first;
      await tester.tap(card);
      expect(card,findsOneWidget);
    });
  });
}