import 'package:flutter/material.dart';
import 'package:inventory_management/model/dummy/broken_item.dart';
import 'package:intl/intl.dart';

class BrokenItemViewCard extends StatelessWidget {
  final BrokenItem brokenItem;
  final bool isOld;
  const BrokenItemViewCard({
    Key key,
    this.brokenItem,
    @required this.isOld,
  }) : super(key: key);

  String closeDate(dateString) {
    print(dateString);
    if (!isOld) {
      return "Not closed";
    } else {
      var date = DateTime.parse(dateString.toString());
      return DateFormat.yMMMd().format(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        color: Colors.grey,
      ),
      height: isOld ? 160 : 135,
      margin: EdgeInsets.all(10),
      child: Row(
        children: [
          //image
          Container(
            width: 100,
            height: 100,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13),
              color: Colors.white,
            ),
            child: Image(
              image: NetworkImage(brokenItem.image),
            ),
          ),
          //colunm - category/model/storecode
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                isOld
                    ? Label_Value(
                        "Close Date: ", closeDate(brokenItem.closeDate))
                    : Container(),
                Label_Value("Category: ", brokenItem.category),
                Label_Value("Model: ", brokenItem.model),
                Label_Value("Store Code: ", brokenItem.storeCode),
                Label_Value("Issue: ", brokenItem.issue),
                Label_Value("Open Date: ",
                    DateFormat.yMMMd().format(brokenItem.openDate)),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget Label_Value(String lable, String value) {
    return Container(
      child: Row(
        children: [
          Text(
            lable,
            style: TextStyle(color: const Color(0xFF5A5E5C), fontSize: 20),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 17),
          )
        ],
      ),
    );
  }
}
