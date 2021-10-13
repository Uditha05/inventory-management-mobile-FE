import 'package:flutter/material.dart';
import 'package:inventory_management/model/avaiability_detail.dart';
import 'package:inventory_management/model/availability_detail_list.dart';
import 'package:inventory_management/widget/widget/availability_list.dart';
import 'package:inventory_management/theme/app_colors.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../services/lecturer_api.dart';


class CheckAvailability extends StatefulWidget {

  @override
  _CheckAvailabilityState createState() => _CheckAvailabilityState();
}

class _CheckAvailabilityState extends State<CheckAvailability> {

  LecturerApi lecApi = LecturerApi();
  AvailabilityDetailList detalist;
  List<AvailabilityDetail> lst;

  @override
  void initState(){
    super.initState();
    updateUi(lecApi.getItems());
  }

  void updateUi (dynamic data) async{
    if(data==null){
      print('null val');
      lst = [];
    }else{
      detalist = await data;
      setState(() {
        lst = detalist.details;
      });
    }
  }

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
      body: (detalist==null) ?Center(child: SpinKitDoubleBounce(color: Colors.white,size: 100,),):Column(
        children: [
          Expanded(
            child: AvailabilityList(lst,'lecturer'),
          ),
        ],
      )
    );
  }
}
