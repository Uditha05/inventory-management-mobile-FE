import 'package:flutter/material.dart';

class CardButton extends StatelessWidget {
  final String title;
  final String subtitle;
  final Icon icon;
  const CardButton({Key key, this.title, this.icon, this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(14),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        color: Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 104,
            height: 103,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: Color(0xFF8A8A8A),
            ),
            child: icon,
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 24),
                ),
                Text(
                  subtitle,
                  // style: TextStyle(fontSize: 26),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
