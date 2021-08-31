import 'package:flutter/material.dart';
import 'package:inventory_management/theme/app_colors.dart';

class CustomPasswordInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final int maxLetters;
  final String hintText;
  final Icon icon;
  final bool isEnable;

  CustomPasswordInput(
      {Key key,
      this.textEditingController,
      this.hintText,
      this.icon,
      this.isEnable,
      this.maxLetters})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: TextField(
        controller: textEditingController,
        keyboardType: TextInputType.visiblePassword,
        maxLength: maxLetters,
        enabled: isEnable,
        maxLengthEnforced: true,
        autofocus: false,
        obscureText: true,
        autocorrect: false,
        textAlignVertical: TextAlignVertical.center,
        enableSuggestions: true,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          filled: true,
          prefixIcon: icon,
          fillColor: AppColor.input_fill,
          contentPadding: const EdgeInsets.only(left: 14.0, top: 3),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(8.0),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(8.0),
          ),
          disabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }
}
