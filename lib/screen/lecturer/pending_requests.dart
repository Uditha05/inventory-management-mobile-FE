import 'package:flutter/material.dart';
import 'package:inventory_management/theme/app_colors.dart';
import 'package:inventory_management/widget/widget/request_list.dart';
import 'package:inventory_management/model/request_detai.dart';
import 'package:inventory_management/model/item.dart';

class PendingRequest extends StatefulWidget {
  @override
  _PendingRequestState createState() => _PendingRequestState();
}

class _PendingRequestState extends State<PendingRequest> {
  List<RequestDetail> requests = [
    RequestDetail(1, '180200X', Item(category: 'Projector',model: 'CA124-B',storeCode: 'NA255',labName: 'CSE Level 1 Lab'), '12/10/2021', '13/10/2021'),
    RequestDetail(2, '180200X', Item(category: 'Projector',model: 'CA124-B',storeCode: 'NA255',labName: 'CSE Level 1 Lab'), '12/10/2021', '13/10/2021'),
    RequestDetail(3, '180244B', Item(category: 'Projector',model: 'CA124-B',storeCode: 'NA255',labName: 'CSE Level 1 Lab'), '12/10/2021', '13/10/2021'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.main_green_background,
      appBar: AppBar(
        title: Text('Pending Requests'),
        backgroundColor: AppColor.main_green_background,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.all(10),
            child: Text(
              'Requests',
              style: TextStyle(
                color: Colors.white,
                fontSize: 19,
              ),
            ),
          ),
          Expanded(
            child: RequestList(requests),
          )
        ],
      ),
    );
  }
}
