import 'package:flutter/material.dart';
import 'package:inventory_management/model/avaiability_detail.dart';
import 'package:inventory_management/widget/widget/availability_list.dart';
import 'package:inventory_management/theme/app_colors.dart';
import 'package:inventory_management/model/item.dart';


class CheckAvailability extends StatefulWidget {

  @override
  _CheckAvailabilityState createState() => _CheckAvailabilityState();
}

class _CheckAvailabilityState extends State<CheckAvailability> {

  List<AvailabilityDetail> details = [
    AvailabilityDetail(availability: true,data: Item(category: 'Projector',model: 'CA124-B',storeCode: 'NA255',labName: 'CSE Level 1 lab'),availableDate: null),
    AvailabilityDetail(availability: false,data: Item(category: 'Hi-fi system',model: 'CA124-B',storeCode: 'NA255',labName: 'CSE Level 1 lab'),availableDate: '1/10/2021'),
    AvailabilityDetail(availability: true,data: Item(category: 'Router',model: 'CA124-B',storeCode: 'NA255',labName: 'CSE Level 1 lab'),availableDate: null),
    AvailabilityDetail(availability: false,data: Item(category: 'Touch',model: 'CA124-B',storeCode: 'NA255',labName: 'CSE Level 1 lab'),availableDate: '2/10/2021'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.main_green_background,
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){
              //logic of search
            }),
        ],
        title: Text('Check Availability'),
        backgroundColor: AppColor.main_green_background,
      ),
      body: Column(
        children: [
          Expanded(
            child: AvailabilityList(details,'student'),
          ),
        ],
      )
    );
  }
}
