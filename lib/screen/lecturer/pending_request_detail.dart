import 'package:flutter/material.dart';
import 'package:inventory_management/config/constant_data.dart';
import 'package:inventory_management/services/lecturer_api.dart';
import '../../model/pending_detail.dart';
import 'package:intl/intl.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PendingRequestDetail extends StatefulWidget {
  final String id;
  PendingRequestDetail({this.id});

  @override
  _PendingRequestDetailState createState() => _PendingRequestDetailState();
}

class _PendingRequestDetailState extends State<PendingRequestDetail> {
  LecturerApi lecApi = LecturerApi();
  PendingDetail detail;

  @override
  void initState(){
    super.initState();
    updateUi(lecApi.getPendingItemDetail(widget.id));
  }

  void updateUi(dynamic data)async{
    var dtail = await data;
    setState(() {
      detail=dtail;
      print(detail);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff003e29),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Color(0xff3B885B),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: (detail==null)?Center(child: SpinKitFadingFour(color: Colors.white,size: 100,),):Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              padding: EdgeInsets.all(10),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xffC4C4C4),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
                padding: EdgeInsets.all(5),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('StudentID:',style: TextStyle(fontSize: 16,fontWeight: FontWeight.normal),),
                              Text('Category:',style: TextStyle(fontSize: 16,fontWeight: FontWeight.normal),),
                              Text('Model:',style: TextStyle(fontSize: 16,fontWeight: FontWeight.normal),),
                              Text('Store Code:',style: TextStyle(fontSize: 16,fontWeight: FontWeight.normal),),
                              Text('Lab Name:',style: TextStyle(fontSize: 16,fontWeight: FontWeight.normal),),
                              Text('From date:',style: TextStyle(fontSize: 16,fontWeight: FontWeight.normal),),
                              Text('Due Date:',style: TextStyle(fontSize: 16,fontWeight: FontWeight.normal),),
                            ],
                          ),
                          SizedBox(width: 10,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(detail.studentId,style: TextStyle(fontSize: 16,fontWeight: FontWeight.normal),),
                              Text(detail.item.category,style: TextStyle(fontSize: 16,fontWeight: FontWeight.normal),),
                              Text(detail.item.model,style: TextStyle(fontSize: 16,fontWeight: FontWeight.normal),),
                              Text(detail.item.storeCode,style: TextStyle(fontSize: 16,fontWeight: FontWeight.normal),),
                              Text(detail.item.labName,style: TextStyle(fontSize: 16,fontWeight: FontWeight.normal),),
                              Text(DateFormat('dd/MM/yyyy').format(DateTime.parse(detail.fromDate)),style: TextStyle(fontSize: 16,fontWeight: FontWeight.normal),),
                              Text(DateFormat('dd/MM/yyyy').format(DateTime.parse(detail.dueDate)),style: TextStyle(fontSize: 16,fontWeight: FontWeight.normal),),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  child: Text('Reject',style: TextStyle(color: Colors.white,fontSize: 18),),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                  ),
                  onPressed: (){
                    print('reject'+widget.id);
                    var data = lecApi.rejectRequest(widget.id,{"id":widget.id,"category":detail.item.category,"storeCode":detail.item.storeCode,"lecId":ConstantData.USER_ID,"studentId":detail.studentId});
                    Navigator.pop(context);
                    (data==null)?Text('Loading....'): Navigator.popUntil(context, (route) => route.isFirst);
                    },
                ),
                TextButton(
                  child: Text('Approve',style: TextStyle(color: Colors.white,fontSize: 18),),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                  ),
                  onPressed: (){
                    print('approve');
                    var data=lecApi.approveRequest(widget.id,{"id":widget.id,"category":detail.item.category,"storeCode":detail.item.storeCode,"lecId":ConstantData.USER_ID,"studentId":detail.studentId});
                    (data==null)?Text('Loading....'): Navigator.popUntil(context, (route) => route.isFirst);
                    //(data==null)?Text('Loading....'): Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>PendingRequest()));
                    },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
