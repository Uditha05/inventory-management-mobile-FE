import 'package:flutter/material.dart';

class DropDownPicker extends StatelessWidget {

  final List<String> lecturers;
  final Function toogleLecturer;
  final String value;
  DropDownPicker(this.lecturers,this.toogleLecturer,this.value);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(0),
      ),
      width: 200,
      height: 30,
      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
      child: DropdownButton<String>(
        value: value,
        icon: Icon(Icons.arrow_drop_down, color: Colors.black,),
        isExpanded: true,
        items: lecturers.map(buildMenuItem).toList(),
        // onChanged: (value)=> setState(()=> this.value=value),
        onChanged: (val)=>toogleLecturer(val),
      ),
    );
  }
  DropdownMenuItem<String> buildMenuItem(String lec)=> DropdownMenuItem(
    value: lec,
    child: Text(
      lec,
      style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
    ),
  );
}

