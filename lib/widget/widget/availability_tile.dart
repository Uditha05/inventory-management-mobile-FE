import 'package:flutter/material.dart';
import 'package:inventory_management/screen/lecturer/add_request.dart';
import 'package:inventory_management/screen/student/borrowing_request.dart';
import 'package:inventory_management/screen/student/tile_style.dart';
import 'package:inventory_management/model/item.dart';
import 'package:inventory_management/widget/widget/normal_borrowing_request.dart';
import 'button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'icon_content.dart';
//import 'package:inventory_management/screen/student/add_request_form.dart';
import 'package:inventory_management/screen/student/view_item.dart';

class AvailabilityTile extends StatelessWidget {
  final bool availability;
  final Item itemDetail;
  final String availableDate;
  final String type;

  AvailabilityTile(
      {this.availability, this.itemDetail, this.availableDate, this.type});

  @override
  Widget build(BuildContext context) {
    //print(availability);
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
              image: NetworkImage(
                itemDetail.imageURL),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 30, right: 10),
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
              availability
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Button(
                          text: 'Avaiable',
                          color: Color(0xff3B885B),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        IconContent(
                          icon: FontAwesomeIcons.pen,
                          onTap: () {
                            if (type == "officeClerk") {
                              return;
                            }
                            // showModalBottomSheet(
                            //   context: context,
                            //   isScrollControlled: true,
                            //   // builder: (context)=>AddRequest(itemDetail: itemDetail,),
                            //   builder: (context) => SingleChildScrollView(
                            //     child: Container(
                            //       padding: EdgeInsets.only(
                            //           bottom: MediaQuery.of(context)
                            //               .viewInsets
                            //               .bottom),
                            //       child: AddRequest(
                            //           itemDetail: itemDetail, type: type),
                            //     ),
                            //   ),
                            // );
                            else if(type=="lecturer"){
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(builder: (context)=>AddRequest(),),
                              // );
                              Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddRequest(),
                              ),
                            );
                            }
                            else{
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BorrowingRequest(),
                              ),
                            );}
                          },
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        Button(
                          text: 'Unavailble',
                          color: Colors.red,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        IconContent(
                          icon: FontAwesomeIcons.eye,
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => ItemView(
                                  itemDetail: itemDetail,
                                  availableDate: availableDate),
                            );
                          },
                        ),
                      ],
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
