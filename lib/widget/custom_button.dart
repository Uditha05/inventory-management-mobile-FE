import 'package:flutter/material.dart';
import 'package:inventory_management/theme/app_colors.dart';
import 'package:inventory_management/theme/app_text_style.dart';

class CustomButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  CustomButton({Key key, this.onPressed, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        color: AppColor.main_green_background,
        onPressed: onPressed,
        padding: EdgeInsets.all(5),
        child: Text(
          text,
          style: AppTextStyle.loginButtonText,
        ),
      ),
    );
  }
}
