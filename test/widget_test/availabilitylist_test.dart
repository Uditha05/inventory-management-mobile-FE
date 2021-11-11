import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inventory_management/model/avaiability_detail.dart';
import 'package:inventory_management/model/item.dart';
import 'package:inventory_management/widget/widget/availability_list.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main(){
  List<AvailabilityDetail> lst;
  setUp((){
    lst =[AvailabilityDetail(availability: true,data: Item(category: 'Camera',model: 'Model',storeCode: '123',labName: 'lab',imageURL:'abc.com'),availableDate: '20-09-2021')];
  });

  group('Show scrollable listView',(){
    testWidgets('Display scrollable available list', (WidgetTester tester)async{
      await mockNetworkImagesFor(()async=>await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: AvailabilityList(details: [],type: 'lecturer',),
        ),
      )));
      final list = find.byType(Scrollable);
      expect(list,findsNothing);
    });
  });

  group('Ctegory in the available list',(){
    testWidgets('Camera in the availabilitylist test', (WidgetTester tester)async{
      await mockNetworkImagesFor(()async=>await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: AvailabilityList(details: lst,type: 'lecturer',),
        ),
      )));
      final text = find.text('Camera');
      expect(text, findsOneWidget);
    });
  });

  group('Model in the available list',(){
    testWidgets('Model in the availabilitylist test', (WidgetTester tester)async{
      await mockNetworkImagesFor(()async=>await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: AvailabilityList(details: lst,type: 'lecturer',),
        ),
      )));
      //final list = find.byType(Scrollable);
      final text = find.text('Model');
      expect(text, findsOneWidget);
    });
  });

  group('StoreCode in the available list',(){
    testWidgets('storecode in the availabilitylist test', (WidgetTester tester)async{
      await mockNetworkImagesFor(()async=>await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: AvailabilityList(details: lst,type: 'lecturer',),
        ),
      )));
      //final list = find.byType(Scrollable);
      final text = find.text('123');
      expect(text, findsOneWidget);
    });
  });

  group('LabName in the available list',(){
    testWidgets('labName in the availabilitylist test', (WidgetTester tester)async{
      await mockNetworkImagesFor(()async=>await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: AvailabilityList(details: lst,type: 'lecturer',),
        ),
      )));
      //final list = find.byType(Scrollable);
      final text = find.text('lab');
      expect(text, findsOneWidget);
    });
  });

}