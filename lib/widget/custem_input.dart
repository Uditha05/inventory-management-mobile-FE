import 'package:flutter/material.dart';

import 'custom_string_input.dart';

class InputFeildType extends StatelessWidget {
  final String name;
  final Icon icon;
  final bool isEnable;
  final TextEditingController textEditingController;
  final Function onchange;
  const InputFeildType(
      {Key key,
      this.name,
      this.isEnable,
      this.textEditingController,
      this.icon,
      this.onchange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      child: Column(
        children: [
          Text(
            name,
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          CustomStringInput(
            hintText: name,
            icon: icon,
            isEnable: isEnable,
            maxLetters: 15,
            textEditingController: textEditingController,
            onchange: onchange,
          ),
        ],
      ),
    );
  }
}
