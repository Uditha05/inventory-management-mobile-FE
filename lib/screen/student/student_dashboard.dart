import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inventory_management/screen/login/login_screen.dart';
import 'package:inventory_management/screen/settings/settings_screen.dart';
import 'package:inventory_management/theme/app_colors.dart';
import 'package:inventory_management/screen/student/borrowed_items.dart';
import 'package:inventory_management/screen/student/check_availability.dart';
import 'package:inventory_management/widget/widget/dashboard_background.dart';
import 'package:inventory_management/widget/widget/dashboard_card.dart';
import 'package:inventory_management/screen/student/borrowing_request.dart';

import 'dashboard_style.dart';

class StudentDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.main_green_background,
      appBar: AppBar(
        title: Text('Student'),
        centerTitle: true,
        backgroundColor: AppColor.main_green_background,
        actions: [
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => SettingsScreen()));
              })
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              DashboardBackground(),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: FaIcon(
                  FontAwesomeIcons.userGraduate,
                  color: Colors.white,
                  size: 80,
                ),
              ),
              ReusableCard(
                BorrowItems(),
                Icon(
                  Icons.view_list,
                  size: 80,
                ),
                [
                  Text(
                    'View Borrowed Items',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  Text('View the list of borrowed items'),
                ],
              ),
              ReusableCard(
                CheckAvailability(
                  type: 'student',
                ),
                Icon(
                  Icons.book,
                  size: 80,
                ),
                [
                  Text(
                    'Check Availability',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  Text('Check equipment availability'),
                  Text('Request for equipments'),
                ],
              ),
              ReusableCard(
                  BorrowingRequest(),
                  Icon(
                    Icons.request_page,
                    size: 80,
                  ),
                  [
                    Text(
                      'Add Borrowing Requests',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    Text('Add normal borrowing request'),
                    Text('Add temporal borrowing request'),
                  ]),
              GestureDetector(
                child: Container(
                  decoration: cardBackground,
                  margin: EdgeInsets.only(bottom: 10, top: 20),
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: imageBackground,
                        child: Icon(
                          Icons.logout,
                          size: 80,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Logout',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pushReplacement(new MaterialPageRoute(
                      builder: (BuildContext context) => LoginScreen()));
                },
              ),
              SizedBox(height: 10)
            ],
          ),
        ),
      ),
    );
  }
}
