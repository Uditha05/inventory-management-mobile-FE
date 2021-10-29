import 'package:flutter/material.dart';
import 'package:inventory_management/screen/login/login_screen.dart';

import 'package:inventory_management/screen/settings/settings_screen.dart';

import 'package:inventory_management/widget/card_button.dart';

class TechnicalOfficerDashboard extends StatefulWidget {
  TechnicalOfficerDashboard({Key key}) : super(key: key);

  @override
  _TechnicalOfficerDashboardState createState() =>
      _TechnicalOfficerDashboardState();
}

class _TechnicalOfficerDashboardState extends State<TechnicalOfficerDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Technical Officer",
          style: TextStyle(fontSize: 25),
        ),
        leading: Container(),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => SettingsScreen()));
              })
        ],
      ),
      body: Container(
        child: Column(
          children: [
            // GestureDetector(
            //   onTap: () {
            //     Navigator.of(context).push(new MaterialPageRoute(
            //         builder: (BuildContext context) => HandleDamage()));
            //   },
            //   child: CardButton(
            //     title: "Handle Damage",
            //     subtitle: "Handle damage item and repair",
            //     icon: Icon(
            //       Icons.handyman,
            //       size: 50,
            //       color: Colors.white,
            //     ),
            //   ),
            // ),
            // GestureDetector(
            //   onTap: () {
            //     Navigator.of(context).push(new MaterialPageRoute(
            //         builder: (BuildContext context) => CheckAvailability()));
            //   },
            //   child: CardButton(
            //     title: "Check Availability",
            //     subtitle: "check availability of the items",
            //     icon: Icon(
            //       Icons.check_box_rounded,
            //       size: 50,
            //       color: Colors.white,
            //     ),
            //   ),
            // ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(new MaterialPageRoute(
                    builder: (BuildContext context) => LoginScreen()));
              },
              child: CardButton(
                title: "Logout",
                subtitle: "Log out from Officer",
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
