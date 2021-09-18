import 'package:flutter/material.dart';
import 'package:inventory_management/screen/student/dashboard_style.dart';

class ReusableCard extends StatelessWidget {
  final Object object;
  final Icon icon;
  final List<Widget> cardChildren;
  ReusableCard(this.object,this.icon,this.cardChildren);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: cardBackground,
        margin: EdgeInsets.only(bottom: 10, top: 20),
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(5),
              decoration: imageBackground,
              child: icon,
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: cardChildren,
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => object,
          ),
        );
      },
    );
  }
}