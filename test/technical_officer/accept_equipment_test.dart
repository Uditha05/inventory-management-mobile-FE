import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inventory_management/screen/accept_equipment/accept_equipment.dart';

import 'package:inventory_management/widget/custem_input.dart';
import 'package:inventory_management/widget/custom_button.dart';

void main() {
  
  testWidgets('Store id input feild', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    Widget testWidget = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(home: new AcceptEquipmentForm()));
    await tester.pumpWidget(testWidget);
    var textfeild = find.byType(InputFeildType);
    // Verify that our counter starts at 0.
    expect(find.text('Accept Equipment'), findsOneWidget);
    expect(textfeild, findsOneWidget);

    // test('description', () {
  });

  testWidgets('Next', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    Widget testWidget = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(home: new AcceptEquipmentForm()));
    await tester.pumpWidget(testWidget);
    var textfeild = find.byType(InputFeildType);
    var next = find.byType(CustomButton).at(0);

    // Verify that our counter starts at 0.
    await tester.enterText(textfeild, '1-5-1-4');
    await tester.tap(next);
    await tester.pump();
    expect(next, findsOneWidget);

    // test('description', () {
  });
}
