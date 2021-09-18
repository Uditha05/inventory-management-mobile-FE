import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inventory_management/model/item.dart';


class ItemView extends StatelessWidget {
  final String availableDate;
  final Item itemDetail;
  ItemView({this.itemDetail,this.availableDate});
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
        child: Column(
          children: [
            Container(
              decoration: backgroundStyle,
              width: 300,
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.only(left: 10,bottom: 10,top: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('Category:',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                      Text('Model:',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                      Text('Store Code:',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                      Text('Lab Name:',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(width: 20,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(itemDetail.category,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                        Text(itemDetail.model,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                        Text(itemDetail.storeCode,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                        Text(itemDetail.labName,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: backgroundStyle,
              width: 300,
              margin: EdgeInsets.only(left: 10,right: 10,bottom: 10),
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.timesCircle,
                    color: Colors.red,
                    size: 30,
                  ),
                  SizedBox(width: 30,),
                  Text('Unavailable',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),)
                ],
              ),
            ),
            Container(
              decoration: backgroundStyle,
              width: 300,
              margin: EdgeInsets.only(left: 10,right: 10),
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.exclamationCircle,
                    color: Color(0xffB28521),
                    size: 30,
                  ),
                  SizedBox(width: 30,),
                  Text('Available on $availableDate',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),)
                ],
              ),
            ),
            SizedBox(height: 20,),
            TextButton(
              child: Text('OK',style: TextStyle(color: Colors.white,fontSize: 16),),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
              ),
              onPressed: (){
                print(availableDate);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

const backgroundStyle = BoxDecoration(
  color: Color(0xffC4C4C4),
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(10),
    bottomLeft: Radius.circular(10),
  ),
);
