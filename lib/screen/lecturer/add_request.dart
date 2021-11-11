import 'package:flutter/material.dart';
import 'package:inventory_management/config/constant_data.dart';
import 'package:inventory_management/services/lecturer_api.dart';
import 'package:inventory_management/services/student_api.dart';
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
  bool isError = false;

  List<String> cList=[];
  List<String> mList=[];
  List<String> lList=[];
  List<String> sList=[];

  StudentApi studentApi = StudentApi();
  LecturerApi lecApi = LecturerApi();
  var lectureIdController = TextEditingController();

  @override
  void initState(){
    super.initState();
    updateCategory(studentApi.getCategory());
  }

  void updateCategory(dynamic data)async{
    List<dynamic>lst = await data;
    List<String> ls=[];
    for(var m in lst){
      ls.add(m.toString());
    }
    setState(() {
      cList=ls;
    });
  }

  void updateModel(dynamic data)async{
    List<dynamic>lst = await data;
    List<String> ls=[];
    for(var m in lst){
      ls.add(m.toString());
    }
    setState(() {
      mList=ls;
    });
  }

  void updateLab(dynamic data)async{
    List<dynamic>lst = await data;
    List<String> ls=[];
    for(var m in lst){
      ls.add(m.toString());
    }
    setState(() {
      lList=ls;
    });
  }

  void updateStoreCode(dynamic data)async{
    List<dynamic>lst = await data;
    List<String> ls=[];
    for(var m in lst){
      ls.add(m.toString());
    }
    setState(() {
      sList=ls;
    });
  }




  void toogleCategory(String category) {
    setState(() {
      updateModel(studentApi.getModel(category));
      selectedCategory = category;
      selectedModel = null;
      labName=null;
      selectedStoreCode= null;
    });
  }

  void toogleModel(String model) {
    updateLab(studentApi.getLab(model, selectedCategory));
    setState(() {
      selectedModel = model;
      labName=null;
      selectedStoreCode=null;
    });
  }

  void toogleLabName(String lbName) {
    //updateStoreCode(studentApi.getStoreCode(selectedCategory, selectedModel, lbName));
    //updateStoreCode(lecApi.getStoreCode(selectedCategory, selectedModel, lbName));
    updateStoreCode(studentApi.getStoreCode(selectedCategory, selectedModel, lbName));
    setState(() {
      labName = lbName;
      selectedStoreCode=null;
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

  void formSubmitHandler(){
    if(selectedCategory==null || selectedModel==null || labName==null || selectedStoreCode==null || lecturerId==null || fromDate==null || toDate==null){
      setState(() {
        isError = true;
      });
      print('Error');
    }else{
      print(selectedCategory);
      print(selectedModel);
      print(selectedStoreCode);
      print(lecturerId);
      print(fromDate);
      print(toDate);
      setState(() {
        selectedCategory=null;
        selectedModel=null;
        labName=null;
        selectedStoreCode= null;
        lectureIdController.clear();
        fromDate=null;
        toDate=null;
      });
    }
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
              value: labName,
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
                  Text('Lecturer Id',
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                  // Container(
                  //   width: 200,
                  //   child: TextField(
                  //     controller: lectureIdController,
                  //     decoration: InputDecoration(
                  //       fillColor: Colors.white,
                  //       filled: true,
                  //       isDense: true,
                  //       contentPadding: EdgeInsets.fromLTRB(5, 10, 10, 0),
                  //       border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.all(Radius.circular(0)),
                  //         borderSide: BorderSide.none,
                  //       ),
                  //     ),
                  //     style:
                  //         TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  //     onChanged: (value) {
                  //       lecturerId = value;
                  //     },
                  //   ),
                  // ),
                  Container(
                  padding: EdgeInsets.all(5),
                  color: Colors.white,
                  width: 200,
                  child: Text(ConstantData.USER_ID,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,),),
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
                formSubmitHandler();
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
