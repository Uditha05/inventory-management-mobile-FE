import 'package:flutter/material.dart';
import 'package:inventory_management/config/constant_data.dart';
import 'package:inventory_management/model/request_list.dart';
import 'package:inventory_management/theme/app_colors.dart';
import 'package:inventory_management/widget/widget/request_list.dart';
import 'package:inventory_management/model/request_detai.dart';
import '../../services/lecturer_api.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PendingRequest extends StatefulWidget {
  @override
  _PendingRequestState createState() => _PendingRequestState();
}

class _PendingRequestState extends State<PendingRequest> {
  LecturerApi lecApi = new LecturerApi();
  RequestsList reqlist;
  List<RequestDetail> requests;

  @override
  void initState(){
    super.initState();
    updateUi(lecApi.getPendingRequest(ConstantData.USER_ID));
  }

  void updateUi(dynamic data)async{
    if(data==null){
      setState(() {
        requests=[];
        print('I am running again empty');
      });
    }else{
      reqlist = await data;
      setState(() {
        requests = reqlist.details;
        print(requests);
        print('I am running again');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.main_green_background,
      appBar: AppBar(
        title: Text('Pending Requests'),
        backgroundColor: AppColor.main_green_background,
      ),
      body: (reqlist==null)?Center(child: SpinKitDoubleBounce(color: Colors.white,size: 100,),) : Column(
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
