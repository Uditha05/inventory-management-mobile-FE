import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inventory_management/main.dart';
import 'package:inventory_management/widget/custom_string_input.dart';

void main() {
  testWidgets("Login page widget test", (tester) async {
    await tester.pumpWidget(MyApp());

    expect(find.byType(CustomStringInput).first, findsOneWidget); //email feild
    expect(
        find.byType(CustomStringInput).last, findsOneWidget); //password feild
    expect(find.byKey(Key("login")), findsOneWidget); //login button
  });
}
