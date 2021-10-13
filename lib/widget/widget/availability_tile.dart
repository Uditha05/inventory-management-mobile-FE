import 'package:flutter/material.dart';
import 'package:inventory_management/screen/student/tile_style.dart';
import 'package:inventory_management/model/item.dart';
import 'button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'icon_content.dart';
import 'package:inventory_management/screen/student/add_request_form.dart';
import 'package:inventory_management/screen/student/view_item.dart';

class AvailabilityTile extends StatelessWidget {
  final bool availability;
  final Item itemDetail;
  final String availableDate;
  final String type;

  AvailabilityTile({this.availability,this.itemDetail,this.availableDate,this.type});

  @override
  Widget build(BuildContext context) {
    //print(availableDate);
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Color(0xff4CAB8B),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 100,
            height: 100,
            child: Image(
              image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQTCKA6akZjVZfHmZaluLOTZzE-3_j_-MBScw&usqp=CAU'),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 30,right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    itemDetail.category,
                    style: dataCategoryStyle,
                  ),
                  Text(
                    itemDetail.model,
                    style: dataDetailStyle,
                  ),
                  Text(
                    itemDetail.storeCode,
                    style: dataDetailStyle,
                  ),
                  Text(
                    itemDetail.labName,
                    style: dataDetailStyle,
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              availability ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Button(text: 'Avaiable',color: Color(0xff3B885B),),
                      SizedBox(height: 5,),
                      IconContent(icon: FontAwesomeIcons.pen,onTap: (){
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          // builder: (context)=>AddRequest(itemDetail: itemDetail,),
                          builder: (context) => SingleChildScrollView(
                            child: Container(
                              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                              child: AddRequest(itemDetail: itemDetail,type: type),
                            ),
                          ),
                        );
                      },),
                    ],
                  ) : Column(
                children: [
                    Button(text: 'Unavailble',color: Colors.red,),
                    SizedBox(height: 5,),
                    IconContent(icon: FontAwesomeIcons.eye,onTap: (){
                      showModalBottomSheet(
                        context: context,
                        builder: (context)=> ItemView(itemDetail: itemDetail, availableDate: availableDate),
                      );
                    },),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}


