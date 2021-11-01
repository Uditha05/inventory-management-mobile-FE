import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management/model/item.dart';
import 'package:inventory_management/widget/widget/date_picker.dart';
import 'package:inventory_management/widget/widget/drop_down_list.dart';


class AddRequest extends StatefulWidget {
  final Item itemDetail;
  final String type;
  AddRequest({this.itemDetail,this.type});

  @override
  _AddRequestState createState() => _AddRequestState();
}

class _AddRequestState extends State<AddRequest> {
  String studentId;
  DateTime date;
  String fromDate;
  String toDate;
  String selectedLecturer;
  final lecturers = ['Lecturer0','Lecturer1','Lecturer2'];
  void toogleFromDate(DateTime date){
    setState(() {
      fromDate= DateFormat('dd/MM/yyyy').format(date);
    });
  }
  void toogleToDate(DateTime date){
    setState(() {
      toDate= DateFormat('dd/MM/yyyy').format(date);
    });
  }
  void toogleLecturer(String lecturer){
    setState(() {
      selectedLecturer = lecturer;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff003e29),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Color(0xff3B885B),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FormItem(title: 'Category',placeholder: widget.itemDetail.category,),
            SizedBox(height: 10,),
            FormItem(title: 'Model',placeholder: widget.itemDetail.model,),
            SizedBox(height: 10,),
            FormItem(title: 'Store Code', placeholder: widget.itemDetail.storeCode,),
            SizedBox(height: 10,),
            FormItem(title: 'Lab Name',placeholder: widget.itemDetail.labName,),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                widget.type == 'student' ?Text('Student ID',style: TextStyle(color: Colors.white,fontSize: 20)) : Text('Lecturer ID',style: TextStyle(color: Colors.white,fontSize: 20),),
                Container(
                  width: 200,
                  child: TextField(
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      isDense: true,
                      contentPadding: EdgeInsets.fromLTRB(5, 10, 10, 0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0)),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                    onChanged: (value){studentId=value;},
                  ),
                ),
              ],
            ),
            SizedBox(height: 0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('From Date',style: TextStyle(color: Colors.white,fontSize: 20),),
                Container(
                    width: 200,
                    child: DatePickerWidget(fromDate, toogleFromDate),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('To Date',style: TextStyle(color: Colors.white,fontSize: 20),),
                Container(
                    width: 200,
                    child: DatePickerWidget(toDate,toogleToDate),
                ),
              ],
            ),
            SizedBox(height: 5,),
            widget.type == 'student'?
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Lecturer',style: TextStyle(color: Colors.white,fontSize: 20),),
                DropDownPicker(lecturers,toogleLecturer,selectedLecturer),
              ],
            ) : SizedBox(height: 0,),
            SizedBox(height: 10,),
            FlatButton(
              child: Text(
                'Submit',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              color: Color(0xff69C0A1),
              onPressed: (){
                print(studentId);
                print(fromDate);
                print(toDate);
                print(widget.itemDetail);
                print(selectedLecturer);
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ),
    );
  }
}

class FormItem extends StatelessWidget {
  const FormItem({this.title,this.placeholder});
  final String title;
  final String placeholder;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,style: TextStyle(color: Colors.white,fontSize: 20),),
        Container(
          padding: EdgeInsets.all(5),
          color: Colors.white,
          width: 200,
          child: Text(placeholder,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,),),
        ),
      ],
    );
  }
}

