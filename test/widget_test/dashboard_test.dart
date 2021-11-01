import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management/widget/widget/dashboard_background.dart';
import 'package:inventory_management/widget/widget/dashboard_card.dart';

void main(){
  Icon icon;
  List<Widget> cardChildren;
  Object obj;
  setUp((){
    icon = Icon(Icons.notifications);
    cardChildren = [Text('Hello'),Text('world')];
    obj = null;
  });

  group('test dashboard card widget', (){
    testWidgets('test text in the card', (WidgetTester tester)async{
      await tester.pumpWidget(MaterialApp(
        home:Scaffold(
          body: ReusableCard(obj,icon,cardChildren),
        ),
      ));
      expect(find.text('Hello'),findsOneWidget);
    });

    testWidgets('test icon in the card',(WidgetTester tester)async{
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: ReusableCard(obj,icon,cardChildren),
        ),
      ));
      expect(find.byIcon(Icons.notifications), findsOneWidget);
    });
  });
}