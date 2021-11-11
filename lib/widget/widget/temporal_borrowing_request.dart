import 'package:flutter/material.dart';
import 'package:inventory_management/config/constant_data.dart';
import 'package:inventory_management/services/lecturer_api.dart';
import 'package:inventory_management/widget/widget/drop_down_list.dart';
import 'package:intl/intl.dart';

class TemporalBorrowingRequest extends StatefulWidget {


  @override
  _TemporalBorrowingRequestState createState() => _TemporalBorrowingRequestState();
}

class _TemporalBorrowingRequestState extends State<TemporalBorrowingRequest> {
  String selectedCategory;
  String selectedModel;
  String selectedStoreCode;
  String labName;
  String studentId;
  String fromDate;
  String toDate;
  bool isError=false;

  List<String> cList=[];
  List<String> mList=[];
  List<String> lList=[];
  List<String> sList=[];

  LecturerApi lecApi = LecturerApi();

  @override
  void initState(){
    super.initState();
    updateCategory(lecApi.getCategory());
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
      updateModel(lecApi.getModel(category));
      selectedCategory = category;
      selectedModel = null;
      labName=null;
      selectedStoreCode= null;
    });
  }

  void toogleModel(String model) {
    updateLab(lecApi.getLab(model, selectedCategory));
    setState(() {
      selectedModel = model;
      labName=null;
      selectedStoreCode=null;
    });
  }

  void toogleLabName(String lbName) {
    updateStoreCode(lecApi.getStoreCode(selectedCategory, selectedModel, lbName));
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


  void formSubmitHandler(){
    if(selectedCategory==null || selectedModel==null || labName==null || selectedStoreCode==null || studentId==null){
      setState(() {
        isError = true;
      });
      print('Error');
    }else{
      print(selectedCategory);
      print(selectedModel);
      print(labName);
      print(selectedStoreCode);
      print(studentId);
      lecApi.sendTemporyRequest({"studentId":ConstantData.USER_ID,"equipmentId":selectedStoreCode,"reason":'temporyStudent',"requestDate":fromDate,"returnDate":toDate});
      setState(() {
        selectedCategory=null;
        selectedModel=null;
        labName=null;
        selectedStoreCode=null;
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
          FormInput(title: 'Category',lst: cList,callback: toogleCategory,value: selectedCategory,),
          FormInput(title: 'Model',lst: mList,callback: toogleModel,value: selectedModel,),
          FormInput(title: 'Lab Name',lst: lList,callback: toogleLabName,value: labName,),
          FormInput(title:'StoreCode',lst: sList,callback: toogleStoreCode,value: selectedStoreCode,),
          Padding(
            padding: EdgeInsets.only(left: 15,right: 15,top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Student Id',style: TextStyle(color: Colors.white,fontSize: 20)),
                Container(
                  padding: EdgeInsets.all(5),
                  color: Colors.white,
                  width: 200,
                  child: Text(ConstantData.USER_ID,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,),),
                ),
              ],
            ),
          ),
          FixDateInput('From Date'),
          FixDateInput('To Date'),
          SizedBox(height: 20,),
          (isError)?Text('Error occur',style: TextStyle(color: Colors.red,fontSize: 20),):Text(''),
          FlatButton(
            child: Text(
              'Submit',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            color: Color(0xff69C0A1),
            onPressed: (){
              formSubmitHandler();
            },
          )
        ],
      ),
    );
  }
}

class FixDateInput extends StatelessWidget {
  final String title;
  FixDateInput(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      //padding: EdgeInsets.only(left: 15,right: 15,top: 10),
      padding: EdgeInsets.only(left: 15,right: 15,top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,style: TextStyle(color: Colors.white,fontSize: 20)),
          Container(
            padding: EdgeInsets.all(5),
            color: Colors.white,
            width: 200,
            child: Text(
              DateFormat('dd/MM/yyyy').format(DateTime.now()),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FormInput extends StatelessWidget {
  const FormInput({this.title,this.lst,this.callback,this.value});
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