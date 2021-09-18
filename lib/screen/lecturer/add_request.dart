import 'package:flutter/material.dart';
import 'package:inventory_management/theme/app_colors.dart';
import 'package:intl/intl.dart';
import 'package:inventory_management/widget/widget/date_picker.dart';
import 'package:inventory_management/widget/widget/drop_down_list.dart';

class AddRequest extends StatefulWidget {
  @override
  _AddRequestState createState() => _AddRequestState();
}

class _AddRequestState extends State<AddRequest> {
  String selectedCategory;
  String selectedModel;
  String selectedStoreCode;
  String labName;
  String lecturerId;
  String fromDate;
  String toDate;

  final categoryList = ['category0', 'category1', 'category2'];
  final modelList = ['model0', 'model1', 'model2'];
  final storeCodeList = ['storeCode0', 'storeCode1', 'storeCode2'];


  void toogleCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  void toogleModel(String model) {
    setState(() {
      selectedModel = model;
    });
  }

  void toogleStoreCode(String storeCode) {
    setState(() {
      selectedStoreCode = storeCode;
    });
  }

  void toogleFromDate(DateTime date) {
    setState(() {
      fromDate = DateFormat('dd/MM/yyyy').format(date);
    });
  }

  void toogleToDate(DateTime date) {
    setState(() {
      toDate = DateFormat('dd/MM/yyyy').format(date);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.main_green_background,
      appBar: AppBar(
        title: Text('Add Borrowing Request'),
        backgroundColor: AppColor.main_green_background,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            FormInput(
              title: 'Category',
              lst: categoryList,
              callback: toogleCategory,
              value: selectedCategory,
            ),
            FormInput(
              title: 'Model',
              lst: modelList,
              callback: toogleModel,
              value: selectedModel,
            ),
            FormInput(
              title: 'StoreCode',
              lst: storeCodeList,
              callback: toogleStoreCode,
              value: selectedStoreCode,
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Lab Name',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    color: Colors.white,
                    width: 200,
                    child: Text(
                      'Lab0',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Lecturer Id',
                      style: TextStyle(color: Colors.white, fontSize: 20)),
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
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      onChanged: (value) {
                        lecturerId = value;
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              //padding: EdgeInsets.only(left: 15,right: 15,top: 10),
              padding: EdgeInsets.only(left: 15, right: 15, top: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('From Date',
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                  Container(
                    width: 200,
                    child: DatePickerWidget(fromDate, toogleFromDate),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15, top: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'To Date',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Container(
                    width: 200,
                    child: DatePickerWidget(toDate, toogleToDate),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            FlatButton(
              child: Text(
                'Submit',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              color: Color(0xff69C0A1),
              onPressed: () {
                print(selectedCategory);
                print(selectedModel);
                print(selectedStoreCode);
                print(lecturerId);
                print(fromDate);
                print(toDate);
              },
            )
          ],
        ),
      ),
    );
  }
}

class FormInput extends StatelessWidget {
  const FormInput({this.title, this.lst, this.callback, this.value});

  final String title;
  final List lst;
  final Function callback;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 15, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          DropDownPicker(lst, callback, value),
        ],
      ),
    );
  }
}
