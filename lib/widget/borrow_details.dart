import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inventory_management/services/borrow_data.dart';
import 'package:inventory_management/theme/app_colors.dart';

class BorrowDetails extends StatelessWidget {
  final BorrowData data;
  const BorrowDetails({this.data});

  String getDateNTime(DateTime dateTime) {
    return dateTime.month.toString() +
        '/' +
        dateTime.day.toString() +
        '/' +
        dateTime.year.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20)),
        color: data.status == 'close' ? Colors.white12 : Colors.redAccent,
      ),
      height: 120,
      width: 150,
      child: Padding(
        padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Type:-${data.type}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                Text(
                  'Name:-${data.name}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
                Text(
                  'Status:-${data.status}',
                  style: TextStyle(
                    color: Colors.grey[400],
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 5,
            ),
            Container(
              width: 140,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "From : " + getDateNTime(data.fromDate),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    "To : " + getDateNTime(data.toDate),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    data.returnDate != null
                        ? "returnDate:\n" + getDateNTime(data.returnDate)
                        : '-',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                UserTypeIcon(
                  data: data,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class UserTypeIcon extends StatelessWidget {
  final BorrowData data;
  const UserTypeIcon({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (data.type.toLowerCase()) {
      case ("lecturer"):
        return Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.grey[200],
          ),
          child: Icon(FontAwesomeIcons.graduationCap),
        );
        break;
      case ("temporary"):
        return Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.grey[200],
          ),
          child: Icon(FontAwesomeIcons.userGraduate),
        );
      case ("normal"):
        return Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.grey[200],
          ),
          child: Icon(FontAwesomeIcons.userGraduate),
        );
      default:
        return Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.grey[200],
          ),
          child: Icon(FontAwesomeIcons.userGraduate),
        );
    }
  }
}
