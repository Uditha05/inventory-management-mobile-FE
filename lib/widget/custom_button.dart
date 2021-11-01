import 'package:flutter/material.dart';
import 'package:inventory_management/theme/app_colors.dart';
import 'package:inventory_management/theme/app_text_style.dart';

class CustomButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  CustomButton({Key key, this.onPressed, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            color: AppColor.main_green_background,
          ),
          padding: EdgeInsets.all(13),
          child: Text(
            text,
            style: AppTextStyle.loginButtonText,
          )

          // RaisedButton(

          //   onPressed: onPressed,
          //   color: AppColor.main_green_background,
          //   padding: EdgeInsets.all(5),
          //   child: ,
          // ),
          ),
    );
  }
}
