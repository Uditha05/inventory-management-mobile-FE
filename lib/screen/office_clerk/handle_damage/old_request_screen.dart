import 'package:flutter/material.dart';

class OldRequestScreen extends StatefulWidget {
  OldRequestScreen({Key key}) : super(key: key);

  @override
  _OldRequestScreenState createState() => _OldRequestScreenState();
}

class _OldRequestScreenState extends State<OldRequestScreen> {
  List upcoming = [];
  @override
  Widget build(BuildContext context) {
    return Body_Widget();
  }

  Widget Body_Widget() {
    if (upcoming.length == 0) {
      return Center(
        child: Container(
          child: Text("No Old Damage Request"),
        ),
      );
    } else {
      return Container(
        child: Column(
          children: [],
        ),
      );
    }
  }
}
