import 'package:flutter/material.dart';
import 'package:inventory_management/theme/app_colors.dart';

class CardButton extends StatelessWidget {
  final String title;
  final String subtitle;
  final Icon icon;
  const CardButton({Key key, this.title, this.icon, this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.all(14),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        color: Colors.white,
      ),
      width: width,
      height: 100,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 104,
            height: 103,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: Colors.grey,
            ),
            child: icon,
          ),
          Container(
            margin: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: width,
                  child: Flexible(
                    child: Text(
                      title,
                      style: TextStyle(fontSize: 24, color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  width: width,
                  child: Flexible(
                    child: Text(
                      subtitle,
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
