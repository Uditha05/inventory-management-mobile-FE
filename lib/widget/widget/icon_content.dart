import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IconContent extends StatelessWidget {
  final IconData icon;
  final Function onTap;

  IconContent({this.icon,this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xff342C2C),
        borderRadius: BorderRadius.circular(10),
      ),
      child: IconButton(
        icon: FaIcon(icon,size: 30, color: Colors.white,),
        onPressed: onTap,
      ),
    );
  }
}