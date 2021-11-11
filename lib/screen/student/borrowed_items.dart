import 'package:flutter/material.dart';
import 'package:inventory_management/config/constant_data.dart';
import 'package:inventory_management/model/borrow_detail_list.dart';
import 'package:inventory_management/services/student_api.dart';
import 'package:inventory_management/theme/app_colors.dart';
import 'package:inventory_management/widget/widget/item_list.dart';
import 'package:inventory_management/model/borrow_detail.dart';
import 'package:inventory_management/model/item.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class BorrowItems extends StatefulWidget {

  @override
  _BorrowItemsState createState() => _BorrowItemsState();
}

class _BorrowItemsState extends State<BorrowItems> {
  
  StudentApi studentApi = StudentApi();
  BorrowDetailList datalist;
  List<BorrowDetail> lst;

  @override
  void initState() {
    super.initState();
    updateUi(studentApi.getBorrowingHistory(ConstantData.USER_ID));

  }

  void updateUi (dynamic data) async{
    if(data==null){
      print('null val');
      setState(() {
        lst = [];
      });
      
    }else{
      datalist = await data;
      setState(() {
        lst = datalist.details;
        //print(lst);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.main_green_background,
      appBar: AppBar(
        title: Text('Borrowed Items'),
        backgroundColor: AppColor.main_green_background,
      ),
      body: (datalist==null)?Center(child: SpinKitDoubleBounce(color: Colors.white,size: 100,)):Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.all(10),
            child: Text(
              'Items: ${lst.length}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 19,
              ),
            ),
          ),
          Expanded(
            child: ItemList(lst),
          )
        ],
      ),
    );
  }
}







