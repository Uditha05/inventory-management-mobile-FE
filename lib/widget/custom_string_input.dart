import 'package:flutter/material.dart';
import 'package:inventory_management/theme/app_colors.dart';

class CustomStringInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final int maxLetters;
  final String hintText;
  final Icon icon;
  final bool isEnable;

  CustomStringInput(
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
      padding: EdgeInsets.only(top: 5, right: 5, left: 5),
      child: TextField(
        controller: textEditingController,
        keyboardType: TextInputType.text,
        maxLength: maxLetters,
        enabled: isEnable,
        maxLengthEnforced: true,
        autofocus: false,
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
