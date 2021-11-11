import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inventory_management/screen/login/login_screen.dart';

import 'package:inventory_management/screen/office_clerk/handle_damage/handle_damage.dart';
import 'package:inventory_management/screen/settings/settings_screen.dart';
import 'package:get/get.dart';
import 'package:inventory_management/theme/app_colors.dart';
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
        actions: [
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => SettingsScreen()));
              })
        ],
      ),
      backgroundColor: AppColor.main_green_background,
      body: Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20),
              child: FaIcon(
                FontAwesomeIcons.tools,
                color: Colors.white,
                size: 80,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              key: Key("handleDamageOfficeC"),
              onTap: () {
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => HandleDamage()));
              },
              child: CardButton(
                title: "Handle Damage".tr,
                subtitle: "Handle damage item and repair".tr,
                icon: Icon(
                  Icons.handyman,
                  size: 80,
                  color: Colors.black,
                ),
              ),
            ),
            GestureDetector(
              key: Key("checkAvaOfficeC"),
              onTap: () {
                // Navigator.of(context).push(new MaterialPageRoute(
                //     builder: (BuildContext context) => CheckAvailability()));
              },
              child: CardButton(
                title: "Check Availability".tr,
                subtitle: "Check availability of the items".tr,
                icon: Icon(
                  Icons.check_box_rounded,
                  size: 80,
                  color: Colors.black,
                ),
              ),
            ),
            GestureDetector(
              key: Key("logoutOfficeC"),
              onTap: () {
                Navigator.of(context).pushReplacement(new MaterialPageRoute(
                    builder: (BuildContext context) => LoginScreen()));
              },
              child: CardButton(
                title: "Logout".tr,
                subtitle: "Logout from Office Clerk".tr,
                icon: Icon(
                  Icons.logout,
                  size: 80,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
