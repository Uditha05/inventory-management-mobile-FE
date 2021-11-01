import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inventory_management/model/borrow_detail.dart';
import 'package:inventory_management/model/item.dart';
import 'package:inventory_management/widget/widget/item_list.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main(){
  List<BorrowDetail> details;
  setUp((){
    details=[BorrowDetail(month: 'JAN',date: '20', data: Item(category: 'Camera',model: 'Model',storeCode: '123',labName: 'lab'))];
  });
  testWidgets('Show scrollable list view', (WidgetTester tester)async{
    await mockNetworkImagesFor(()async=>await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ItemList(details),
      ),
    )));
    expect(find.byType(Scrollable),findsOneWidget);
  });

  testWidgets('test month in the list view', (WidgetTester tester)async{
    await mockNetworkImagesFor(()async=>await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ItemList(details),
      ),
    )));
    expect(find.text('JAN'),findsOneWidget);
  });

  testWidgets('test date in the list view', (WidgetTester tester)async{
    await mockNetworkImagesFor(()async=>await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ItemList(details),
      ),
    )));
    expect(find.text('20'),findsOneWidget);
  });

  testWidgets('test category in the list view', (WidgetTester tester)async{
    await mockNetworkImagesFor(()async=>await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ItemList(details),
      ),
    )));
    expect(find.text('Camera'),findsOneWidget);
  });

  testWidgets('test model in the list view', (WidgetTester tester)async{
    await mockNetworkImagesFor(()async=>await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ItemList(details),
      ),
    )));
    expect(find.text('Model'),findsOneWidget);
  });

  testWidgets('test storeCode in list view', (WidgetTester tester)async{
    await mockNetworkImagesFor(()async=>await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ItemList(details),
      ),
    )));
    expect(find.text('123'),findsOneWidget);
  });

  testWidgets('test labName in list view', (WidgetTester tester)async{
    await mockNetworkImagesFor(()async=>await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ItemList(details),
      ),
    )));
    expect(find.text('lab'),findsOneWidget);
  });

}