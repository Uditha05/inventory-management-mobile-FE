import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inventory_management/widget/widget/button.dart';

void main(){
  testWidgets('Button has a text', (WidgetTester tester)async{
    await tester.pumpWidget(MaterialApp(
      home: Material(
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Center(
            child: Button(text: 'Button text',color: Colors.red,),
          ),
        ),
      ),
    ));
    final textFinder = find.text('Button text');
    expect(textFinder, findsOneWidget);
  });
}