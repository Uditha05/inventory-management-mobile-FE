import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:inventory_management/screen/student/tile_style.dart';
class Button extends StatelessWidget {
  final String text;
  final Color color;

  Button({this.text, this.color });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Center(
        child: Text(
          text,
          style: buttonText,
        ),
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
