import 'package:flutter/material.dart';
import 'package:inventory_management/widget/card_button.dart';

class OfficeClerkDashboard extends StatefulWidget {
  OfficeClerkDashboard({Key key}) : super(key: key);

  @override
  _OfficeClerkDashboardState createState() => _OfficeClerkDashboardState();
}

class _OfficeClerkDashboardState extends State<OfficeClerkDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Office Clerk",
          style: TextStyle(fontSize: 25),
        ),
        leading: Container(),
        centerTitle: true,
      ),
      backgroundColor: Colors.green,
      body: Container(
        child: Column(
          children: [
            GestureDetector(
              child: CardButton(
                title: "Handle Damage",
                subtitle: "All ",
                icon: Icon(
                  Icons.handyman,
                  size: 50,
                  color: Colors.white,
                ),
              ),
            ),
            GestureDetector(
              child: CardButton(
                title: "Check Availability",
                subtitle: "Test Subtitle",
                icon: Icon(
                  Icons.check_box_rounded,
                  size: 50,
                  color: Colors.white,
                ),
              ),
            ),
            GestureDetector(
              child: CardButton(
                title: "Logout",
                subtitle: "Log out from Office Clerk",
                icon: Icon(
                  Icons.logout,
                  size: 50,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
