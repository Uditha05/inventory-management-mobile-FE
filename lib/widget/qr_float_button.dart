import 'package:flutter/material.dart';

class Fab extends StatelessWidget {
  const Fab({Key key, this.onTap, this.child}) : super(key: key);
  final Function onTap;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            // color: AppColors.primaryColor.withOpacity(0.5),
            // spreadRadius: 5,
            blurRadius: 10,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: FloatingActionButton(
        backgroundColor: Color(0xff1CB084),
        onPressed: onTap,
        child: child,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 0,
        focusElevation: 0,
        disabledElevation: 0,
        highlightElevation: 0,
      ),
    );
  }
}
