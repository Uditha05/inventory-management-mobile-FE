import 'package:flutter/material.dart';
import 'package:inventory_management/screen/accept_equipment/accept_equipment.dart';
import 'package:inventory_management/screen/add_update_equipment/add_update_equipment.dart';
import 'package:inventory_management/screen/issue_equipment/issue_equipment.dart';
import 'package:inventory_management/screen/login/login_screen.dart';
import 'package:inventory_management/screen/technicla_officer_dashboard/technical_officer_dashboard.dart';
import 'package:inventory_management/screen/view_track/view_track.dart';
import 'package:inventory_management/screen/view_track/view_track_details.dart';
import 'package:inventory_management/widget/chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: TechnicalOfficerDashboard(),
      debugShowCheckedModeBanner: false,
    );
  }
}
