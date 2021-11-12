import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inventory_management/main.dart';
import 'package:inventory_management/screen/office_clerk/office_clerk_dashboard.dart';
import 'package:inventory_management/widget/custom_string_input.dart';

void main() {
  testWidgets("Office Clerk page widget test", (tester) async {
    await tester.pumpWidget(MyApp());
    Widget dashboard = OfficeClerkDashboard();
    await tester.pumpWidget(dashboard);

    expect(find.byKey(Key("handleDamageOfficeC")), findsOneWidget);
    expect(find.byKey(Key("checkAvaOfficeC")), findsOneWidget);
    expect(find.byKey(Key("logoutOfficeC")), findsOneWidget);
    
  });
}
