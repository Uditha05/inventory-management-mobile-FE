import 'package:flutter/material.dart';
import 'package:inventory_management/theme/app_colors.dart';
import 'package:inventory_management/widget/widget/normal_borrowing_request.dart';
import 'package:inventory_management/widget/widget/temporal_borrowing_request.dart';


class BorrowingRequest extends StatefulWidget {

  @override
  _BorrowingRequestState createState() => _BorrowingRequestState();
}

class _BorrowingRequestState extends State<BorrowingRequest> with SingleTickerProviderStateMixin{
  TabController tabController;
  @override
  void initState(){
    super.initState();
    tabController = TabController(vsync: this,initialIndex: 0,length: 2);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.main_green_background,
      appBar: AppBar(
        title: Text('Add Borrowing Request'),
        backgroundColor: AppColor.main_green_background,
        elevation: 0.7,
        bottom: TabBar(
          controller: tabController,
          indicatorColor: Colors.white,
          tabs: <Widget>[
            Tab(text: 'Normal Borrowing',),
            Tab(text: 'Temporal Borrowing',),
          ],
        ),
      ),
      body:TabBarView(
        controller: tabController,
        children: <Widget>[
          NormalBorrowingRequest(),
          TemporalBorrowingRequest(),
        ],
      ),
    );
  }
}
