import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inventory_management/config/asset_config.dart';
import 'package:inventory_management/controller/auth_controller.dart';
import 'package:inventory_management/screen/lectureDashboard.dart';
import 'package:inventory_management/screen/loading_screen.dart';
import 'package:inventory_management/screen/office_clerk/office_clerk_dashboard.dart';
import 'package:inventory_management/screen/sudentDashboard.dart';
import 'package:inventory_management/screen/technicalOfficerDashboard.dart';

import 'package:inventory_management/theme/app_colors.dart';
import 'package:inventory_management/theme/app_text_style.dart';
import 'package:inventory_management/widget/custom_button.dart';
import 'package:inventory_management/widget/custom_password_input.dart';
import 'package:inventory_management/widget/custom_string_input.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  void submitUsernameAndPassword() async {
    if (usernameController.text.trim().isEmpty) {
      Fluttertoast.showToast(
          msg: "Invalid username",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColor.toast_msg_warning,
          textColor: Colors.white,
          fontSize: 13.0);
      return;
    } else if (passwordController.text.trim().isEmpty) {
      Fluttertoast.showToast(
          msg: "Invalid password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColor.toast_msg_warning,
          textColor: Colors.white,
          fontSize: 13.0);
      return;
    } else {
      var out = await AuthController().submitUserNamePassword(
          usernameController.text.trim(), passwordController.text.trim());
      // var out = await AuthController().checkLogin(
      //     usernameController.text.trim(), passwordController.text.trim());

      if (out == null) {
        Fluttertoast.showToast(
            msg: "Invalid Email or Password",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: AppColor.toast_msg_warning,
            textColor: Colors.white,
            fontSize: 13.0);
        return;
      }
      redirectToDashboard(out);

      // Navigator.push(context,
      //     MaterialPageRoute(builder: (context) => LoadingPage.fromBase64(out)));

    }
  }

  void redirectToDashboard(String type) {
    if (type == "Student") {
      Navigator.of(context).pushReplacement(new MaterialPageRoute(
          builder: (BuildContext context) => StudentDashboard()));
    } else if (type == "Lecturer") {
      Navigator.of(context).pushReplacement(new MaterialPageRoute(
          builder: (BuildContext context) => LectureDashboard()));
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
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColor.main_green_background,
      body: Container(
        width: width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: height * 0.1,
              ),
              Container(
                width: width * 0.5,
                child: Image(
                  image: AssetImage(AssetConfig.logo_svg),
                  fit: BoxFit.fitWidth,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                // padding: EdgeInsets.all(10),
                width: width * 0.8,
                child: Column(
                  children: [
                    Container(
                      width: width * 0.8,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                        ),
                        color: Color(0xff42725e),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "SE Inventory management",
                            style: AppTextStyle.loginPageTitle1,
                          ),
                        ],
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.only(top: 10, bottom: 5),
                        child: Text(
                          "Already have an account?",
                          style: AppTextStyle.loginPageTitle2,
                        )),
                    Container(
                      padding: EdgeInsets.all(8),
                      child: CustomStringInput(
                        hintText: "Username",
                        icon: Icon(Icons.person),
                        isEnable: true,
                        maxLetters: 40,
                        textEditingController: usernameController,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      child: CustomPasswordInput(
                        hintText: "Password",
                        icon: Icon(Icons.lock),
                        isEnable: true,
                        maxLetters: 8,
                        textEditingController: passwordController,
                      ),
                    ),
                    Container(
                      child: CustomButton(
                        onPressed: submitUsernameAndPassword,
                        text: "Log in",
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
