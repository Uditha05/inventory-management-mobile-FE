import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:inventory_management/screen/add_update_equipment/add_update_equipment.dart';
import 'package:inventory_management/screen/add_update_equipment/add_update_equipment_form.dart';
import 'package:inventory_management/screen/issue_equipment/issue_equipment_form.dart';
import 'package:inventory_management/services/iteam.dart';
import 'package:inventory_management/widget/custom_button.dart';

void main() {
  Iteam iteam = new Iteam(
      catogary: "cat",
      isAvailable: true,
      lab: "lab",
      model: "model",
      store_code: "11",
      status: "notdamage");

  testWidgets('Issue equipment Create New Tempory Borrowing',
      (WidgetTester tester) async {
    Widget testWidget = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(
            home: new IssueEquipmetForm(type: "Create New Tempory Borrowing")));
    await tester.pumpWidget(testWidget);

    final text = find.text('Next');
    expect(text, findsOneWidget);

    // test('description', () {
  });

  testWidgets('Issue equipment Select Approved borrowing',
      (WidgetTester tester) async {
    Widget testWidget = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(
            home: new IssueEquipmetForm(type: "Select Approved borrowing")));
    await tester.pumpWidget(testWidget);

    final text = find.text('Student Id');
    expect(text, findsWidgets);

    // test('description', () {
  });
}
