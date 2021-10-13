import 'package:flutter/material.dart';
import 'package:inventory_management/screen/login/login_screen.dart';
import 'package:inventory_management/screen/student/check_availability.dart';
import 'package:inventory_management/screen/lecturer/pending_requests.dart';
import 'package:inventory_management/screen/student/borrowed_items.dart';
import 'package:inventory_management/screen/student/student_dashboard.dart';
import 'package:inventory_management/screen/lecturer/lecturer_dashboard.dart';

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
      //home: LoginScreen(),
      home: StudentDashboard(),
      //home: LecturerDashboard(),
      debugShowCheckedModeBanner: false,
    );
  }
}
