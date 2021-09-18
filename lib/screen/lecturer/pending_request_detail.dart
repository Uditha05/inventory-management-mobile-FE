import 'package:flutter/material.dart';
import 'package:inventory_management/model/item.dart';

class PendingRequestDetail extends StatelessWidget {
  final String studentId;
  final Item item;
  final String fromDate;
  final String toDate;

  PendingRequestDetail(this.studentId,this.item,this.fromDate,this.toDate);

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
                              Text(studentId,style: TextStyle(fontSize: 16,fontWeight: FontWeight.normal),),
                              Text(item.category,style: TextStyle(fontSize: 16,fontWeight: FontWeight.normal),),
                              Text(item.model,style: TextStyle(fontSize: 16,fontWeight: FontWeight.normal),),
                              Text(item.storeCode,style: TextStyle(fontSize: 16,fontWeight: FontWeight.normal),),
                              Text(item.labName,style: TextStyle(fontSize: 16,fontWeight: FontWeight.normal),),
                              Text(fromDate,style: TextStyle(fontSize: 16,fontWeight: FontWeight.normal),),
                              Text(toDate,style: TextStyle(fontSize: 16,fontWeight: FontWeight.normal),),
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
                    print('reject');
                    Navigator.pop(context);
                    },
                ),
                TextButton(
                  child: Text('Approve',style: TextStyle(color: Colors.white,fontSize: 18),),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                  ),
                  onPressed: (){
                    print('approve');
                    Navigator.pop(context);
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
