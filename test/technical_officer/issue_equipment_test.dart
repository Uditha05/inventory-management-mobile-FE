import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:inventory_management/screen/add_update_equipment/add_update_equipment.dart';
import 'package:inventory_management/screen/add_update_equipment/add_update_equipment_form.dart';
import 'package:inventory_management/screen/issue_equipment/issue_equipment.dart';
import 'package:inventory_management/screen/issue_equipment/issue_equipment_form.dart';

void main() {
  testWidgets('IssueEquipment type', (WidgetTester tester) async {
    Widget testWidget = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(home: new IssueEquipment()));
    await tester.pumpWidget(testWidget);

    var dropdown = find.byType(DropdownButton);
    await tester.tap(dropdown);
    await tester.pump();
    var menuitems = find.byType(DropdownMenuItem);
    print(menuitems);
    expect(menuitems, findsWidgets);

    // test('description', () {
  });
  testWidgets('select approve', (WidgetTester tester) async {
    Widget testWidget = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(home: new IssueEquipment()));
    await tester.pumpWidget(testWidget);

    var dropdown = find.byType(DropdownButton);
    // await tester.tap(dropdown);
    // await tester.pump();
    var menuitems = find.byType(DropdownMenuItem);
    // await tester.tap(menuitems.at(1));
    // await tester.pump();
    var next = find.byType(RaisedButton);
    await tester.tap(next);
    await tester.pump();
    var form = find.byType(IssueEquipmetForm);
    print(form);
    //expect(form, findsOneWidget);

    // test('description', () {
  });
}
