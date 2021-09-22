import 'package:flutter/material.dart';

class ButtonHeaderWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonHeaderWidget({
    Key key,
    @required this.text,
    @required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => HeaderWidget(
    child: ButtonWidget(
      text: text,
      onClicked: onClicked,
    ),
  );
}

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    Key key,
    @required this.text,
    @required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
    style: ElevatedButton.styleFrom(
      minimumSize: Size.fromHeight(30),
      primary: Colors.white,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0),),
      ),
    child: FittedBox(
      fit: BoxFit.fill,
      child: Text(
        text,
        style: TextStyle(fontSize: 18, color: Colors.black),
      ),
    ),
    onPressed: onClicked,
  );
}

class HeaderWidget extends StatelessWidget {
  final Widget child;
  const HeaderWidget({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      child,
    ],
  );
}
