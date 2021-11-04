import 'package:flutter/material.dart';
//import 'package:shared_preferences/shared_preferences.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:inventory_management/config/asset_config.dart';
import 'package:inventory_management/controller/auth_controller.dart';
import 'package:inventory_management/screen/lecturer/lecturer_dashboard.dart';
import 'package:inventory_management/screen/loading_screen.dart';
import 'package:inventory_management/screen/login/login_screen.dart';
import 'package:inventory_management/screen/office_clerk/office_clerk_dashboard.dart';
import 'package:inventory_management/screen/student/student_dashboard.dart';
import 'package:inventory_management/screen/technicla_officer_dashboard/technical_officer_dashboard.dart';

import 'package:inventory_management/theme/app_colors.dart';

class LoadingScreen extends StatefulWidget {
  LoadingScreen({Key key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    loadUser();
  }

  void loadUser() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    String email; //= prefs.getString("email");
    String password; //= prefs.getString("password");

    if (email != null && password != null) {
      var out = await AuthController().submitUserNamePassword(email, password);
      if (out == null) {
        Fluttertoast.showToast(
            msg: "Invalid Email or Password",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: AppColor.toast_msg_warning,
            textColor: Colors.white,
            fontSize: 13.0);
        Navigator.of(context).pushReplacement(new MaterialPageRoute(
            builder: (BuildContext context) => LoginScreen()));
        return;
      }
      redirectToDashboard(out);
    } else {
      Navigator.of(context).pushReplacement(new MaterialPageRoute(
          builder: (BuildContext context) => LoginScreen()));
    }
  }

  void redirectToDashboard(String type) {
    if (type == "Student") {
      Navigator.of(context).pushReplacement(new MaterialPageRoute(
          builder: (BuildContext context) => StudentDashboard()));
    } else if (type == "Lecturer") {
      Navigator.of(context).pushReplacement(new MaterialPageRoute(
          builder: (BuildContext context) => LecturerDashboard()));
    } else if (type == "OfficeClerk") {
      Navigator.of(context).pushReplacement(new MaterialPageRoute(
          builder: (BuildContext context) => OfficeClerkDashboard()));
    } else if (type == "TechnicalOfficer") {
      Navigator.of(context).pushReplacement(new MaterialPageRoute(
          builder: (BuildContext context) => TechnicalOfficerDashboard()));
    } else {
      Fluttertoast.showToast(
          msg: "Something went wrong! Try again later!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColor.toast_msg_warning,
          textColor: Colors.white,
          fontSize: 13.0);
      Navigator.of(context).pushReplacement(new MaterialPageRoute(
          builder: (BuildContext context) => LoginScreen()));
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
