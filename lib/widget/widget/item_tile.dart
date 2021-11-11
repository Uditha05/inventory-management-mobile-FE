import 'package:flutter/material.dart';
import 'package:inventory_management/screen/student/tile_style.dart';
import 'package:inventory_management/model/item.dart';

class ItemTile extends StatelessWidget {
  final String month;
  final String date;
  final Item itemDetail;

  ItemTile({this.month, this.date, this.itemDetail});

  @override
  Widget build(BuildContext context) {
    print(month);
    print(date);
    print(itemDetail.category);
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                month,
                //'month',
                style: dateStyle,
              ),
              Text(
                date,
                //'date',
                style: dateStyle,
              )
            ],
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 50, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    //'item',
                    itemDetail.category,
                    style: dataCategoryStyle,
                  ),
                  Text(
                    //'model',
                    itemDetail.model,
                    style: dataDetailStyle,
                  ),
                  Text(
                    //'scode',
                    itemDetail.storeCode,
                    style: dataDetailStyle,
                  ),
                  Text(
                    //'lab',
                    itemDetail.labName,
                    style: dataDetailStyle,
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 100,
            height: 100,
            child: Image(
              image: NetworkImage(itemDetail.imageURL),
              //image: NetworkImage('http://res.cloudinary.com/inventorysep/image/upload/v1636624241/ht5t0warynpmbheoi6fr.jpg'),
            ),
          )
        ],
      ),
    );
  }
}
