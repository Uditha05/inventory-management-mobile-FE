import 'package:flutter/material.dart';
import 'package:inventory_management/config/asset_config.dart';
import 'package:inventory_management/theme/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
                        maxLetters: 15,
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
                        onPressed: () {},
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
