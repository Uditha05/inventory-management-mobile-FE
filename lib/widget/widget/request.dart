import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inventory_management/model/request_detai.dart';
import 'package:inventory_management/screen/lecturer/pending_request_detail.dart';
import 'package:intl/intl.dart';

class Request extends StatelessWidget {

  final RequestDetail request;
  Request(this.request);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color(0xff4CAB8B),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('StudentId:',style: textStyle,),
              Text('Store Code:',style: textStyle,),
              Text('Request Date:',style: textStyle,),
            ],
          ),
          SizedBox(width: 15,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(request.studentId,style: textStyle,),
                Text(request.storeCode,style: textStyle,),
                Text(DateFormat('dd/MM/yyyy').format(DateTime.parse(request.requestDate)),style: textStyle,),
              ],
            ),
          ),
          Text('Pending', style: TextStyle(color: Colors.amber,fontSize: 17),),
          TextButton(
            child: FaIcon(FontAwesomeIcons.ellipsisH,color: Colors.amber,),
            onPressed: (){
              showModalBottomSheet(
                context: context,
                builder: (context)=> PendingRequestDetail(id: request.id.toString(),),
              ).whenComplete(() => print('hi therer'));
            },
          ),
        ],
      ),
    );
  }
}

const textStyle = TextStyle(fontSize: 16,fontWeight: FontWeight.bold);
