import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inventory_management/screen/accept_equipment/accept_equipment.dart';
import 'package:inventory_management/screen/add_update_equipment/add_update_equipment.dart';
import 'package:inventory_management/screen/add_update_equipment/add_update_equipment_form.dart';

import 'package:inventory_management/widget/custem_input.dart';
import 'package:inventory_management/widget/custom_button.dart';

void main() {
  testWidgets('Add Update type', (WidgetTester tester) async {
    Widget testWidget = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(home: new AddUpdateEquipment()));
    await tester.pumpWidget(testWidget);

    var dropdown = find.byType(DropdownButton);
    await tester.tap(dropdown);
    await tester.pump();
    var menuitems = find.byType(DropdownMenuItem);
    print(menuitems);
    expect(menuitems, findsWidgets);

    // test('description', () {
  });
  testWidgets('Add Equipment', (WidgetTester tester) async {
    Widget testWidget = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(home: new AddUpdateEquipment()));
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
    var form = find.byType(AddUpdateEquipmetForm);
    print(form);
    //expect(form, findsOneWidget);

    // test('description', () {
  });
}
