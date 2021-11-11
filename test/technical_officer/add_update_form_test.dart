import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:inventory_management/screen/add_update_equipment/add_update_equipment.dart';
import 'package:inventory_management/screen/add_update_equipment/add_update_equipment_form.dart';
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

  testWidgets('Update type', (WidgetTester tester) async {
    Widget testWidget = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(
            home: new AddUpdateEquipmetForm(
                type: "Update Equipment", iteam: iteam)));
    await tester.pumpWidget(testWidget);

    final text = find.text('Submit');
    expect(text, findsOneWidget);

    // test('description', () {
  });

  testWidgets('Update category', (WidgetTester tester) async {
    Widget testWidget = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(
            home: new AddUpdateEquipmetForm(
                type: "Update Equipment", iteam: iteam)));
    await tester.pumpWidget(testWidget);

    final text = find.text('cat');
    expect(text, findsOneWidget);

    // test('description', () {
  });
  testWidgets('Update lab', (WidgetTester tester) async {
    Widget testWidget = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(
            home: new AddUpdateEquipmetForm(
                type: "Update Equipment", iteam: iteam)));
    await tester.pumpWidget(testWidget);

    final text = find.text('lab');
    expect(text, findsOneWidget);

    // test('description', () {
  });

  testWidgets('Update model', (WidgetTester tester) async {
    Widget testWidget = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(
            home: new AddUpdateEquipmetForm(
                type: "Update Equipment", iteam: iteam)));
    await tester.pumpWidget(testWidget);

    final text = find.text('model');
    expect(text, findsOneWidget);

    // test('description', () {
  });
}
