import 'date_button.dart';
import 'package:flutter/material.dart';

class DatePickerWidget extends StatelessWidget {
  final String txt;
  final Function toogleDate;

  DatePickerWidget(this.txt, this.toogleDate);
  @override
  Widget build(BuildContext context) => ButtonHeaderWidget(
        text: txt == null ? 'Select Date' : txt,
        onClicked: () => pickDate(context),
      );
  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day),
      lastDate: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day + 5),
    );

    if (newDate == null) return;

    toogleDate(newDate);
  }
}
