import 'package:flutter/material.dart';
import 'package:inventory_management/config/constant_data.dart';
import 'package:inventory_management/services/lecturer_api.dart';
import 'package:inventory_management/widget/widget/drop_down_list.dart';
import 'package:inventory_management/widget/widget/date_picker.dart';
import 'package:intl/intl.dart';

class NormalBorrowingRequest extends StatefulWidget {
  @override
  _NormalBorrowingRequestState createState() => _NormalBorrowingRequestState();
}

class _NormalBorrowingRequestState extends State<NormalBorrowingRequest> {
  String selectedCategory;
  String selectedModel;
  String selectedStoreCode;
  String selectedlabName;
  String fromDate;
  String toDate;
  String selectedLecturer;
  String selectedLecturerId;
  bool isError = false;

  List<String> cList = [];
  List<String> mList = [];
  List<String> lList = [];
  List<String> sList = [];
  List<String> lecList = [];
  List<String> lecIdList = [];

  LecturerApi lecApi = LecturerApi();

  @override
  void initState() {
    super.initState();
    updateCategory(lecApi.getCategory());
  }

  void updateCategory(dynamic data) async {
    List<dynamic> lst = await data;
    List<String> ls = [];
    for (var m in lst) {
      ls.add(m.toString());
    }

    setState(() {
      cList = ls;
    });
  }

  void updateModel(dynamic data) async {
    List<dynamic> lst = await data;
    List<String> ls = [];
    for (var m in lst) {
      ls.add(m.toString());
    }
    setState(() {
      mList = ls;
    });
  }

  void updateLab(dynamic data) async {
    List<dynamic> lst = await data;
    List<String> ls = [];
    for (var m in lst) {
      ls.add(m.toString());
    }
    setState(() {
      lList = ls;
    });
  }

  void updateStoreCode(dynamic data) async {
    List<dynamic> lst = await data;
    List<String> ls = [];
    for (var m in lst) {
      ls.add(m.toString());
    }
    setState(() {
      sList = ls;
    });
  }

  void updateLecturerList(dynamic data) async {
    List<dynamic> lst = await data;
    List<String> ls = [];
    List<String> idls = [];
    for (var m in lst[0]) {
      ls.add(m.toString());
    }
    for (var m in lst[1]) {
      idls.add(m.toString());
    }
    setState(() {
      lecList = ls;
      lecIdList = idls;
    });
  }

  void toogleCategory(String category) {
    setState(() {
      updateModel(lecApi.getModel(category));
      selectedCategory = category;
      selectedModel = null;
      selectedlabName = null;
      selectedStoreCode = null;
      selectedLecturer = null;
    });
  }

  void toogleModel(String model) {
    updateLab(lecApi.getLab(model, selectedCategory));
    setState(() {
      selectedModel = model;
      selectedlabName = null;
      selectedStoreCode = null;
      selectedLecturer = null;
    });
  }

  void toogleLabName(String labName) {
    updateStoreCode(
        lecApi.getStoreCode(selectedCategory, selectedModel, labName));
    setState(() {
      selectedlabName = labName;
      selectedStoreCode = null;
      selectedLecturer = null;
    });
  }

  void toogleStoreCode(String storeCode) {
    updateLecturerList(lecApi.getLecturers(selectedlabName));
    setState(() {
      selectedStoreCode = storeCode;
    });
  }

  void toogleFromDate(DateTime date) {
    setState(() {
      fromDate = DateFormat('MM/dd/yyyy').format(date);
    });
  }

  void toogleToDate(DateTime date) {
    setState(() {
      toDate = DateFormat('MM/dd/yyyy').format(date);
    });
  }

  void toogleLecturer(String lecturer) {
    int idex = lecList.indexOf(lecturer);
    setState(() {
      selectedLecturer = lecturer;
      selectedLecturerId = lecIdList[idex];
    });
  }

  void formSubmitHandler() {
    if (selectedCategory == null ||
        selectedModel == null ||
        selectedlabName == null ||
        selectedStoreCode == null ||
        fromDate == null ||
        toDate == null ||
        selectedLecturer == null) {
      setState(() {
        isError = true;
      });
      print('Error');
    } else {
      // print(selectedCategory);
      // print(selectedModel);
      // print(selectedStoreCode);
      // print(ConstantData.USER_ID);
      // print(fromDate);
      // print(toDate);
      // print(selectedLecturer);
      // print(selectedLecturerId);
      lecApi.sendNormalRequest({
        "studentId": ConstantData.USER_ID,
        "lecId": selectedLecturerId,
        "equipmentId": selectedStoreCode,
        "requestDate": fromDate,
        "returnDate": toDate,
        "model": selectedModel,
        "category": selectedCategory
      });
      setState(() {
        selectedCategory = null;
        selectedModel = null;
        selectedStoreCode = null;
        fromDate = null;
        toDate = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          FormInput(
            title: 'Category',
            lst: cList,
            callback: toogleCategory,
            value: selectedCategory,
          ),
          FormInput(
            title: 'Model',
            lst: mList,
            callback: toogleModel,
            value: selectedModel,
          ),
          FormInput(
            title: 'Lab Name',
            lst: lList,
            callback: toogleLabName,
            value: selectedlabName,
          ),
          FormInput(
            title: 'StoreCode',
            lst: sList,
            callback: toogleStoreCode,
            value: selectedStoreCode,
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Student Id',
                    style: TextStyle(color: Colors.white, fontSize: 20)),
                Container(
                  padding: EdgeInsets.all(5),
                  color: Colors.white,
                  width: 200,
                  child: Text(
                    ConstantData.USER_ID,
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
          FormInput(
            title: 'Lecturer',
            lst: lecList,
            callback: toogleLecturer,
            value: selectedLecturer,
          ),
          SizedBox(
            height: 20,
          ),
          (isError)
              ? Text(
                  'Error occur',
                  style: TextStyle(color: Colors.red, fontSize: 20),
                )
              : Text(''),
          FlatButton(
            child: Text(
              'Submit',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            color: Color(0xff69C0A1),
            onPressed: () {
              formSubmitHandler();
            },
          )
        ],
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
