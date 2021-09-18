import 'package:flutter/material.dart';
import 'package:inventory_management/theme/app_colors.dart';
import 'package:inventory_management/widget/widget/item_list.dart';
import 'package:inventory_management/model/borrow_detail.dart';
import 'package:inventory_management/model/item.dart';

class BorrowItems extends StatefulWidget {

  @override
  _BorrowItemsState createState() => _BorrowItemsState();
}

class _BorrowItemsState extends State<BorrowItems> {
  List<BorrowDetail> details = [
    BorrowDetail(month: 'JAN',date: '16',data: Item(category: 'Projector',model: 'CA124-B',storeCode: 'NA255',labName: 'CSE Level 1 lab')),
    BorrowDetail(month: 'JAN',date: '16',data: Item(category: 'Hi-fi system',model: 'CA124-B',storeCode: 'NA255',labName: 'CSE Level 1 lab')),
    BorrowDetail(month: 'JAN',date: '16',data: Item(category: 'Router',model: 'CA124-B',storeCode: 'NA255',labName: 'CSE Level 1 lab')),
    BorrowDetail(month: 'JAN',date: '16',data: Item(category: 'Touch',model: 'CA124-B',storeCode: 'NA255',labName: 'CSE Level 1 lab')),
    BorrowDetail(month: 'JAN',date: '16',data: Item(category: 'Pen drive',model: 'CA124-B',storeCode: 'NA255',labName: 'CSE Level 1 lab')),
    BorrowDetail(month: 'JAN',date: '16',data: Item(category: 'Bluetooth Mouse',model: 'CA124-B',storeCode: 'NA255',labName: 'CSE Level 1 lab')),
    BorrowDetail(month: 'JAN',date: '16',data: Item(category: 'Sound system',model: 'CA124-B',storeCode: 'NA255',labName: 'CSE Level 1 lab')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.main_green_background,
      appBar: AppBar(
        title: Text('Borrowed Items'),
        backgroundColor: AppColor.main_green_background,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.all(10),
            child: Text(
              'Items: ${details.length}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 19,
              ),
            ),
          ),
          Expanded(
            child: ItemList(details),
          )
        ],
      ),
    );
  }
}







